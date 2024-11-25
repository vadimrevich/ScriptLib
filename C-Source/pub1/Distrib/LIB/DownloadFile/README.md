# README Download File Script

Описание скриптов для загрузки файлов

## Introduction

This directory contains two files designed to facilitate downloading
other files from a web server.

- `DownloadFile.ashx` — file on ASP.Net (C# language). The file runs on
  Microsoft IIS web servers. To use it in Microsoft Windows, in addition
  to the web server, the ASP and ASP components must be installed.Net
  and other components for the proper functioning of \*.ashx files
- `download.php ` is a PHP file. The file works on all servers in all
  operating systems that have the PHP 5.6+ interpreter installed.
  Additional non-standard configuration of the PHP interpreter is
  required for Microsoft IIS and Nginx servers.

Using these files, you can download any files from the web server, even
those marked as non-downloadable or located outside the web server
directory.

## Security Warning

It follows from the above that these scripts can be used to illegally
download files from the servers on which they are located. Please do not
use these programs on servers of critical architecture and set the file
upload rights correctly.

## Installation

Just copy these files to the directory of the web server from which you
will download the files.

## Usage

Let's assume that the URL of the folder from which the file will be
downloaded is indicated by the "url" variable, and the downloaded file
is indicated by the "file" variable. Example:
`«url» = http://localhost:80/`, and `«file» = iisstart.html `. In this
case, the use of these files follows the following syntax:

    «url»download.php?file=«file»

    «url»DownloadFile.ashx?file=«file»

These constructions should be placed as parameters of the *href*
attributes in HTML/HTA files or the *URI* attribute in script files.

Files without renaming will be downloaded to the Downloads folder of the
current Microsoft Windows or Linux user.

### Note

Files downloaded in the Microsoft Windows operating system from the
browser will have a hidden attribute "Downloaded from the Internet"
(only for the NTFS file system). Before using the file, you must either
clear this attribute, or agree to all security warnings to run or open
this file.

In some browsers, when downloading files, a message appears confirming
the download and selecting the directory and name of the downloaded
file. The authors leave further actions without comments, since this is
a standard file saving dialog.

The names of uploaded files must strictly comply with the UNIX POSIX
file naming rules (uppercase and lowercase uppercase letters,
underscore, period) and be much less than 255 characters long.

### Usage examples

    <a href="http://localhost:80/DownloadFile.ashx?file=iisstart.html ">Upload a file</a>

Downloads the file `iisstart.html ` "as is" from the root of the local
Microsoft IIS web server to the "Downloads" directory of the current
user. The file is not processed by the web server before downloading!

# Русский текст

## Введение

В данном каталоге представлены два файла, предназначенные ля облегчения
загрузки других файлов с веб-сервера.

- `DownloadFile.ashx` — файл на ASP.Net (Язык C#). Файл работает на
  веб-серверах Microsoft IIS. Для его использования в Microsoft Windows,
  помимо веб-сервера, должны быть установлены компоненты ASP, ASP.Net и
  другие компоненты для правильного функционирования файлов \*.ashx
- `download.php` — файл на PHP. Файл работает на всех серверах во всех
  операционных системах, в которых установлен интерпретатор PHP 5.6+.
  Для серверов Microsoft IIS и Nginx требуется дополнительная
  нестандартная настройка интерпертатора PHP.

С помощью этих файлов можно загрузить любые файлы с веб-сервера, даже
помеченные как незагружаемые или расположенные вне каталога веб-сервера.

## Предупреждение безопасности

Из вышесказанного следует, что данные скрипты могут быть использованы
для незаконной загрузки файлов с серверов, на которых они расположены.
Пожалуйста, не используйте эти программы на серверах критической
архитектуры и правильно выставляйте права на загрузку файлов.

## Установка

Просто скопируйте данные файлы в каталог веб-сервера, из которого вы
будете загружать файлы.

## Использование

Допустим, что URL папки, из которой будет загружаться файл, обозначен
переменной «url», а загружаемый файл обозначен переменной «file».
Нпример: `«url» = http://localhost:80/`, а `«file» = iisstart.html`. В
таком случае использование этих файлов подчиняется следующему
синтаксису:

    «url»download.php?file=«file»

    «url»DownloadFile.ashx?file=«file»

Данные конструкции нужно поместить в качестве параметорв атрибутов
*href* в HTML/HTA файлов или атрибута *URI* в файлах скриптов.

Файлы без переименования будут загружены в папку «Загрузки» текущего
пользователя Microsoft Windows или Linux.

### Примечание

Файлы, загруженные в операционной системе Microsoft Windows из браузера,
будут иметь скрытый атрибут «Загружен из Интернета» (только для файловой
системы NTFS). Перед использованием файла вы либо должны очистит этот
атрибут, либо согласится со всеми предупреждениями безопасности на
запуск или открытие данного файла.

В некоторых браузерах при загрузке файлов появляется сообщение с
подтверждением загрузки и выбора каталога и имени загружаемого файла.
Авторы оставляют дальнейшие действия без коментариев, поскольку это
стандартный диалог сохранения файла.

Имена загружаемых файлов должны строго соответствовать правилам
именования файлов UNIX POSIX (заглавные и строчные прописные буквы, знак
подчёркивания, точка) и иметь длину намного меньше 255 символов.

### Примеры использования

    <a href="http://localhost:80/DownloadFile.ashx?file=iisstart.html">Загрузить файл</a>

Загружает файл `iisstart.html` «как есть» из корня локального
веб-сервера Microsoft IIS в каталог «Загрузки» текущего пользователя.
Перед загрузкой файл не обрабатывается веб-сервером!
