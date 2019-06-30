# Renames a project files, folders and contents. Then deletes itself.
param (
  [string] $newProjectName = $(Read-Host "project name"),
  [string] $gitRepoUrl = $(Read-Host "git repository"),
  [string] $authorName = $(Read-Host "author")
)

if (!$newProjectName) {
  Write-Error "project name must be specified"
  return
}

if (!$gitRepoUrl) {
  Write-Error "get repository must be specified"
  return
}

if (!$authorName) {
  Write-Error "author must be specified"
  return
}

$oldProjectName = 'Starter'
  
# Rename files and folders.

Get-ChildItem -Filter "*$oldProjectName*" -Recurse | ForEach-Object {
  $currentFileName = $_.FullName
  $newFileName = $currentFileName.Replace($oldProjectName, $newProjectName)

  if (Test-Path $newFileName) {
    Remove-Item -Path $newFileName -Force -Recurse
  }
  
  Rename-Item -Path $currentFileName -NewName $newFileName -Force
}

# Rename project references and git repo url in files.

$files = Get-ChildItem -File -Recurse
foreach ($file in $files) {
  try {
    $fileContents = Get-Content -Path $file.FullName -Raw
    $newFileContents = $fileContents.Replace($oldProjectName, $newProjectName).Replace('{{git_repo_url}}', $gitRepoUrl).Replace('{{author_name}}', $authorName)
    Set-Content -Path $file.FullName -Value $newFileContents -NoNewline
  }
  catch {
    Write-Error "Failed while trying to replace contents of file: $file"
  }
}

# Remove this script.
Remove-Item .\rename-project.ps1 -Force
