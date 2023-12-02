#!/bin/bash

# Nome do contêiner Docker
container_nome="java-app"

# URL do arquivo JAR no GitHub
jar_url="https://github.com/Alpaca-Solutions/Back-End-Alpaca-Solutions/raw/main/Jar%20Alpaca%20Solutions/target/v2-jar-alpaca-solutions-1.0-jar-with-dependencies.jar"

# Nome do arquivo JAR após o download
jar_nome="v2-jar-alpaca-solutions-1.0-jar-with-dependencies.jar"

# Verificar se o arquivo JAR já existe
if [ ! -f "$jar_nome" ]; then
    echo "Baixando o arquivo JAR..."
    # Instale o wget se não estiver instalado
    sudo apt install wget -y
    # Baixar o arquivo JAR usando wget
    wget "$jar_url" -O "$jar_nome"

    # Verificar se o download foi bem-sucedido
    if [ $? -eq 0 ]; then
        echo "Download do arquivo JAR concluído com sucesso."
    else
        echo "Erro ao baixar o arquivo JAR."
        exit 1
    fi
else
    echo "Arquivo JAR já existe. Pulando o download."
fi

# Criar o arquivo Dockerfile
echo "Criando o arquivo Dockerfile..."
echo "FROM openjdk:17" > Dockerfile
echo "COPY $jar_nome /app.jar" >> Dockerfile
echo "CMD java -jar /app.jar" >> Dockerfile

# Construir a imagem Docker
echo "Construindo a imagem Docker..."
sudo docker build -t "$container_nome" .

# Verificar se a construção da imagem foi bem-sucedida
if [ $? -eq 0 ]; then
    echo "Construção da imagem Docker concluída com sucesso."
else
    echo "Erro ao construir a imagem Docker."
    exit 1
fi

# Executar o contêiner Docker
echo "Executando o contêiner Docker..."
sudo docker run --rm -it "$container_nome"

# Verificar se a execução foi bem-sucedida
if [ $? -eq 0 ]; then
    echo "Execução do contêiner Docker bem-sucedida."
else
    echo "Erro ao executar o contêiner Docker."
fi
