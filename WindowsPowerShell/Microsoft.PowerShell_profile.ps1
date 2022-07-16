# Aliases
$binDir = $home + "\Documents\bin"
New-Alias psedit powershell_ise.exe -Description "edit PS script in PowershellIse"
New-Alias ep edit-profile -Description "edit Profile"
New-Alias bin cd-bin -Description "move to bin folder"
New-Alias replace-fname $binDir\ReplaceFileName.ps1 -Description "Replace File name"
New-Alias find $binDir\Find.ps1 -Description "search files"

function edit-profile { powershell_ise.exe $profile}
function cd-bin { cd $binDir }

<#
----------------------------------
@brief Customize prompt
----------------------------------
#>
function prompt {
    # Assign Windows Title text
    $host.UI.RawUI.WindowTitle = "CurrentFolder: $pwd"

    # set variables
    $cuFolder = Split-Path -Path $pwd -Leaf
    $psUser = [Security.Principal.WindowsIdentity]::GetCurrent().Name
    $us = New-Object System.Globalization.CultureInfo('en-us')
    $cuTime = (Get-Date).ToString('dddd hh:mm:ss tt', $us)
    $isAdmin = (New-Object Security.Principal.WindowsPrincipal (
        [Security.Principal.WindowsIdentity]::GetCurrent())
    ).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
    
    # --------------------------------
    # Decorate prompt
    # --------------------------------
    Write-Host ''
    Write-Host ($(if ($isAdmin) { 'Elevated' } else { '' })) -BackgroundColor DarkRed -ForegroundColor White -NoNewline
    if ($cuFolder -like '*:*') {
        Write-Host " $cuFolder " -ForegroundColor Cyan -NoNewline
    } else {
        Write-Host ".\$cuFolder\ " -ForegroundColor Cyan -NoNewline
    }

    Write-Host " $cuTime `r`n" -ForegroundColor Red -NoNewline
    Write-Host "($psUser)>" -ForegroundColor White -NoNewline
    return " "
}

<#
----------------------------------
@brief Show customized alias
----------------------------------
#>
function myps() {
    Write-Host "Customized alias" -ForegroundColor Yellow
    Compare-Object (Get-Alias) (PowerShell -NoProfile {Get-Alias}) -Property Name,Description |sort Name
}

<#
----------------------------------
@brief start new ps session as admin
----------------------------------
#>
function admin {
    if ($args.Count -gt 0) {   
       $argList = "& '" + $args + "'"
       Start-Process "$psHome\powershell.exe" -Verb runAs -ArgumentList $argList
    } else {
       Start-Process "$psHome\powershell.exe" -Verb runAs
    }
}