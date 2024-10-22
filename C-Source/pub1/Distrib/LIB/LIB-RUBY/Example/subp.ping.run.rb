#!ruby.exe
#* ********************************************************
#* subp.ping.run.php
#* This Script will Run a ping.exe Tool
#*********************************************************/

require 'open3'

# Setup Command Interpreter
pathCMD = ENV['SystemRoot'] + "\\System32"
cmdEXE = pathCMD + "\\" + "cmd.exe"
# pingHost = "localhost"
# aPingCmd = " -n 4 -6 "
pingHost = "google.com"
aPingCmd = " -n 4 -4 "
aPingExe = pathCMD + "\\ping.exe"
if File.directory?(pathCMD) then
    if File.file?(cmdEXE) then
        strValue = aPingCmd + pingHost
        # puts aPingExe
        if File.file?(aPingExe) then
            stdout,stderr,status=Open3.capture3(aPingExe + strValue)
            puts "\nSTDOUT=\n"
            puts stdout
            puts "\nSTDERR=\n"
            puts stderr
            puts "\nResult: #{status.exitstatus}"
        else
            puts "\nA File #aPingExe is not Found."
        end
    else
        puts "\nA File #cmdExe is not Found."
    end
else
    puts "\nA Folder #pathCMD is not Found."
end