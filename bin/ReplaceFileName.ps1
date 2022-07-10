# description and list target files
Write-Host "拡張子がxlsx,pptx,docx,txtのファイル名の一部を置換" -ForegroundColor Green
Get-ChildItem -File -Recurse -Include *.xlsx,*.pptx,*.docx,*.txt

# replace file name
$targetStr = Read-Host "置換対象の文字列を入力"
$replacedStr = Read-Host "置換後の文字列を入力"
Get-ChildItem -File -Recurse -Include *.xlsx,*.pptx,*.docx,*.txt | Rename-Item -NewName {$_.Name -replace $targetStr, $replacedStr}
Write-Host ""
Get-ChildItem -File -Recurse -Include *.xlsx,*.pptx,*.docx,*.txt
