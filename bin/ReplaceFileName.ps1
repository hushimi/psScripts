# description and list target files
Write-Host "�g���q��xlsx,pptx,docx,txt�̃t�@�C�����̈ꕔ��u��" -ForegroundColor Green
Get-ChildItem -File -Recurse -Include *.xlsx,*.pptx,*.docx,*.txt

# replace file name
$targetStr = Read-Host "�u���Ώۂ̕���������"
$replacedStr = Read-Host "�u����̕���������"
Get-ChildItem -File -Recurse -Include *.xlsx,*.pptx,*.docx,*.txt | Rename-Item -NewName {$_.Name -replace $targetStr, $replacedStr}
Write-Host ""
Get-ChildItem -File -Recurse -Include *.xlsx,*.pptx,*.docx,*.txt
