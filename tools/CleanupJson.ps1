[CmdletBinding(SupportsShouldProcess)]
Param([string]$Path = '.')

foreach ($file in (Get-ChildItem -File -Path $Path -Filter '*.json')) {
    $content = Get-Content  -LiteralPath $file | ConvertFrom-Json

    # Remove duplicate spaces
    $content | ForEach-Object {
        if ($_.Composer -match '[ ]{2,}') { $_.Composer = $_.Composer -replace ' +', ' ' }
        if ($_.Title -match '[ ]{2,}') { $_.Title = $_.Title -replace ' +', ' ' }
    }

    # Move any parenthetical title to end of title, e.g.
    # "(LOVE IS) THE TENDER TRAP" -> "THE TENDER TRAP (LOVE IS)"
    $content | ForEach-Object {
        if ($_.Title[0] -eq '(') {
            $idx = $_.Title.IndexOf(') ')
            if ($idx -ne -1) {
                $_.Title = $_.Title.Substring($idx + 2) + ' ' + $_.Title.Substring(0, $idx + 1)
            }
        }
    }

    # Move determiners to end of string, comma separated
    'a', 'an', 'the' | ForEach-Object {
        $determiner = $_
        $content | Where-Object Title -like "$determiner *" | ForEach-Object {
            $_.Title = '{0}, {1}' -f $_.Title.Substring($determiner.Length + 1), $_.Title.Substring(0, $determiner.Length)
        }
    }

    $result = $content | ConvertTo-Json

    if ($result -ne (Get-Content  -LiteralPath $file | ConvertFrom-Json | ConvertTo-Json)) {
        if ($PSCmdlet.ShouldProcess($file, "Update file")) {
            $content | ConvertTo-Json | Out-File -Encoding utf8 $file
        }
    }
}

