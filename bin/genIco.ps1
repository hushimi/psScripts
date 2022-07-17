<#

#>
$outPath = "$PSScriptRoot\ico\0xf3.ico"

$Bitmap = [System.Drawing.Bitmap]::new(64, 64, [System.Drawing.Imaging.PixelFormat]::Format24bppRgb)
$g = [System.Drawing.Graphics]::FromImage($Bitmap)

# çïÇ≈ìhÇËÇ¬Ç‘Çµ
$rect = [System.Drawing.Rectangle]::new(2, 2, 64, 64)
$g.FillRectangle([System.Drawing.Brushes]::Black, $rect);

# ï∂éöÇï`Ç≠
$font = [System.Drawing.Font]::new("Consolas", 27);
$g.DrawString("F3", $font, [System.Drawing.Brushes]::Aqua, 9, 15);
#$g.DrawString("f3", $font, [System.Drawing.Brushes]::Aqua, 12, 34);
$g.Dispose()

$icon = [System.Drawing.Icon]::FromHandle($Bitmap.GetHicon())
$fs = [System.IO.FileStream]::new($outPath, [System.IO.FileMode]::Create, [System.IO.FileAccess]::Write)
$icon.Save($fs)
$fs.Close()
$icon.Dispose()
$Bitmap.Dispose()