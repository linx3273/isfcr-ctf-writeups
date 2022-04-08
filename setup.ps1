# This script will create a virtualenv and auto install 
# all dependencies that are needed for this program

function Green
{
    process { Write-Host $_ -ForegroundColor Green }
}

function Red
{
    process { Write-Host $_ -ForegroundColor Red }
}



cd $PSScriptRoot

Write-Output "Installing virtualenv" | Green
pip install virtualenv

Write-Output "Creating virtualenv" | Green
python -m virtualenv .venv

Write-Output "Activating virtualenv" | Green
.\.venv\Scripts\activate

Write-Output "Installing dependencies" | Green
pip install -r .\requirements.txt

Write-Output "Creating activate.ps1" | Green
".\.venv\Scripts\activate" > activate.ps1