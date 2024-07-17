'a','the' | ForEach-Object {
    $determiner = $_
    foreach ($file in (Get-ChildItem -File '*.json')) {
        $content = Get-Content  $file | ConvertFrom-Json
        $content | Where-Object Title -like "$determiner *" | ForEach-Object {
            $_.Title = '{0}, {1}' -f $_.Title.Substring($determiner.Length+1), $_.Title.Substring(0, $determiner.Length)
        }

        $content | ConvertTo-Json | Out-File -Encoding ascii $file
    }
}

