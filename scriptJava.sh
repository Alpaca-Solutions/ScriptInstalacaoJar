#!/bin/bash

# URL do arquivo JAR no GitHub
jar_url="https://github.com/Alpaca-Solutions/Back-End-Alpaca-Solutions/raw/main/Jar Alpaca Solutions/target/v2-jar-alpaca-solutions-1.0-jar-with-dependencies.jar"

# Nome do arquivo JAR após o download
jar_nome="v2-jar-alpaca-solutions-1.0-jar-with-dependencies.jar"

# Nome do container
container_nome="container-java"

# Verificar se o container já está em execução
if [ "$(docker ps -q -f name=$container_nome)" ]; then
    echo "O container $container_nome já está em execução."
else
    # Verificar se o container existe
    if [ "$(docker ps -aq -f name=$container_nome)" ]; then
        # Iniciar o container
        echo "Iniciando o container $container_nome..."
        docker start $container_nome
    else
        # Verificar se a imagem do Java 17 está presente
        if [[ "$(docker images -q openjdk:17 2> /dev/null)" == "" ]]; then
            echo "A imagem do Java 17 não está presente. Baixando..."
            docker pull openjdk:17
        fi

        # Criar e executar o container
        echo "Criando e executando o container $container_nome..."
        docker run -d -v "$(pwd)/$jar_nome:/app.jar" --name $container_nome openjdk:17 java -jar /app.jar
    fi
fi