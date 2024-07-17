param ([Parameter(Mandatory)][string]$Path)

# Remove redundant spaces in Composer field

$out = Get-Content $Path `
| ConvertFrom-Json  `
| Select-Object Page,Title,@{Name='Composer';Expression={$_.Composer -replace '  ',' '}} `
| Sort-Object {[int]$_.page} `

$out `
| ConvertTo-Json `
| Out-File $Path
