Get-ChildItem -File '*.json' `
  | ForEach-Object {
    Get-Content $_ `
    | ConvertFrom-Json `
    | Where-Object Composer -NE '' `
    | Group-Object Composer
  } `
   | Select-Object -ExpandProperty Name `
   | Sort-Object -Unique
