# 365license.ps1
# This script connect with AzureAD to get the list of Users with E5 and F3 license and create a separtely CSV file with this info.
# Antonio Tudela

function folderreport { 
  


                        $folder = Get-Item -path $pathreport -ErrorAction SilentlyContinue

                        if($folder -eq $null) { 

                                                      write-host "Creating folder $pathreport"
                                                      New-Item $pathreport -ItemType Directory

                                                      }

                        else { 

                                write-host "folder $pathreport was created successfull before"


                             }   
                      }



clear                        
$pathreport = read-host "Type the full path folder  where you want to create reports without last \"

folderreport
Install-module -Name AzureAD -Force -ErrorAction SilentlyContinue

Connect-MsolService 

$typeoflicense = Get-MsolAccountSku
$users = Get-Msoluser -All | Where-Object { $_.isLicensed -eq "TRUE"} 


Write-Host "Creating list of users with F3 license"

$filereport = $pathreport + "\" + "F3users.csv"
$users | Where-Object {($_.licenses).AccountSkuId -match "SPE_F5_SECCOMP"} | select -Property UserPrincipalName | export-csv -Path $filereport

Write-Host "Creting list of users with E5 license"
$filereport = $pathreport + "\" + "E5users.csv"

$users | Where-Object {($_.licenses).AccountSkuId -match "SPE_E5"} | select -Property UserPrincipalName | export-csv -Path $filereport

