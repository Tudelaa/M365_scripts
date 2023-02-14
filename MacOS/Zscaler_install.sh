#!/bin/bash

# This shell script install Zscaler from specific webdav/external link in your Apple MacOS.
# You can use this script to schedule automatic installation using Microsoft Endpoint Manager -intune-
# Written: Antonio Tudela

# Variables

logfiles="/Library/Logs/Microsoft/IntuneScripts/zscaler.log"
version="3.6.1.30"
App="Zscaler-osx-$version-installer.app"
zipfile="Zscaler-osx-$version-installer.app.zip"
webdav= #webdav where you located the zip file with zscaler
temporal="Users/$user/zscaler"
user= #webdav user
password= #webdav password
Cloudname= #your cloudname in zscaler
Userdom = #your user domain in zscaler




function download { 

                    echo "Creating folder to download Zscaler on $temporal"
                    mkdir /$temporal
                    cd /$temporal
                    echo "downloading file from $webdav"
                    curl -f -s --connect-timeout 30 --retry 5 --retry-delay 60 --compressed -L -J -u $user:$password -O $webdav 
                    chmod 755 $zipfile
                    #Extract files
                    echo "extracting files from $zipfile"
                    unzip $zipfile
                    echo "adding privilege"
                    chmod -Rf 755 $App
                    

                   }


function install { 

                                     

                                    
                   sudo /$temporal/Zscaler-osx-$version-installer.app/Contents/MacOS/installbuilder.sh --cloudName $Cloudname --userDomain $Userdom --mode unattended --unattendedmodeui none

                 

                 }


# check if zscaler was installed before on Mac

if [ -f "/Applications/Zscaler/Zscaler.app/Contents/MacOS/Zscaler" ]; then

                                echo "Zscaler was installed before and will be not reinstall" >> $logfiles
                                exit 0

else 

      download
      sleep 15
      install

fi

