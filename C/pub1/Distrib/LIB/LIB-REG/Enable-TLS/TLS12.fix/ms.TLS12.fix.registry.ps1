$reg32bWinHttp = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\WinHttp"
$reg64bWinHttp = "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Internet Settings\WinHttp"
$regWinHttpDefault = "DefaultSecureProtocols"
$regWinHttpValue = "0x00000800"
$regTLS12Client = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client"
$regTLS12Server = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server"
$regTLSDefault = "DisabledByDefault"
$regTLSValue = "0x00000000"

$regTLSEnabled = "Enabled"
$regTLSEnableValue = "0x00000001"
# Äëÿ Windows x86
$test = test-path -path $reg32bWinHttp
if(-not($test)){
New-Item -Path $reg32bWinHttp
}
New-ItemProperty -Path $reg32bWinHttp -Name $regWinHttpDefault -Value $regWinHttpValue -PropertyType DWORD
# Äëÿ Windows x64
$test = test-path -path $reg64bWinHttp
if(-not($test)){
New-Item -Path $reg64bWinHttp
}
New-ItemProperty -Path $reg64bWinHttp -Name $regWinHttpDefault -Value $regWinHttpValue -PropertyType DWORD
New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2”
New-Item -Path $regTLS12Client
New-Item -Path $regTLS12Server
New-ItemProperty -Path $regTLS12Client -Name $regTLSDefault -Value $regTLSValue -PropertyType DWORD
New-ItemProperty -Path $regTLS12Client -Name $regTLSEnabled -Value $regTLSEnableValue -PropertyType DWORD
New-ItemProperty -Path $regTLS12Server -Name $regTLSDefault -Value $regTLSValue -PropertyType DWORD
New-ItemProperty -Path $regTLS12Server -Name $regTLSEnabled -Value $regTLSEnableValue -PropertyType DWORD
