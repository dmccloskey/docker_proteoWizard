# Base image
FROM microsoft/nanoserver:latest

##Required for chocolatey
#FROM microsoft/windowsservercore:latest

LABEL maintainer Douglas McCloskey <dmccloskey87@gmail.com>

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

## Install chocolatey
#ENV chocolateyUseWindowsCompression false

## Upgrade .NET and PowerShell
#RUN (Get-ItemProperty -Path 'HKLM:\Software\Microsoft\NET Framework Setup\NDP\v4\Full' -ErrorAction SilentlyContinue).Version -like '4.5*'
	
#RUN iwr https://chocolatey.org/install.ps1 -UseBasicParsing | iex

## Install curl and 7zip
#RUN choco install curl -y ;\
#	choco install 7zip -y
	
# # Install proteoWizard
# # (too many layers!)
# WORKDIR C:/"Program Files"
# RUN mkdir ProteoWizard
# WORKDIR C:/"Program Files"/ProteoWizard
# RUN mkdir ProteoWizard3.0.10505
# ADD ./pwiz-bin-windows-x86_64-vc120-release-3_0_10505.tar.bz2 ProteoWizard3.0.10505/
# #RUN setx /m PATH %PATH%;C:\\"Program Files"\\ProteoWizard\\ProteoWizard3.0.10505
# WORKDIR C:/

# # Install proteoWizard
RUN New-Item C:\\pwiz_data -ItemType Directory ; \
    New-Item C:\\ProteoWizard -ItemType Directory ; \
    $env:PATH = 'C:\\ProteoWizard' + $env:PATH
ADD ./pwiz-bin-windows-x86_64-vc120-release-3_0_10505.tar.bz2 C:/ProteoWizard/
WORKDIR C:\\pwiz_data

#CMD ["C:\\Program Files\\ProteoWizard\\ProteoWizard3.0.10505\\msconvert.exe"]

##run the container:
#docker run --name proteowizard -v c:/Users/domccl/"Dropbox (UCSD SBRG)"/absciexQTRAP5500_dataProcessing/analyst/openMS_test/Convert/:c:/pwiz_data/ dmccloskey/docker-pwiz msconvert *.wiff