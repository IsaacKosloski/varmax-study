# setup_env.ps1

$EnvFile = "environment.yml"

Write-Host "Verificando se o arquivo $EnvFile existe..."

if (-Not (Test-Path $EnvFile)) {
    Write-Host "Erro: arquivo $EnvFile não encontrado."
    exit 1
}

# Localiza o conda
$CondaPath = Get-Command conda -ErrorAction SilentlyContinue

if (-not $CondaPath) {
    Write-Host "Erro: Conda não encontrado no PATH."
    Write-Host "Abra o 'Anaconda Prompt' ou execute o script após configurar o conda."
    exit 1
}

# Extrai o nome do ambiente do environment.yml
$EnvName = (Select-String '^name:' $EnvFile).Line.Split(':')[1].Trim()

Write-Host "Criando ambiente conda '$EnvName' a partir de $EnvFile ..."
conda env create -f $EnvFile

if ($LASTEXITCODE -ne 0) {
    Write-Host "Erro ao criar o ambiente."
    exit 1
}

Write-Host "Inicializando suporte ao conda no PowerShell..."
conda init powershell | Out-Null

Write-Host "Ativando ambiente $EnvName ..."
conda activate $EnvName

Write-Host "Registrando kernel do Jupyter..."
python -m ipykernel install --user `
    --name="$EnvName" `
    --display-name="Python ($EnvName)"

if ($LASTEXITCODE -ne 0) {
    Write-Host "Erro ao registrar o kernel."
    exit 1
}

Write-Host ""
Write-Host "==================================================="
Write-Host "Ambiente '$EnvName' criado com sucesso!"
Write-Host ""
Write-Host "Para usar futuramente:"
Write-Host "conda activate $EnvName"
Write-Host "jupyter lab"
Write-Host "==================================================="
