#!C:/tools/ruby34/bin/ruby.exe
# frozen_string_literal: true

# show_usedirectory_path.rb
# This script will print a Users's System Directory path
#
# Usage:
#   ruby show_usedirectory_path.rb

### Needs gem install win32-registry

# require 'logger' # для логирования
# require 'win32key'
require 'tmpdir'
require 'win32/registry'

# Set Vriables
# $input_path = 'input.txt'
# $output_file = 'output.txt'

# main function
def main
  
  # Start payload
  puts "Start payload..."

  myDownloadsPath=get_downloads_directory()
  myDocumentspath=get_documents_directory()
  myDesktoppath=get_desktop_directory()
  currentDir=Dir.pwd
  scriptDirectory=__dir__
  tempdir=get_temp_directory()
  myUserProfile=get_userprofile_directory()

  puts "User Profile Dir is " + myUserProfile
  puts "Downloads Path is " + myDownloadsPath
  puts "Documents Path is " + myDocumentspath
  puts "Desktop Path is " + myDesktoppath
  puts "Current Dirctory: " + currentDir
  puts "Current Script directory: " + scriptDirectory
  puts "Temporary dir: " + tempdir

  puts "The end of the script " + __FILE__
end

def get_downloads_directory()

  regKeyNode='{374DE290-123F-4565-9164-39C4925E467B}'
  key_path = "SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Explorer\\User Shell Folders"

  registry = Win32::Registry::HKEY_CURRENT_USER

  key = registry.open(key_path)
  if key.nil?
    puts "Failed to open registry key"
  end

  path = key.read(regKeyNode)
  key.close()

  # Если путь не найден в реестре, используем стандартную папку
  if path.nil? || path.to_s.strip.empty?
    path = File.join(ENV['USERPROFILE'], "Downloads")
  end

  path1=path[1]

  if !Dir.exist?(path1) then
    path1=""
  end

  path1 = path1.gsub("\\", "/")
  path1
end

def get_documents_directory()

  regKeyNode='Personal'
  key_path = "SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Explorer\\User Shell Folders"

  registry = Win32::Registry::HKEY_CURRENT_USER

  key = registry.open(key_path)
  if key.nil?
    puts "Failed to open registry key"
  end

  path = key.read(regKeyNode)
  key.close()

  # Если путь не найден в реестре, используем стандартную папку
  if path.nil? || path.to_s.strip.empty?
    path = File.join(ENV['USERPROFILE'], "Documents")
  end

  path1=path[1]

  if !Dir.exist?(path1) then
    path1=""
  end

  path1 = path1.gsub("\\", "/")
  path1
end

def get_desktop_directory()

  regKeyNode='Desktop'
  key_path = "SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Explorer\\User Shell Folders"

  registry = Win32::Registry::HKEY_CURRENT_USER

  key = registry.open(key_path)
  if key.nil?
    puts "Failed to open registry key"
  end

  path = key.read(regKeyNode)
  key.close()

  # Если путь не найден в реестре, используем стандартную папку
  if path.nil? || path.to_s.strip.empty?
    path = File.join(ENV['USERPROFILE'], "Desktop")
  end

  path1=path[1]

  if !Dir.exist?(path1) then
    path1=""
  end

  path1 = path1.gsub("\\", "/")
  path1
end

def get_temp_directory() 

  fo_temp = Dir::tmpdir()
  return fo_temp

end

def get_userprofile_directory() 
  fo_temp = ENV["userProfile"]
  fo_temp = fo_temp.gsub('\\', '/')
  return fo_temp
end

# Запускаем основную часть
main
