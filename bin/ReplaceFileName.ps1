# description and list target files
Write-Host "ファイル名置換" -ForegroundColor Green
Get-ChildItem -Path ".\*"

# replace file name
Write-Output ""
$targetStr = $(Write-Host "置換対象の文字列を入力: " -ForeGroundColor Green -NoNewline; Read-Host)
$replacedStr = $(Write-Host "置換後の文字列を入力: " -ForeGroundColor Green -NoNewline; Read-Host)
$files = (Get-ChildItem -Path ".\*")
foreach ($file in $files) {
    $newName = $file.Name.Replace($targetStr, $replacedStr)
    Rename-Item -LiteralPath $file.FullName -NewName $newName
}

Write-Host ""
Get-ChildItem -Path ".\*"