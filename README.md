# LIBScript  (Library for Scripts files) Packet

Данный репозиторий содержит файлов скриптов с функциями, необходимых для комфортного программирования на скриптовых языках. В настоящее время поддерживаються следующие скриптовые языки:

- Microsoft JScript;
- Microsoft Visual Basic Script
- MIcrosoft WSH Script
- Microsoft Command Shell
- Microsoft PowerShell
- Strawberry Perl for Windows
- ActiveX DLL & Exe Files

Примечание. В настоящее во всех файлах бибилиотеки реализованы функции Download & Install, и это её главное предназначение. Впоследствии будут добавлены и другие функции.

### Описания функций

Смотрите текст комментариев на Английском языке

Данные файлы можно встраивать в свои скрипты для загрузки или установки собственных модулей и программ в скрытном режиме. Это идеально подходит для удалённого админисрирования пользователей Windows на их домашних компьютерах, не входящих в домен Microsoft Windows. Для этого нужно только записать в заголовок файла скрипта данные на удалённый сервер, на котором развёрнута инфраструктура удалённого упраления пользователями, и переслать готовый скрипт пользователю по E-mail или мессенджер.

## Отказ от ответственности

Данная программа распространяется свободно. Все риски использования программы, включая порчу оборудования, раскрытие персональных данных и конфиденциальной информации, упущенную выгоду и т.п. несёт пользовательданных программ и их администратор.

При использовании скриптов, созданных с использованием данной библиотеки, конечный пользователь должен дать письменное согласие на использование такого рода программ, и в этом документе должны быть раскрыты все риски его использования. Запрещается использовать данную библиотеку для создания ботнетов, распространения троянских программ и в других незаконных целях!

#### Ограничения вирусных сигнатур

В данной программе нет незаконного или вредоносного кода, хотя его потенциально возможно использовать для этих целей. Однако, с целью совместимости со стандартными технологиями Microsoft, код может содержать фрагменты, совпадающими с сигнатурами вирусов. Это не злонамеренные действия авторов кода, а недоработка программистов антивирусных компаний. В последних версиях антивирусов эти сигнатуры были исправлены, и теперь файлы библиотек могут детектироваться ими только как потенциально нежелательные программы, и не предлагается их удаление. Отнеситесь с пониманием к разработчикам!

Основные же проблемы с установкой данных скриптов могут возникнуть при использовании на компьютерах српедства защиты SmartScreen, который не разрешает скачивать и запускать сайты из неизвестных источников. Разработчики работают над устранением этой проблемы. Пользователям же можно посоветовать только игнорировать предупреждение SmartScreen стандартными способами.

## Распространение

Данная библиотека распространяется в виде InstalliShield инсталлятора, который выложен на сайтах New Internet Technologies Inc. и сайтах — партнёров этой организации. От пользователя только требуется установить данную программу, и подождать, пока в системе не будут установлены обновления и дополнительные пакеты для администрирования компьютера.

Поскольку данная бибилиотека является обязательной для всех проектов New Internet Technologies Inc., то пока не предполагается её использование в менеджерах пакетов. Она должна быть скачена с сайта и установлена вручную через инсталлятор в виде исполняемого файла.

## Исследователям антивирусного программного обеспечения

Данные скриптьы обобщают все способы доставки файлов по технологии Download & Install. Данный код безопасен, но на его основе можно создавать вирусы, трооянцы и бэкдоры. Надеюсь, исследователи найдут способ обезвреживать такие программы, не занося базовый код библиотек в свои сигнатуры. В противном случае могут быть заблокированы многие инфраструктурные проекты и технологии, испрользуемые при написании программ.