# M365_scripts
This repository include several different PowerShell/Bash sheel scripts that can help your IT staff in the process to migrate your On-prem Infrastructure to Microsoft365 cloud environment
   
| Script Name               | Description                                                             |
| ------------------------- | ----------------------------------------------------------------------- |
| inventoryfiles.ps1        | This script in PowerShell count all the Office files -.xlsx,docx,pst...-  you have in your different Disks/partitions and creates a CSV report with the size in bytes to have full inventory if you are scheduling to migrate your server/computer to the cloud |
| Auditfolders.ps1          | A PowerShell script to get NTFS permissions and save it on CSV file. Usefull to know all NTFS security in a folder requested and in all its subfolders before migrate it to SharePoint or Teams. -results are saved on c:\audit\audit_NTFS.csv|
| O365BasedLicense.ps1      | This script changes the registry key value called O365ProPlusRetail.DeviceBasedLicensing To configure device-based licensing if you cannot use OfficeDeployment tool as is explained on next Microsoft link: https://learn.microsoft.com/en-us/deployoffice/device-based-licensing |
| licenses.ps1              | A simple script that connect to your azure AD and request a destination path in your PC to create CSV files with all users with different licenses. You can use Get-MsolAccountSku to modify this script with different versions with different licenses |
| /macOS/zscaler_install.sh | This shell script install Zscaler from specific webdav/external link in your Apple MacOS You can use this script to schedule automatic installation using Microsoft Endpoint Manager -intune- |

