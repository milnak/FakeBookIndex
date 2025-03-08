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

$contents `
| Sort-Object Title, Page `
| Format-Table `
@{ Name = 'Title'; Expression = 'Title'; Width = 40 },
@{ Name = 'Book'; Expression = 'Book'; Width = 35 },
@{ Name = 'Page'; Expression = 'Page'; Width = 3 }
