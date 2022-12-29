# Script to Get user and password from two different txt files and print each user and it's password

$users = Get-Content -Path .\users.txt
$passwords = Get-Content -Path .\passwords.txt

ForEach($user in $users){
    Write-Host("User: "+$user)
    Write-Host("Password: "+$passwords[$users.IndexOf($user)])
    Write-Host(" ")
}