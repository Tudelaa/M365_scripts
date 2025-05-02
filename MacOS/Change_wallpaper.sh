#!/bin/sh

# This shell script download a jpg file located in blob container and use it in your mac device like background corporate screen 
# using a software installed called desktoppr that offers the possibility to use scale stretch if picture doesn´t looks fine.
# Written: Antonio  Tudela

# Variables

blob_container="blob container where you uploaded the wallpaper files -on this example is picture.jpg"
logfiles="/Library/Logs/Microsoft/IntuneScripts/wallpaper.log"
userlogin=$( scutil <<< "show State:/Users/ConsoleUser" | awk '/Name :/ && ! /loginwindow/ { print $3 }' )
temporal="/Users/$userlogin/Library/Wallpaper"
image="/Users/$userlogin/Library/Wallpaper/picture.jpg"
desktoppr="/usr/local/bin/./desktoppr"
argument="scale stretch"
path='"/Users/$userlogin/Library/Wallpaper/picture.jpg"'

function Download_Picture { 

                    #echo "Creating folder to download background on $temporal"
                    
                    if [ ! -d "$temporal" ]; then 
                    mkdir $temporal
                    else 
                    echo "folder was created before..." >> $logfiles             
                    fi
                    
                    cd $temporal
                    echo "downloading file from $blob_container"
                    
                    curl -O $blob_container
                    #echo "adding privilege"
                    chmod -Rf 775 /$temporal
                   
                    

                   }



function Charge_Wallpaper { 

                            
                            
                            
                            sleep 3
                            "$desktoppr" "$image" 
                            "$desktoppr" scale stretch
                            


                        }


Download_Picture

# verify that picture has been downloaded

if [[ ! -x "$image" ]]; then
    echo "Error!! I cannot find wallpaper downloaded in $image"
    exit 1
fi


# verify that desktoppr is installed

if [[ ! -x "$desktoppr" ]]; then
    echo "Error!! I cannot find $desktoppr"
    exit 1
fi

Charge_Wallpaper

