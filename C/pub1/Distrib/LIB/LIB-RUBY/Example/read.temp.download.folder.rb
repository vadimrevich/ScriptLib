#!ruby.exe
#**********************************************************
#* read.temp.download.folder
#*********************************************************/

require 'tmpdir'
require 'win32/registry'

###
# getDownloadFolder
###
def getDownloadFolder
    shcu_node = "SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Explorer\\Shell Folders";
    fo_downloads = "{374DE290-123F-4565-9164-39C4925E467B}"
    Win32::Registry::HKEY_CURRENT_USER.open(shcu_node) do |regnode|
        value = regnode[fo_downloads]
        return value
    end
end

###
# getTempEnviron
###
def getTempEnviron
    fo_temp = Dir::tmpdir()
    return fo_temp
end

puts getDownloadFolder()
puts getTempEnviron()
