param (
    # Path to JSON index files
    [Parameter(Mandatory)]
    [string]
    $Path
)

$contents = Get-ChildItem -File -LiteralPath $Path -Include '*.json' | ForEach-Object {
    $book = $_.BaseName
    Get-Content $_.FullName | ConvertFrom-Json | ForEach-Object {
        [PSCustomObject]@{
            Location = ('{0} ({1})' -f $book, $_.Page)
            Title    = $_.Title
            Composer = $_.Composer
        }
    }
}

while ($true) {
    $search = Read-Host -Prompt 'Title? '
    $contents | Where-Object Title -like "*$search*" | Format-List
}
