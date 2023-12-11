# Define the regex pattern to match in the filenames
$regexPattern = "^\d{4}[\u4e00-\u9fa5a-zA-Z-]+"
$regexPattern_2 = "^([\u4e00-\u9fa5a-zA-Z-]+)(\d{4})([_\u4e00-\u9fa5a-zA-Z-]+)"
$regexPattern_3 = "(\d{4})([a-zA-Z]{2})\)"
$regexPattern_4 = "^([\u4e00-\u9fa5a-zA-Z-]+) (\d{4})([\u4e00-\u9fa5a-zA-Z-]+)"

# Get a list of all files in the current directory
$fileList = Get-ChildItem -Path $PWD -File

# Loop through each file in the list
foreach ($file in $fileList) {

  # Check if the filename matches the regex pattern
  if ($file.Name -match $regexPattern) {
	  
	$newFilename = $file.BaseName.insert(4,' ') + $file.Extension
    Rename-Item -Path $file.FullName -NewName $newFilename
    
  } 
}

$fileList = Get-ChildItem -Path $PWD -File
foreach ($file in $fileList) {

  # Check if the filename matches the regex pattern
  if ($file.Name -match $regexPattern_2) {

    # Construct the new filename with blanks inserted in each matched group
    $newFilename = $matches[1] + ' ' + $matches[2] + $matches[3] + $file.Name.Substring($matches[0].Length)

    # Rename the file
    Rename-Item -Path $file.FullName -NewName $newFilename
    
  } 
}

$fileList = Get-ChildItem -Path $PWD -File
foreach ($file in $fileList) {

  # Check if the filename matches the regex pattern
  if ($file.Name -match $regexPattern_3) {

    $newFilename = $file.BaseName.Substring(0, $file.BaseName.Length - $matches[0].Length) + $matches[1] + ' ' + $matches[2] + $file.Extension

    Rename-Item -Path $file.FullName -NewName $newFilename
    
  } 
}

$fileList = Get-ChildItem -Path $PWD -File
foreach ($file in $fileList) {

  # Check if the filename matches the regex pattern
  if ($file.Name -match $regexPattern_4) {

    $newFilename = $matches[1] + ' ' + $matches[2] + ' ' + $matches[3] + ' ' + $file.Name.Substring($matches[0].Length)

    Rename-Item -Path $file.FullName -NewName $newFilename
    
  } 
}

$fileList = Get-ChildItem -Path $PWD -File
foreach ($file in $fileList) {
	$SubName = $file.BaseName.Replace("("," ").Replace(")"," ").replace("- ","-").replace(" -","-").Replace(" _", "_")
	$newFilename = $SubName + $file.Extension
	Rename-Item -Path $file.FullName -NewName $newFilename
}