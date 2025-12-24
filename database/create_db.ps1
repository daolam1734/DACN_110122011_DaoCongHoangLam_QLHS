<#
PowerShell helper to create database and user using psql CLI.
Usage examples:
  # Option A: provide postgres superuser password in PGPASSWORD env var (temporary for this session)
  $env:PGPASSWORD = 'your_postgres_password'
  .\create_db.ps1 -DbName tvu_hoso_dnn -DbUser tvu_user -DbPassword 'change_me'

  # Option B: run interactively and enter postgres superuser password when prompted
  .\create_db.ps1 -DbName tvu_hoso_dnn -DbUser tvu_user -DbPassword 'change_me' -PromptSuperPass
#>

param(
  [string]$PgHost = 'localhost',
  [int]$PgPort = 5432,
  [string]$PgSuperUser = 'postgres',
  [switch]$PromptSuperPass = $false,
  [string]$DbName = 'tvu_hoso_dnn',
  [string]$DbUser = 'tvu_user',
  [string]$DbPassword = 'change_me'
)

if ($PromptSuperPass) {
  $superPass = Read-Host -Prompt "Postgres superuser password (will not be stored)" -AsSecureString
  $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($superPass)
  $plain = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
  $env:PGPASSWORD = $plain
}

Write-Host "Creating database '$DbName' and user '$DbUser' on ${PgHost}:${PgPort} ..."

# create database
psql -h $PgHost -p $PgPort -U $PgSuperUser -c "CREATE DATABASE $DbName;"

# create user and grant privileges
psql -h $PgHost -p $PgPort -U $PgSuperUser -c "CREATE USER $DbUser WITH PASSWORD '$DbPassword';"
psql -h $PgHost -p $PgPort -U $PgSuperUser -c "GRANT ALL PRIVILEGES ON DATABASE $DbName TO $DbUser;"

Write-Host "Done. You can test connection with: psql -h $PgHost -p $PgPort -U $DbUser -d $DbName"
