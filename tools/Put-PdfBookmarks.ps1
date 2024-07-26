<#
.SYNOPSIS
    Take contents of a JSON file and create bookmarks for a PDF file.
.EXAMPLE
    PS> ./Put-PdfBookmarks.ps1 -JsonPath 'Real Book 1.json' -PdfPath 'Real Book 1.pdf'
    Will add Page, Title and Composer as found in JSON as bookmarks in PDF.
.NOTES
    PDF file will be created with "_bmk" appended to name.
    [pdftk.exe](https://en.wikipedia.org/wiki/PDFtk) must be installed.
#>

param(
  # Path to Json file
  [Parameter(Mandatory)] [string]$JsonPath,
  # Path to PDF File
  [Parameter(Mandatory)] [string]$PdfPath,
  # Page offset to add to "Page" field in Json file
  [int]$PageOffset = 0
)

"Getting info from PDF [$PdfPath]"
$pdfInfo = Get-Item -ErrorAction Stop $PdfPath
$targetPath = $pdfInfo.DirectoryName + '\' + $pdfInfo.BaseName + '_bmk' + $pdfInfo.Extension

if (!(Get-Command -CommandType Application 'pdftk.exe')) {
  Write-Warning 'pdftk.exe not installed.'
  return
}

$bookmarkPath = [IO.Path]::GetTempFileName()
"Generating bookmarks from [$JsonPath] to [$bookmarkPath]"

$bookmarks = Get-Content -ErrorAction Stop $JsonPath `
   | ConvertFrom-Json `
   | Sort-Object Page
| ForEach-Object {
  @'
BookmarkBegin
BookmarkTitle: {0} [{1}]
BookmarkLevel: 1
BookmarkPageNumber: {2}
'@ -f $_.Title,$_.Composer,($_.Page + $PageOffset)
}
$bookmarks | Out-File $bookmarkPath -Encoding ascii

"Writing bookmarks to new PDF [$targetPath]"
pdftk.exe $PdfPath update_info $bookmarkPath output $targetPath

Remove-Item $bookmarkPath
'Done'
