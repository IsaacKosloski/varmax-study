#/!bin/bash

# Nome do arquivo de ambiente
ENV_FILE="environment.yml"

echo "Verificando se o arquivo $ENV_FILE existe..."

if [ ! -f "$ENV_FILE" ]; then
    echo "Erro: arquivo $ENV_FILE não encontrado."
    exit 1
fi

echo "Criando ambiente conda a partir de $ENV_FILE ..."
conda env create -f "$ENV_FILE"

# Extrai automaticamente o nome do ambiente do YAML
ENV_NAME=$(grep '^name:' "$ENV_FILE" | awk '{print $2}')

echo "Ativando Ambiente $ENV_NAME ..."
source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate $ENV_NAME

echo "Registrando kernel do Jupyter..."
python -m ipykernel install --user --name="$ENV_NAME" --display-name="Python ($ENV_NAME)"

echo ""
echo "==================================================="
echo "Ambiente '$ENV_NAME' criado com sucesso!"
echo ""
echo "Para usar futuramente:"
echo "source \$(conda info --base)/etc/profile.d/conda.sh"
echo "conda activate $ENV_NAME"
echo "jupyter lab"
echo "==================================================="
