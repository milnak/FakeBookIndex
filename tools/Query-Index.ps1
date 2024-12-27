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
            Book     = $book
            Page     = $_.Page
            Title    = $_.Title
            Composer = $_.Composer
        }
    }
}

while ($true) {
    $search = Read-Host -Prompt 'Title (ctrl-c to exit)'
    $contents | Where-Object Title -like "*$search*" | Format-List @{
        Name       = 'Title'
        Expression = { '{0} ({1})' -f $_.Title, $_.Composer }
    },
    @{
        Name       = 'Location'
        Expression = { '{0}, pg. {1}' -f $_.Book, $_.Page }
    }
}
