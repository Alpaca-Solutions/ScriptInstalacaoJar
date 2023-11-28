#!/bin/bash

# URL do arquivo JAR no GitHub
jar_url="https://github.com/Alpaca-Solutions/Jar Alpaca Solutions/target/v2-jar-alpaca-solutions-1.0-jar-with-dependencies.jar"
# Nome do arquivo JAR após o download
jar_nome="v2-jar-alpaca-solutions-1.0-jar-with-dependencies.jar"
# Nome da imagem Docker
docker_image_name="java-container"

echo "Agora iremos verificar se você já possui o Docker instalado, aguarde um instante..."
sleep 5

if ! command -v docker &> /dev/null; then
    echo "Você não possui o Docker instalado."
    echo "Confirme se deseja instalar o Docker (S/N)?"
    read inst
    if [ "$inst" == "S" ]; then
        echo "Ok! Você escolheu instalar o Docker."
        
        # Instalação do Docker
        curl -fsSL https://get.docker.com -o get-docker.sh
        sudo sh get-docker.sh
        
        echo "Docker instalado com sucesso!"
    else
        echo "Você optou por não instalar o Docker no momento."
    fi
else
    echo "Você já possui o Docker instalado!"
fi

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

# Criar imagem Docker para o Java
echo "Criando a imagem Docker para o Java..."
cat <<EOF > Dockerfile
FROM openjdk:17
COPY $jar_nome /app.jar
CMD ["java", "-jar", "/app.jar"]
EOF

# Construir a imagem Docker
sudo docker build -t "$docker_image_name" .

# Verificar se a construção da imagem foi bem-sucedida
if [ $? -eq 0 ]; then
    echo "Imagem Docker criada com sucesso."
else
    echo "Erro ao criar a imagem Docker."
    exit 1
fi

# Executar o contêiner Docker
echo "Executando o contêiner Docker..."
sudo docker run --rm "$docker_image_name"

# Verificar se a execução foi bem-sucedida
if [ $? -eq 0 ]; then
    echo "Execução do arquivo JAR bem-sucedida."
else
    echo "Erro ao executar o arquivo JAR."
fi
