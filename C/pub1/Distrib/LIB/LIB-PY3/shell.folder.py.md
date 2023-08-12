# Shell Default Folders

Сразу нужно отметить, что подобные папки можно переместить за пределы домашней папки пользователя, так что наивные решения вроде `os.path.expanduser('~/Desktop')` будут работать некорректно — не делайте так нигде кроме macOS.

В разных ОС есть свои правильные способы получения путей.

## Windows

В Windows для этого есть Win32 API метод SHGetKnownFolderPath. Для его использования можно установить pywin32 (с помощью команды pip install pywin32) и использовать примерно так:

```python
from win32com.shell import shell, shellcon
path = shell.SHGetKnownFolderPath(shellcon.FOLDERID_Documents)
print(path)
# C:\Users\username\Documents
```

В первом аргументе нужно передать идентификатор нужной папки (одну из констант KNOWNFOLDERID). Полный список идентификаторов можно почитать на MSDN, здесь приведу наиболее интересные:

- shellcon.FOLDERID_Profile — папка пользователя (C:\Users\username);
- shellcon.FOLDERID_Desktop — рабочий стол (C:\Users\username\Desktop);
- shellcon.FOLDERID_Documents — документы (C:\Users\username\Documents);
- shellcon.FOLDERID_Music — музыка (C:\Users\username\Music);
- shellcon.FOLDERID_Pictures — изображения (C:\Users\username\Pictures);
- shellcon.FOLDERID_Videos — видео (C:\Users\username\Videos);
- shellcon.FOLDERID_Downloads — загрузки (C:\Users\username\Downloads);
- shellcon.FOLDERID_RoamingAppData и shellcon.FOLDERID_LocalAppData — AppData\Roaming и AppData\Local соответственно.
- shellcon.FOLDERID_ProgramData — %ALLUSERSPROFILE% (%ProgramData%, %SystemDrive%\ProgramData)
- shellcon.FOLDERID_ProgramFiles — %ProgramFiles% (%SystemDrive%\Program Files)
- shellcon.FOLDERID_ProgramFilesX64 — %ProgramFiles% (%SystemDrive%\Program Files)
- shellcon.FOLDERID_ProgramFilesX86 — (%ProgramFiles% (%SystemDrive%\Program Files (x86)?)

## macOS

Если я правильно понимаю документацию, в macOS пути строго фиксированны. Так что всё, что нужно сделать, — это получить путь к домашнему каталогу и дописать к нему нужные подкаталоги.

Функция os.path.expanduser может сделать всю работу за нас: если в начале пути стоит тильда, она заменит его на путь к домашнему каталогу. Домашний каталог в macOS и Linux вычисляется так: если существует переменная окружения HOME, то берётся её значение, а если её нет, то считывается путь с помощью функции getpwuid.

```python
import os

# Просто домашний каталог — в macOS будет /Users/username
home_dir = os.path.expanduser("~")

path = os.path.expanduser("~/Desktop")  # Рабочий стол
path = os.path.expanduser("~/Documents")  # Документы
path = os.path.expanduser("~/Downloads")  # Загрузки
path = os.path.expanduser("~/Movies")  # Видео
path = os.path.expanduser("~/Music")  # Музыка
# Настройки приложений, местный аналог Application Data
path = os.path.expanduser("~/Library/Application Support")
```

Также это всё легко делается с помощью pathlib — объекты Path более удобны в пользовании, чем обычные строки.

```python
from pathlib import Path

path = Path.home() / "Desktop"
path = Path.home() / "Documents"
path = Path.home() / "Downloads"
path = Path.home() / "Movies"
path = Path.home() / "Music"
path = Path.home() / "Library" / "Application Support"
```

## Linux, *BSD (XDG)

Unix-подобные ОС обычно опираются на стандарты freedesktop.org (больше известны по аббревиатуре XDG) и хранят пути к стандартным папкам в файле ~/.config/user-dirs.dirs — получить интересующий путь в терминале можно командой xdg-user-dir (это короткий bash-скрипт на несколько строк), например xdg-user-dir DOWNLOAD.

Каждая строка в файле user-dirs.dirs имеет переменную в формате XDG_xxx_DIR, где xxx — тип каталога. Путь к каталогу должен или быть абсолютный (начинаться на /), или начинаться на $HOME/ — другие форматы не допускаются.

К своему удивлению, я не обнаружил готового парсера этого файла для Python; впрочем, его нетрудно написать самостоятельно, используя библиотеку dotenv (pip install python-dotenv, не забудьте добавить опцию --user если нужно):

```python
import os
from dotenv import dotenv_values

def get_user_dir(name: str) -> str:
    # Сперва получаем домашний каталог традиционным способом
    home_dir = os.path.expanduser("~")

    # Потом ищем путь к каталогу, в котором хранятся настройки
    config_dir = os.getenv("XDG_CONFIG_HOME") or os.path.join(home_dir, ".config")

    # Загружаем файл с описанием каталогов
    data = dotenv_values(os.path.join(config_dir, "user-dirs.dirs"))
    
    # Получаем путь из файла или генерируем его, если в файле нет нужного пути
    key = f"XDG_{name}_DIR"
    if key in data:
        path = data[key]
    elif key == "DESKTOP":
        path = os.path.join(home_dir, "Desktop")
    else:
        path = home_dir

    # Если путь начинается на $HOME, то нужно подставить туда домашний каталог
    if path.startswith("$HOME/"):
        path = os.path.join(home_dir, path[6:])

    return path
print(get_user_dir("DOWNLOAD"))
# /home/username/Загрузки
```

В этом файле представлены следующие переменные (названия папок могут отличаться в зависимости от текущего языка системы):

- XDG_DESKTOP_DIR — /home/username/Рабочий стол
- XDG_DOWNLOAD_DIR — /home/username/Загрузки
- XDG_TEMPLATES_DIR — /home/username/Шаблоны
- XDG_PUBLICSHARE_DIR — /home/username/Общедоступные
- XDG_DOCUMENTS_DIR — /home/username/Документы
- XDG_MUSIC_DIR — /home/username/Музыка
- XDG_PICTURES_DIR — /home/username/Изображения
- XDG_VIDEOS_DIR — /home/username/Видео

## Временные файлы

Это будет модуль `tempfile` (<http://docs.python.org/library/tempfile.html>).

Он имеет функции для получения временного каталога, а также имеет несколько ярлыков для создания в нем временных файлов и каталогов, именованных или безымянных.

Пример:

```python
import tempfile

print tempfile.gettempdir() # prints the current temporary directory

f = tempfile.TemporaryFile()
f.write('something on temporaryfile')
f.seek(0) # return to beginning of file
print f.read() # reads data back from the file
f.close() # temporary file is automatically deleted here
```

Для полноты картины, вот как он ищет временный каталог в соответствии с документацией (<https://docs.python.org/3/library/tempfile.html#tempfile.gettempdir>):

- Каталог, имя которого соответствует переменной среды `TMPDIR`
- Каталог, имя которого соответствует переменной среды `TEMP`
- Каталог, имя которого соответствует переменной среды `TMP`
- Местоположение для конкретной платформы:
- В RiscOS каталог, названный переменной среды.
- В Windows каталоги , , , и , в указанном порядке.
- На всех остальных платформах каталоги , , и , в указанном порядке.
- В крайнем случае, текущий рабочий каталог `Wimp$ScrapDir` `C:\TEMP` `C:\TMP` `\TEMP` `\TMP` `/tmp/var` `/tmp/usr/tmp`
