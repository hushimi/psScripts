<#
Load .Net methods
#>
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
[void] [System.Windows.Forms.Application]::EnableVisualStyles()
Add-Type -Name Window -Namespace Console -MemberDefinition '
[DllImport("Kernel32.dll")]
public static extern IntPtr GetConsoleWindow();

[DllImport("user32.dll")]
public static extern bool ShowWindow(IntPtr hWnd, Int32 nCmdShow);
'
<#
@brief Show and close console
#>
function Show-Console {
    $consolePtr = [Console.Window]::GetConsoleWindow()
    [Console.Window]::ShowWindow($consolePtr, 4)
}
function Hide-Console{
    $consolePtr = [Console.Window]::GetConsoleWindow()
    [Console.Window]::ShowWindow($consolePtr, 0)
}

# Get files
$tgtStr = $(Write-Host "File Name??: " -ForeGroundColor Green -NoNewline; Read-Host)
$files = (Get-ChildItem -Path ".\*" -Filter "*$tgtStr*" -Recurse)

# create form
$formWidth = 600
$formHeight = 400
$form = [System.Windows.Forms.Form]@{
    Size = "$formWidth, $formHeight"
    StartPosition = "centerscreen"
    Font = "Consolas, 9pt"
    Text = "Result"
    BackColor = [System.Drawing.ColorTranslator]::FromHtml("#2a1b2e")
    ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#1adfea")
    AutoScroll = $true
    MaximizeBox = $false
    MinimizeBox = $false
    #ControlBox = $false
}
$form.Add_Load({Hide-Console})
$form.Add_Closing({Show-Console})

# Add link text to form
$yAxis = 45
foreach ($file in $files) {
    # get file info
    $parentPath = (Split-Path $file.FullName -Parent)
    $parentName = (Split-Path $parentPath -Leaf)
    $fullPath = $file.FullName
    $fileName = $file.Name
    if (Test-Path -PathType Container -LiteralPath $fullPath) {
        $fileName = "(Dir)$fileName"
    }
    

    # create parent LinkLabel
    $parentLabel = [System.Windows.Forms.LinkLabel]@{
        Location = "24, $yAxis"
        Text = "Parent: $parentName"
        TextAlign = "MiddleLeft"
        LinkColor = [System.Drawing.ColorTranslator]::FromHtml("#1adfea")
        AutoSize = $true
    }
    $parentEvent = {Start-Process $parentPath}.GetNewClosure()
    $parentLabel.Add_Click($parentEvent)
    $form.Controls.Add($parentLabel)
    $yAxis += 27
    
    # create child LinkLabel
    $childLabel = New-Object System.Windows.Forms.LinkLabel
    $childLabel = [System.Windows.Forms.LinkLabel]@{
        Location = "36, $yAxis"
        Text = "$fileName"
        TextAlign = "MiddleLeft"
        LinkColor = [System.Drawing.ColorTranslator]::FromHtml("#e422bd")
        LinkBehavior = [System.Windows.Forms.LinkBehavior]::NeverUnderline
        AutoSize = $true
    }
    $childEvent = {Start-Process $fullPath}.GetNewClosure()
    $childLabel.Add_Click($childEvent)
    $form.Controls.Add($childLabel)

    $yAxis += 40
}

$form.Showdialog()