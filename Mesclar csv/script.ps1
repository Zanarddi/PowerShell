$path=".\result" #target folder
cd $path;

$csvs = Get-ChildItem .\* -Include *.csv
$y=$csvs.Count

Write-Host "Detected the following CSV files: ($y)"
foreach ($csv in $csvs)
{
Write-Host " "$csv.Name
}

$outputfilename = $(get-date -f yyyyMMdd) + "_combined-data.xlsx" #creates file name with date

Write-Host Creating: $outputfilename

$excelapp = new-object -comobject Excel.Application
$excelapp.sheetsInNewWorkbook = $csvs.Count
$xlsx = $excelapp.Workbooks.Add()
$sheet=1

foreach ($csv in $csvs)
{
$row=1
$column=1
$worksheet = $xlsx.Worksheets.Item($sheet)
$worksheet.Name = $csv.Name
$file = (Get-Content $csv)
foreach($line in $file)
{
$linecontents=$line -split ',(?!\s*\w+")'
foreach($cell in $linecontents)
{
$worksheet.Cells.Item($row,$column) = $cell
$column++
}
$column=1
$row++
}
$sheet++
}
$output = $path + "\" + $outputfilename
Write-Host $output
$excelapp.DisplayAlerts = $false
# $xlsx.SaveAs("C:\Users\gustavonunes\Desktop\programs\powershell\Mesclar csv\result\test.xlsx")
$xlsx.SaveAs(".\20230103_combined-data.xlsx")
$excelapp.quit()
cd ..

Pause