# Python – проверить, существует ли файл или каталог

Иногда необходимость проверить, существует каталог или файл или нет, становится важной, потому что, возможно, вы хотите предотвратить перезапись уже существующего файла, или, может быть, вы хотите убедиться, что файл доступен или нет, перед его загрузкой.
Существуют различные способы проверить, существует ли файл или каталог уже или нет.

- Используя os.path.exists()
- Используя os.path.isfile()
- Используя os.path.isdir()
- Используя pathlib.Path.exists()

### Используя os.path.exists(), чтобы проверить, существует ли файл

**Модуль операционной системы в Python** предоставляет функции для взаимодействия с операционной системой. ОПЕРАЦИОННАЯ система поставляется со стандартными служебными модулями Python. Этот модуль предоставляет переносимый способ использования функциональности, зависящей от операционной системы. Модуль **os.path** является подмодулем **модуля ОС** в Python, используемым для обычных манипуляций с именем пути.

**Примечание** : Чтобы узнать больше о модуле os <https://translated.turbopages.org/proxy_u/en-ru.ru.7b530a78-64d670f0-c9ad169a-74722d776562/https/www.geeksforgeeks.org/os-module-python-examples/>.

**Метод os.path.exists()** в Python используется для проверки того, существует ли указанный путь или нет. Этот метод также можно использовать для проверки, ссылается ли указанный путь на дескриптор открытого файла или нет.

***Синтаксис***: os.path.exists(путь)

***Параметр***:

***путь***: объект, подобный пути, представляющий путь к файловой системе. Объект, подобный пути, представляет собой либо объект string, либо объект bytes, представляющий путь.

***Return***: Возвращает логическое значение, представляющее, существует ли путь или нет.

Пример: Проверка, существует ли путь, с помощью os.path.exists()

```python
import os
   
# Specify path
path = '/usr/local/bin/'
   
# Check whether the specified
# path exists or not
isExist = os.path.exists(path)
print(isExist)
   
   
# Specify path
path = '/home/User/Desktop/file.txt'
   
# Check whether the specified
# path exists or not
isExist = os.path.exists(path)
print(isExist)
```

Вывод:

```Text
True
False
```

### Использование метода os.path.isfile() для проверки, существует ли файл

**метод os.path.isfile()** в Python используется для проверки того, является ли указанный путь существующим обычным файлом или нет.

***Синтаксис***: os.path.isfile(путь)

***путь***: Параметр: похожий на путь объект, представляющий путь к файловой системе. Похожий на путь объект - это либо объект string, либо объект bytes, представляющий путь.

***Тип возвращаемого значения***: Этот метод возвращает логическое значение класса bool. Этот метод возвращает True, если указанный путь является существующим обычным файлом, в противном случае возвращает False.

Пример: Проверка, является ли путь, указывающий на ресурс, файлом

```python
import os
 
# Path
path = 'C:/Users/gfg/Desktop/file.txt'
 
# Check whether a path pointing to a file
isFile = os.path.isfile(path)
print(isFile)
 
# Path
path = '/home/User/Desktop/'
 
# Check whether the path is a file
isFile = os.path.isfile(path)
print(isFile)
```

Вывод:

```Text
True
False
```

### Использование метода os.path.isdir() для проверки, существует ли файл

**метод os.path.isdir()** в Python используется для проверки того, является ли указанный путь существующим каталогом или нет. Этот метод следует символической ссылке, что означает, что если указанный путь является символической ссылкой, указывающей на каталог, то метод вернет True.

***Синтаксис***: os.path.isdir(путь)

***Параметр***:

***path***: объект, подобный path, представляющий путь к файловой системе.

***Тип возвращаемого значения***: Этот метод возвращает логическое значение класса bool. Этот метод возвращает True, если указанный путь является существующим каталогом, в противном случае возвращает False.

Пример: Проверьте, является ли путь каталогом, используя os.path.isdir()

```python
import os.path
   
# Path
path = '/home/User/Documents/file.txt'
   
# Check whether the path is an existing directory
isdir = os.path.isdir(path)
print(isdir)
   
# Path
path = '/home/User/Documents/'
   
# Check whether the path is a directory
isdir = os.path.isdir(path)
print(isdir)
```

Вывод:

```Text
False
True
```

Пример: Является ли указанный путь символической ссылкой.

```Python
import os.path  
   
# Create a directory
dirname = "GeeksForGeeks"
os.mkdir(dirname)
   
# Create a symbolic link
# pointing to above directory
symlink_path = "/home/User/Desktop/gfg"
os.symlink(dirname, symlink_path)
   
path = dirname
   
# Check whether the specified path is an
# existing directory or not
isdir = os.path.isdir(path)
print(isdir)
   
path = symlink_path
   
# check whether the symlink is
# an existing directory or not
isdir = os.path.isdir(path)
print(isdir)
```

Вывод:

```Text
True
True
```

### Используя pathlib.Path.exists(), чтобы проверить, существует ли файл

**модуль pathlib** в Python предоставляет различные классы, представляющие пути к файловой системе, с семантикой, подходящей для различных операционных систем. Этот модуль входит в состав стандартных служебных модулей Python. Классы путей в модуле pathlib разделены на чистые пути и конкретные пути. Чистые пути обеспечивают только вычислительные операции, но не операции ввода-вывода, в то время как конкретные пути, наследуемые от чистых путей, обеспечивают как вычислительные, так и операции ввода-вывода. Вы можете подробно прочитать о модуле pathlib здесь.

**метод pathlib.Path.exists()** используется для проверки, указывает ли указанный путь на существующий файл или каталог или нет.

***Синтаксис***: pathlib.Path.exists(путь)

***параметр***:

***путь***: объект, подобный path, представляющий путь к файловой системе.

***Возвращаемый тип***: Этот метод возвращает логическое значение класса bool. Этот метод возвращает True, если path существует, в противном случае возвращает False.

Пример: Проверьте, существует ли путь, используя модуль pathlib

```Python
# Import Path class
from pathlib import Path
 
# Path
path = '/home/tuhingfg/Desktop'
 
# Instantiate the Path class
obj = Path(path)
 
# Check if path exists
print("path exists?", obj.exists())
```

Вывод:

```Text
True
```

Последнее обновление : 25 марта 2023 г.
