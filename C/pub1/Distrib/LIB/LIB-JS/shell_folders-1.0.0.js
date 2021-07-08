/***
 *
 * shell_folders.js
 * A Header File for Folder Manipulated Scrips Using Registry
 * Uses a Register Node HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders
 *
 **/
var SHCU_NODE = "HKCU\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Explorer\\Shell Folders\\";
var SHLM_NODE = "HKLM\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Explorer\\Shell Folders\\";
var FO_AppData = "AppData";
var FO_LocalAppData = "Local AppData";
var FO_CDBurning = "CD Burning";
var FO_Libraries = "{1B3EA5DC-B587-4786-B4EF-BD1DC332AEAE}";
var FO_MyVideo ="My Video";
var FO_MyPictures = "My Pictures";
var FO_Desktop = "Desktop";
var FO_History = "History";
var FO_NetHood = "NetHood";
var FO_Contacts = "{56784854-C6CB-462B-8169-88E350ACB882}";
var FO_RoamingTiles = "{00BCFC5A-ED94-4E48-96A1-3F6217F21990}";
var FO_Cookies ="Cookies";
var FO_Favorites = "Favorites";
var FO_SendTo = "SendTo";
var FO_StartMenu = "Start Menu";
var FO_MyMusic = "My Music";
var FO_Programs = "Programs";
var FO_Recent = "Recent";
var FO_PrintHood = "PrintHood";
var FO_Searches = "{7D1D3A04-DEBB-4115-95CF-2F29DA2920DA}";
var FO_Downloads = "{374DE290-123F-4565-9164-39C4925E467B}";
var FO_LocalLow = "{A520A1A4-1780-4FF6-BD18-167343C5AF16}";
var FO_Startup = "Startup";
var FO_AdministrativeTools = "Administrative Tools";
var FO_Personal = "Personal"; //My Documents
var FO_Links = "{BFB9D5E0-C6A9-404C-B2B2-AE6DB6AF4968}";
var FO_Cache = "Cache";
var FO_Templates = "Templates";
var FO_SavedGames = "{4C5C32FF-BB9D-43B0-B5B4-2D72E54EAAA4}";
var FO_Fonts = "Fonts";
var FO_CommonAdministrativeTools = "Common Administrative Tools";
var FO_CommonAppData = "Common AppData";
var FO_CommonDesktop ="Common Desktop";
var FO_CommonDocuments = "Common Documents";
var FO_CommonPrograms = "Common Programs";
var FO_CommonStartMenu = "Common Start Menu";
var FO_CommonStartup = "Common Startup";
var FO_CommonTemplates = "Common Templates";
var FO_CommonMusic = "CommonMusic";
var FO_CommonPictures = "CommonPictures";
var FO_CommonVideo = "CommonVideo";
var FO_OEMLinks = "OEM Links";

// Derivative Variables
var SHCU_AppData = SHCU_NODE + FO_AppData;
var SHCU_LocalAppData = SHCU_NODE + FO_LocalAppData;
var SHCU_CDBurning = SHCU_NODE + FO_CDBurning;
var SHCU_Libraries = SHCU_NODE + FO_Libraries;
var SHCU_MyVideo = SHCU_NODE + FO_MyVideo;
var SHCU_MyPictures = SHCU_NODE + FO_MyPictures;
var SHCU_Desktop = SHCU_NODE + FO_Desktop;
var SHCU_History = SHCU_NODE + FO_History;
var SHCU_NetHood = SHCU_NODE + FO_NetHood;
var SHCU_Contacts = SHCU_NODE + FO_Contacts;
var SHCU_RoamingTiles = SHCU_NODE + FO_RoamingTiles;
var SHCU_Cookies = SHCU_NODE + FO_Cookies;
var SHCU_Favorites = SHCU_NODE + FO_Favorites;
var SHCU_SendTo = SHCU_NODE + FO_SendTo;
var SHCU_StartMenu = SHCU_NODE + FO_StartMenu;
var SHCU_MyMusic = SHCU_NODE + FO_MyMusic;
var SHCU_Programs = SHCU_NODE + FO_Programs;
var SHCU_Recent = SHCU_NODE + FO_Recent;
var SHCU_PrintHood = SHCU_NODE + FO_PrintHood;
var SHCU_Searches = SHCU_NODE + FO_Searches;
var SHCU_Downloads = SHCU_NODE + FO_Downloads;
var SHCU_LocalLow = SHCU_NODE + FO_LocalLow;
var SHCU_Startup = SHCU_NODE + FO_Startup;
var SHCU_AdministrativeTools = SHCU_NODE + FO_AdministrativeTools;
var SHCU_Personal = SHCU_NODE + FO_Personal; //My Documents
var SHCU_Links = SHCU_NODE + FO_Links;
var SHCU_Cache = SHCU_NODE + FO_Cache;
var SHCU_Templates = SHCU_NODE + FO_Templates;
var SHCU_SavedGames = SHCU_NODE + FO_SavedGames;
var SHCU_Fonts = SHCU_NODE + FO_Fonts;

var SHLM_CommonAdministrativeTools = SHLM_NODE + FO_CommonAdministrativeTools;
var SHLM_CommonAppData = SHLM_NODE + FO_CommonAppData;
var SHLM_CommonDesktop = SHLM_NODE + FO_CommonDesktop;
var SHLM_CommonDocuments = SHLM_NODE + FO_CommonDocuments;
var SHLM_CommonPrograms = SHLM_NODE + FO_CommonPrograms;
var SHLM_CommonStartMenu = SHLM_NODE + FO_CommonStartMenu;
var SHLM_CommonStartup = SHLM_NODE + FO_CommonStartup;
var SHLM_CommonTemplates = SHLM_NODE + FO_CommonTemplates;
var SHLM_CommonMusic = SHLM_NODE + FO_CommonMusic;
var SHLM_CommonPictures = SHLM_NODE + FO_CommonPictures;
var SHLM_CommonVideo = SHLM_NODE + FO_CommonVideo;
var SHLM_OEMLinks = SHLM_NODE + FO_OEMLinks;

