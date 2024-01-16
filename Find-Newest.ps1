#
param (
    [string]$path = "."
 )
$newest=@{
FullName=""
LastWriteTime=(Get-Date -Date "1970-01-01 00:00:00Z")
}
Get-ChildItem -Path $path -Recurse | ForEach-Object {
    if($_.LastWriteTime -gt $newest.LastWriteTime){
        $newest.LastWriteTime=$_.LastWriteTime
        $newest.FullName=$_.FullName
        Write-Host $newest.FullName $newest.LastWriteTime
    }
}
