
# Get Hash
Get-FileHash Template.json

# cd -> Get-ChildItem
# Search Subdirctory for full path not have Global and Get Hash
Get-ChildItem Template.json -recurse | Select-Object Fullname | where-object fullName -notlike '*Global*' | %{Get-FileHash $_.FullName}