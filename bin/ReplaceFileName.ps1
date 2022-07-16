# description and list target files
Write-Host "�t�@�C�����u��" -ForegroundColor Green
Get-ChildItem -Path ".\*"

# replace file name
Write-Output ""
$targetStr = $(Write-Host "�u���Ώۂ̕���������: " -ForeGroundColor Green -NoNewline; Read-Host)
$replacedStr = $(Write-Host "�u����̕���������: " -ForeGroundColor Green -NoNewline; Read-Host)
$files = (Get-ChildItem -Path ".\*")
foreach ($file in $files) {
    $newName = $file.Name.Replace($targetStr, $replacedStr)
    Rename-Item -LiteralPath $file.FullName -NewName $newName
}

Write-Host ""
Get-ChildItem -Path ".\*"