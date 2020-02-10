[Console]::OutputEncoding = [System.Text.Encoding]::GetEncoding("cp866")

$starttime  = (Get-Date).ToString()


##Очистим конекты
Remove-VpnConnection -Name "VPN" -Force

##$presharekey = '$nederzhitezladerzhite$hariki'

##Add-VpnConnection -Name "VPN" -ServerAddress "195.94.237.218" -TunnelType L2TP -L2tpPsk $presharekey -EncryptionLevel Optional -SplitTunneling -Force
Add-VpnConnection -Name "VPN" -ServerAddress "195.94.237.218" -TunnelType Sstp -EncryptionLevel Required -SplitTunneling -Force

Remove-Item -Path "C:\novosib_share\VPN\*" -Force

#Create new file for start vpn
'RASDIAL VPN sstp_novosibirsk pssw' | out-file -encoding ascii -filepath 'C:\novosib_share\VPN\VPN_start.bat'

C:\novosib_share\VPN\VPN_start.bat

##Check подклчено ли теперь VPN
$VPN = (ipconfig | Select-String "VPN" -Quiet)

if 
("$VPN" -eq 'true')
    {$connested = 'Connect'

    }
else {
    $connested = 'Not connect'

    }



$Finishtime = (Get-Date).ToString()

$serverSmtp = "smtp.yandex.ru" 
$port = 587
$From = "mirus.novosib@yandex.ru" 
$To = "it@mirus-medical.com" 
$subject = "novosib_VPN" + ': ' + (Get-Date).ToString()
$user = "mirus.novosib"
$pass = "pssw" #mytrejJka_Y-4our_soul_dark


$mes = New-Object System.Net.Mail.MailMessage

#//Формируем данные для отправки
$mes.From = $from
$mes.To.Add($to) 
$mes.Subject = $subject 
$mes.IsBodyHTML = $true 
$mes.Body = "<h3>VPN (Rostov) had to disconnect</h3>" + '<br>' + 'Start connection at ' + $starttime + ' O"Clock and get finish to connection ' + $Finishtime + '<hr>' + $connested


#//Создаем экземпляр класса подключения к SMTP серверу 
$smtp = New-Object Net.Mail.SmtpClient($serverSmtp, $port)

#//Сервер использует SSL 
$smtp.EnableSSL = $true 

#Создаем экземпляр класса для авторизации на сервере яндекса
$smtp.Credentials = New-Object System.Net.NetworkCredential($user, $pass);

#//Отправляем письмо, освобождаем память
$smtp.Send($mes) 