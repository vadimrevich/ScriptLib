#!python
#from subprocess import run, Popen, PIPE
import subprocess
from sys import executable
import os
# python import local file

# Setup Command Interpreter
pathCMD = os.environ['SystemRoot'] + "\\System32"
CMDEXE = pathCMD + "\\" + "cmd.exe"
pingHost = "localhost"
if os.path.isfile(CMDEXE):
    strValue = "echo-hello.bat"
    # strValue = "ping.exe -n 4 -6 "
    # strParam = " /k ping.exe -n 4 "
    result = subprocess.run( strValue, capture_output=True, encoding='cp866', shell=True)
    # result = subprocess.check_output("ping.exe localhost", stdin=None, stderr=True, shell=True)
    print( result.stdout )
    print("Error Code: ", result.returncode)
else:
    print("Error Check Integrity")