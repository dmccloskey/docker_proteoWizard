# Base image
#FROM microsoft/nanoserver:latest
FROM microsoft/windowsservercore:latest

LABEL maintainer Douglas McCloskey <dmccloskey87@gmail.com>

# Install chocolatey
ENV chocolateyUseWindowsCompression false

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# Upgrade .NET and PowerShell
RUN (Get-ItemProperty -Path 'HKLM:\Software\Microsoft\NET Framework Setup\NDP\v4\Full' -ErrorAction SilentlyContinue).Version -like '4.5*'
#RUN Get-ItemProperty -Path 'HKLM:\Software\Microsoft\NET Framework Setup\NDP\v4\Full' -ErrorAction SilentlyContinue
	
#RUN powershell -Command \
#    iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'));	
RUN iwr https://chocolatey.org/install.ps1 -UseBasicParsing | iex

RUN	choco install curl ;\
	choco install 7zip
	
# Install proteoWizard
ADD ./pwiz-bin-windows-x86_64-vc120-release-3_0_10505.tar.bz2 



