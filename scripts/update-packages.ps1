# Updates all packages in the current directory/sub-directory.

# Grab all projects recursively.
$projects = Get-ChildItem -Include *.csproj -File -Recurse

# Update any outdated packages in the project.
foreach ($project in $projects) {

  $projectName = $project.BaseName
  
  Write-Host "----> [$projectName] updating project" 
  $countPackagesUpdated = 0

  # List all outdated packages.
  dotnet list $project.FullName package --outdated | ForEach-Object {
    # Find matches for package names (this relies on package lines starting with '>')
    if ($_ -match '> ([\w|.]+)') {
      $packageName = $Matches.1
      Write-Host "      [$projectName] updating package $packageName"
      dotnet add $project.FullName package $packageName
      $countPackagesUpdated++
    }
  }

  
  if ($countPackagesUpdated -eq 0) {
    Write-Host "      [$projectName] all packages up to date"
  }
}