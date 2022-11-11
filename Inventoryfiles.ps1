# inventoryfiles.ps1
# This script count the files with extension located on array called $array1 and create a CSV report with the size in Bytes to have full inventory
# about this data before migrate local data to OneDrive.
# Writting: Antonio Tudela 

# thanks to microsoft for explanationabout how to create a custom input box
# https://docs.microsoft.com/es-es/powershell/scripting/samples/creating-a-custom-input-box?view=powershell-7.2



function welcome  { 

                    Add-Type -AssemblyName System.Windows.Forms
                    $result = [System.Windows.Forms.MessageBox]::Show("This script count the files with extension located in your different disks/partitions and create a full report with the size in Bytes to have full inventory before migrate all these data to OneDrive ","Inventory Files")

                   }




function inputfolder {


Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = 'Inventory Files'
$form.Size = New-Object System.Drawing.Size(500,200)
$form.StartPosition = 'CenterScreen'

$okButton = New-Object System.Windows.Forms.Button
$okButton.Location = New-Object System.Drawing.Point(75,120)
$okButton.Size = New-Object System.Drawing.Size(75,23)
$okButton.Text = 'OK'
$okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $okButton
$form.Controls.Add($okButton)

$cancelButton = New-Object System.Windows.Forms.Button
$cancelButton.Location = New-Object System.Drawing.Point(150,120)
$cancelButton.Size = New-Object System.Drawing.Size(75,23)
$cancelButton.Text = 'Cancel'
$cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $cancelButton
$form.Controls.Add($cancelButton)

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(5,20)
$label.Size = New-Object System.Drawing.Size(680,40)  
$label.Text = 'Please enter the path where you want to save the CSV report. Example: c:\report\'
$form.Controls.Add($label)

$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Location = New-Object System.Drawing.Point(20,60)
$textBox.Size = New-Object System.Drawing.Size(260,80)
$form.Controls.Add($textBox)

$form.Topmost = $true

$form.Add_Shown({$textBox.Select()})
$result2 = $form.ShowDialog()

if ($result2 -eq [System.Windows.Forms.DialogResult]::OK)
{
    $x = $textBox.Text
    return $x
    
}


    
                    }



function folderreport { 



                        $folder = Get-Item -path $pathreport -ErrorAction SilentlyContinue

                        if($folder -eq $null) { 

                                                      write-host "Creating folder $pathreport"
                                                      New-Item $pathreport -ItemType Directory

                                                      }

                        else { 

                                write-host "folder $pathreport was created successfull"


                             }   
                      }

      

clear

$hostfinal = hostname
$usuario = $env:USERNAME


welcome
$pathreport = inputfolder
$invetoryfile = $pathreport + $hostfinal + ".csv"
folderreport
write-host "Scanning files..."
                                 

#array with extension for the inventory
                
$array1 = @("xlsx","docx","pptx","pdf","jpg","png","pst")

# array with disk and partitions availables on computer -only fixed partitions-

$array2 = [IO.DriveInfo]::GetDrives() | Where-Object {($_.DriveType -match "Fixed")} | select -property Name



foreach ($typefile In $array1) {

                                $countfiles = 0;
                                $sizefiles = 0;

                                foreach ($archive In $array2.Name) {
                              
                              
                                                                     $typefile2 = "*." + $typefile   
                         
                                                                      $officearchive = Get-ChildItem -Path $archive -Filter $typefile2 -Recurse -ErrorAction SilentlyContinue -Force | Select-Object *

                              

                                                                      foreach ($officenames in $officearchive) { 

                                                                       
                                                                                                                   $windowsfolder = $officenames.Fullname 
                                                                                                                   $windowsfoldersplit = $windowsfolder.Split("\")[1]
                                                                                                                    
                                                                                                                    

                                                                                                                   if ($windowsfoldersplit -notcontains "Windows") {
                                                                                                                    
                                                                                                                                                                       $countfiles = $countfiles + 1
                                                                                                                                                                       $sizefiles = $sizefiles + $officenames.Length                                                                                               

                                                                                                                 
                                                                                                                                                                    }
                                                                                                                   

                                                                                                              }      
                                                                                                    
                                                                                                            }
                                                                                           

                                                                                                                  
                                                                                                                                                                                                                       


                            if ($typefile -match "xlsx") { 

                                                          $totalcountxlsx = $countfiles
                                                          $totalbytesxlsx = $sizefiles
                                                       
                                                                                       }

                             if ($typefile -match "docx") { 

                                                           $totalcountdocx = $countfiles
                                                           $totalbytesdocx = $sizefiles
                                                       
                                                                                       }
                             
                             if ($typefile -match "pptx") { 

                                                           $totalcountpptx = $countfiles
                                                           $totalbytespptx = $sizefiles
                                                       
                                                                                      }

                        
                                                            
                             if ($typefile -match "pdf") { 

                                                          $totalcountpdf = $countfiles
                                                          $totalbytespdf = $sizefiles
                                                       
                                                                                     }

                             if ($typefile -match "jpg") { 

                                                          $totalcountjpg = $countfiles
                                                          $totalbytesjpg = $sizefiles
                                                       
                                                                                     }
                              

                             if ($typefile -match "png") { 

                                                          $totalcountpng = $countfiles
                                                          $totalbytespng = $sizefiles
                                                       
                                                                                     }

                             if ($typefile -match "pst") { 

                                                           $totalcountpst = $countfiles
                                                           $totalbytespst = $sizefiles
                                                       
                                                                                     }



                                                                               }     
                              

     $column = "computer_name,Username,total xlsx files,total xlsx in bytes,total docx files,total docx in bytes,total pptx files,total pptx in bytes,total pdf files,total pdf in bytes,total jpg files,total jpg in bytes,total png files,total png in bytes,total pst files,total pst in bytes"
     $finalvalues = "$hostfinal,$usuario,$totalcountxlsx,$totalbytesxlsx,$totalcountdocx,$totalbytesdocx,$totalcountpptx,$totalbytespptx,$totalcountpdf,$totalbytespdf,$totalcountjpg,$totalbytesjpg,$totalcountpng,$totalbytespng,$totalcountpst,$totalbytespst"
     $column | out-file -FilePath $invetoryfile 
     $finalvalues | out-file -FilePath $invetoryfile -Append
     
     Import-CSV $invetoryfile | Out-GridView
     
     Add-Type -AssemblyName System.Windows.Forms
                    $result = [System.Windows.Forms.MessageBox]::Show("Inventory done successful. You can see the full report in $invetoryfile","Inventory Files")  
