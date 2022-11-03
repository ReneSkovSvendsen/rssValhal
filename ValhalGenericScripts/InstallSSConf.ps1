#Set danish regional settings
Import-Module International
Set-TimeZone -Id "Romance Standard Time" -PassThru
Set-WinSystemLocale da-DK
Set-Culture da-DK
Set-WinUserLanguageList da-DK -Force

#Install Web-Server with test page
Install-WindowsFeature -Name Web-Server -IncludeManagementTools
Remove-Item -Path C:\inetpub\wwwroot\iisstart.htm -Force
Add-Content -Path C:\inetpub\wwwroot\iisstart.htm -Value $('Hello World from ' + $env:computername)
Add-Content -Path C:\inetpub\wwwroot\EnableLB.htm -Value $('1')

#install MS Edge
New-Item -Path c:\ -Name "temp" -ItemType Directory -Force
Invoke-WebRequest -Uri "http://go.microsoft.com/fwlink/?LinkID=2093437" -OutFile "c:\temp\edge.msi"
Start-Process -WorkingDirectory "c:\temp" -ArgumentList "/i edge.msi /qb!" "msiexec" -NoNewWindow -Wait
Remove-Item -Path "C:\temp\edge.msi" -Force
