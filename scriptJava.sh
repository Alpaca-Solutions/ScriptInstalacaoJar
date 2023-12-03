#!/bin/bash

# Nome do contêiner Docker
container_nome="java-app"

# URL do arquivo JAR no GitHub
jar_url="https://github.com/Alpaca-Solutions/Back-End-Alpaca-Solutions/raw/main/target/sistema-nowl-1.0-jar-with-dependencies.jar"

# Nome do arquivo JAR após o download
jar_nome="v2-jar-alpaca-solutions-1.0-jar-with-dependencies.jar"

# Verificar se o arquivo JAR já existe
if [ ! -f "$jar_nome" ]; then
    echo "Baixando o arquivo JAR..."
    # Instale o wget se não estiver instalado
    sudo apt-get install wget -y
    # Baixar o arquivo JAR usando wget
    if ! wget -q "$jar_url" -O "$jar_nome"; then
        echo "Erro ao baixar o arquivo JAR."
        exit 1
    fi
    echo "Download do arquivo JAR concluído com sucesso."
else
    echo "Arquivo JAR já existe. Pulando o download."
fi

# Verificar se o Docker está instalado
if ! command -v docker &> /dev/null; then
    echo "Docker não encontrado. Certifique-se de que o Docker esteja instalado e executando."
    exit 1
fi

# Criar o arquivo Dockerfile
echo "Criando o arquivo Dockerfile..."
cat <<EOF > Dockerfile
FROM openjdk:17
COPY $jar_nome /app.jar
CMD java -jar /app.jar
EOF

# Construir a imagem Docker
echo "Construindo a imagem Docker..."
if ! sudo docker build -t "$container_nome" .; then
    echo "Erro ao construir a imagem Docker."
    exit 1
fi
echo "Construção da imagem Docker concluída com sucesso."

# Executar o contêiner Docker
echo "Executando o contêiner Docker..."
if ! sudo docker run --rm -it "$container_nome"; then
    echo "Erro ao executar o contêiner Docker."
    exit 1
fi
echo "Execução do contêiner Docker bem-sucedida."