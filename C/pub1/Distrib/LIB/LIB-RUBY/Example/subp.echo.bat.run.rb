#!ruby.exe
#* ********************************************************
#* subp.echo.bat.run.php
#* This Script will Run a echo-hello.bat Tool
#*********************************************************/

require 'open3'

# Setup Command Interpreter
pathCMD = ENV['SystemRoot'] + "\\System32"
cmdEXE = pathCMD + "\\" + "cmd.exe"
aBatFile = "echo-hello.bat"
# aStartCmd = "Start /b "
aStartCmd = cmdEXE + " /c "
aStartPath = ENV['USERPROFILE']
aBatPath = aStartPath + "\\" + aBatFile
if File.directory?(pathCMD) then
    if File.file?(cmdEXE) then
        strValue = aStartCmd + aBatPath
        # puts aBatPath
        if File.file?(aBatPath) then
            stdout,stderr,status=Open3.capture3(strValue)
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