<%@ webhandler language="C#" class="DownloadFile.DownloadFile" Debug="true" %>

using System;
using System.Web;
using System.IO;
using System.Reflection;
using System.Web.UI;

namespace DownloadFile
{
    public class DownloadFile : IHttpHandler
    {
        private string filename;
        private long filesize;
        private string webRootPath;
        private string httpRootPath;

        // public bool IsReusable => throw new NotImplementedException();
        public bool IsReusable
        {
            get
            {
                return false;
            }
        }

        /// <summary>
        /// Вам потребуется настроить этот модуль в файле Web.config вашего
        /// веб-сайта и зарегистрировать его с помощью IIS, чтобы затем воспользоваться им.
        /// см. на этой странице: https://go.microsoft.com/?linkid=8101007
        /// </summary>
        #region IHttpModule Members

        public void Dispose()
        {
            //удалите здесь код.
        }

        public void Init(HttpApplication context)
        {
            // Ниже приводится пример обработки события LogRequest и предоставляется 
            // настраиваемая реализация занесения данных
            context.LogRequest += new EventHandler(OnLogRequest);

            filename = "";
            filesize = 0;
            webRootPath = "";
            httpRootPath = "";
        }

        #endregion

        public void OnLogRequest(Object source, EventArgs e)
        {
            //здесь можно разместить логику занесения данных
        }

        public void ProcessRequest(HttpContext context)
        {
            System.Web.HttpResponse response = System.Web.HttpContext.Current.Response;
            System.Web.HttpRequest request = System.Web.HttpContext.Current.Request;
            setFileName();
            if (setAlertIfEmpty() > 0)
            {
                response.ClearContent();
                response.Clear();
                response.Write("<p>The file variable is empty.</p>");
                response.Write("<p>A Local Path = " + webRootPath + ".</p>");
                response.Write("<p>A Remote Path = " + httpRootPath + ".</p>");
                response.Flush();
                response.End();
                request.Abort();
                return;
            }
            response.ClearContent();
            response.Clear();
            response.ContentType = "application/octet-stream";
            response.AppendHeader("Pragma", "public");
            response.AppendHeader("Expires", "0");
            response.AppendHeader("Cache-Control", "must-revalidate, post-check=0, pre-check=0");
            response.AppendHeader("Cache-Control", "private");
            response.AppendHeader("Content-Disposition",
                               "attachment; filename=" + filename + ";");
            response.AppendHeader("Content-Transfer-Encoding:", "binary");
            // response.AppendHeader("Content-Length:", filesize.ToString());
            response.TransmitFile(request.MapPath(filename));
            response.Flush();
            response.End();
            request.Abort();
            return;
        }

        private void setFileName()
        {
            string aLocalPath;
            string aFilename, dirName;
            // dirName = Path.GetDirectoryName(Assembly.GetEntryAssembly().Location);
            // dirName = Assembly.GetExecutingAssembly().Location;
            dirName = Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location);
            // dirName = getCurrentUrlPath();
            if (dirName.Length == 0)
            {
                filename = "";
                return;
            }
            try
            {
                aFilename = HttpContext.Current.Request.QueryString["file"];
            }
            catch (Exception e)
            {
                System.Web.UI.Page page = HttpContext.Current.Handler as Page;
                if (page != null)
                {
                    string anAlert = e.Message + "\nError! Parameter \'file\' not found";
                    ScriptManager.RegisterClientScriptBlock(page, page.GetType(), "alertMessage", "alert(anAlert)", true);
                }
                filename = "";
                aFilename = "";
                return;
            }
            if (aFilename.Length == 0)
            {
                filename = "";
                return;
            }
            //aLocalPath = dirName + "\\" + aFilename;
            // filename = aLocalPath;
            aLocalPath = getAbsoluteFilePath(aFilename);
            if(aLocalPath.Length == 0)
            {
                filename = "";
            }
            else
            {
                filename = aFilename;
            }
            return;
        }

        private int setAlertIfEmpty()
        {
            if(filename.Length == 0)
            {
                System.Web.UI.Page page = HttpContext.Current.Handler as Page;
                if(page != null)
                {
                    ScriptManager.RegisterClientScriptBlock(page, page.GetType(), "alertMessage", "alert('Error! File not Found at Current Directory.')", true);
                    return 1;
                }
                return 2;
            }
            return 0;
        }

        public void getWebRootDir()
        {

        }

        private string getCurrentUrlPath()
        {
            string anURL = HttpContext.Current.Request.Url.AbsoluteUri;
            string anUrlTemp, anUrlDir;
            int lastInx1 = anURL.LastIndexOf('?');
            int lastInx2;
            if( lastInx1 > 0)
            {
                anUrlTemp = anURL.Substring(0, lastInx1);
            }
            else
            {
                return "";
            }
            lastInx2 = anUrlTemp.LastIndexOf('/');
            if(lastInx2 > 0)
            {
                anUrlDir = anUrlTemp.Substring(0, lastInx2);
                return anUrlDir;
            }
            else
            {
                return "";
            }
        }

        private string getAbsoluteFilePath( string aFileName)
        {
            string aLocalPath;
            string curWebDir = getCurrentUrlPath();
            httpRootPath = curWebDir + "/" + aFileName;
            System.Web.HttpRequest request = System.Web.HttpContext.Current.Request;
            try
            {
                aLocalPath = request.MapPath(aFileName);
            }
            catch(Exception e)
            {
                filesize = 0;
                aLocalPath = "";
                return "";
            }
            webRootPath = aLocalPath;            
            if(File.Exists(aLocalPath))
            {
                filesize = new System.IO.FileInfo(aLocalPath).Length;
                return aLocalPath;
            }
            else
            {
                filesize = 0;
                return "";
            }
        }

    }
}
