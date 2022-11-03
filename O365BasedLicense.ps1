
# This script changes the registry key value called O365ProPlusRetail.DeviceBasedLicensing To configure device-based licensing if you cannot use
# OfficeDeployment tool as is explained on next Microsoft link:
# https://learn.microsoft.com/en-us/deployoffice/device-based-licensing

# Written: Antonio Tudela 




function O365_devicebasedlicense { 

                  
                    
                    $registrypath = "HKLM:\SOFTWARE\Microsoft\Office\ClickToRun\Configuration" 
                    $name = "O365ProPlusRetail.DeviceBasedLicensing"
                    $value = "1"

                    New-ItemProperty -Path $registrypath -Name $name -Value $value -Propertytype string -Force



                    }


O365_devicebasedlicense