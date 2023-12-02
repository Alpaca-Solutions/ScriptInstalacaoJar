#!/bin/sh

echo "Bem-vindo ao assistente de instalação da Alpaca Solutions."
echo "Iremos iniciar a instalação da nossa solução"

# Verifica se o Docker está instalado
if ! command -v docker &> /dev/null; then
  echo "Docker não está instalado. Por favor, instale o Docker antes de prosseguir."
  exit 1
fi

# Inicia os serviços do Docker
read -p "Você deseja iniciar os serviços do Docker? (Sim/Não): " startDocker
if [ "$startDocker" = "Sim" ]; then
  echo "Iniciando os serviços do Docker..."
  sudo systemctl start docker
  sudo systemctl enable docker
  echo "Serviços do Docker iniciados com sucesso!"
else
  echo "Os serviços do Docker precisam ser iniciados para prosseguir com a instalação."
  exit 1
fi

# Baixa a imagem do MySQL 5.7
read -p "Você deseja baixar a imagem do MySQL 5.7? (Sim/Não): " installMySQL
if [ "$installMySQL" = "Sim" ]; then
  echo "Baixando a imagem do MySQL 5.7..."
  sudo docker pull mysql:5.7
  echo "Imagem do MySQL 5.7 baixada com sucesso!"
else
  echo "A imagem do MySQL 5.7 é necessária para a configuração da solução Alpaca."
  echo "Baixe a imagem e reinicie o assistente."
  exit 1
fi

# Cria e executa o container MySQL
read -p "Você deseja criar e executar o container MySQL? (Sim/Não): " createMySQLContainer
if [ "$createMySQLContainer" = "Sim" ]; then
  echo "Criando e executando o container MySQL..."
  sudo docker run -d -p 3306:3306 --name Alpaca -e "MYSQL_ROOT_PASSWORD=aluno" mysql:5.7
  echo "Container MySQL criado e em execução!"
else
  echo "A criação e execução do container MySQL são necessárias para a configuração da Solução Alpaca."
  echo "Execute essa etapa e reinicie o assistente."
  exit 1
fi

# Executa o script SQL dentro do container MySQL
read -p "Você deseja executar o script SQL dentro do container MySQL? (Sim/Não): " executeSQL
if [ "$executeSQL" = "Sim" ]; then
  echo "Executando o script SQL dentro do container MySQL..."
  sudo docker exec -i Alpaca mysql -u root -paluno < /home/ubuntu/ScriptInstalacaoJar/ScriptAlpacaSolution_v4_20-11.sql
  echo "Script SQL executado com sucesso!"
else
  echo "A execução do script SQL dentro do container MySQL é crucial para a configuração da Solução Alpaca."
  echo "Execute essa etapa e reinicie o assistente."
  exit 1
fi

# Dá permissão de execução ao arquivo scriptjava.sh
echo "Dando permissão de execução ao arquivo scriptjava.sh..."
chmod +x scriptjava.sh
echo "Permissão concedida com sucesso!"

# Configuração concluída! A solução Alpaca está pronta para uso.
echo "Configuração concluída! A solução Alpaca está pronta para uso. Aproveite!"