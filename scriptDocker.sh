#!/bin/sh
#Bem vindo ao assistente de instalação da Alpaca Solutions !

echo "Bem vindo ao assistente de instalação da Alpaca solutions."
echo "Iremos iniciar a instalação da nossa solução"

#Antes de começarmos, certifique-se de que você possui o docker instalado

echo "Antes de começarmos, assegures-se que o docker está instalado"

#Você deseja instalar o docker ? (Sim/Nao)
read -p "Você deseja instalar o docker ? (Sim/Nao):"installDocker
if["$installDocker" = "Sim"]; then

#instalando o docker
echo "instalando o docker"
sudo apt install docker.io
sleep 10
echo "Docker instalado com sucesso"

else
echo "A instalação do docker é essencial para o funcionamento de nossa aplicação"
echo "A não instalação do docker causará problemas futuros para a solução"
fi 

#Você deseja iniciar o serviço do Docker ?(Sim/Nao)
read -p "Você deseja iniciar os serviços do docker ? (Sim/Nao):"StartDocker
if["$StartDocker" = "Sim"]; then
  # Iniciando o serviço do Docker...
  echo "Iniciando o serviço do Docker..."
  sudo systemctl start docker
  sudo systemctl enable docker
  echo "Serviço do Docker iniciado com sucesso!"
else
  echo "O serviço do Docker precisa ser iniciado. para proximos passos"
  exit 1
fi

#Você deseja baixar a imagem do MySQL 5.7? (Sim/Nao)
read -p "Você deseja baixar a imagem do MySQL 5.7? (Sim/Nao): " InstallMySQL
if [ "$InstallMySQL" = "YES" ]; then
  # Baixando a imagem do MySQL 5.7...
  echo "Baixando a imagem do MySQL 5.7..."
  sudo docker pull mysql:5.7
  echo "Imagem do MySQL 5.7 baixada com sucesso!"
else
  echo "A imagem do MySQL 5.7 é necessária para a configuração da solução Alpaca."
  echo "Baixe a imagem e reinicie o assistente."
  exit 1
fi

#Você deseja criar e executar o container MySQL? (Sim/Nao)
read -p "Você deseja criar e executar o container MySQL? (Sim/Nao): " CriarDockerMySQL
if [ "$CriarDockerMySQL" = "Sim" ]; then
  # Criando e executando o container MySQL...
  echo "Criando e executando o container MySQL..."
  sudo docker run -d -p 3306:3306 --name Alpaca -e "MYSQL_ROOT_PASSWORD=aluno" mysql:5.7
  sleep 15
  echo "Container MySQL criado e em execução!"
else
  echo "A criação e execução do container MySQL são necessárias para a configuração do Magister App. Execute essa etapa e reinicie o assistente."
  exit 1
fi

#Você deseja executar o script SQL dentro do container MySQL? (Sim/Nao)
read -p "Você deseja executar o script SQL dentro do container MySQL? (Sim/Nao): " executarSQL
if [ "$executarSQL" = "YES" ]; then
  # Executando o script SQL dentro do container MySQL...
  echo "Executando o script SQL dentro do container MySQL..."
  sudo docker exec -i magister mysql -u root -paluno < /home/ubuntu/Assistentes-app/script.sql
  sleep 15
  echo "Script SQL executado com sucesso!"
else
  echo "A execução do script SQL dentro do container MySQL é crucial para a configuração da Solução Alpaca"
  echo "Execute essa etapa e reinicie o assistente."
  exit 1
fi

#Você deseja dar permissão de execução ao arquivo java.sh? (YES/NO)
read -p "Você deseja dar permissão de execução ao arquivo java.sh? (Sim/Nao): " DarPermicao
if [ "$DarPermicao" = "Sim" ]; then
  # Dando permissão de execução ao arquivo java.sh...
  echo "Dando permissão de execução ao arquivo java.sh..."
  chmod +x java.sh
  echo "Permissão concedida com sucesso!"
else
  echo "A execução do script SQL dentro do container MySQL é crucial para a configuração da Solução Alpaca"
  echo "Execute essa etapa e reinicie o assistente."
  exit 1
fi

#Você deseja executar o arquivo java.sh? (Sim/Nao)
read -p "Você deseja executar o arquivo java.sh? (Sim/Nao): " RodarJava
if [ "$RodarJava" = "Sim" ]; then
  # Executando o arquivo java.sh...
  echo "Executando o arquivo java.sh..."
  ./java.sh
  echo "Arquivo java.sh executado com sucesso!"
else
  echo "A execução do script SQL dentro do container MySQL é crucial para a configuração da Solução Alpaca"
  echo "Execute essa etapa e reinicie o assistente."
  exit 1
fi

#Configuração concluída! A solução Alpaca está pronto para uso.
echo "Configuração concluída! A solução Alpaca está pronto para uso. Aproveite!"