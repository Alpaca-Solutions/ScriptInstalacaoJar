#!/bin/bash

# Bem vindo ao Script de instalação da Alpaca Solutions
echo "Bem vindo ao Script de instalação da Alpaca Solutions"
echo "Para começarmos, iremos atualizar o seu apt"
sudo apt install 
sudo apt update
sleep 5

# Agora iremos instalar o pacote de instalações
read -p "Você possui nosso pacote de instalações? (Sim/Nao): " installProject
if [ "$installProject" = "Sim" ]; then
  # Atualizando o pacote
  echo "Atualizando o pacote"
  cd ScriptInstalacaoJar/ || exit 1
  git pull
  sleep 5
  echo "Pacote atualizado com sucesso"
else
  echo "Iremos baixar nosso pacote de instalação usando wget"
  sudo apt intall wget
  wget -O ScriptInstalacaoJar.zip https://github.com/Alpaca-Solutions/ScriptInstalacaoJar/archive/main.zip
  sudo apt install unzip
  unzip ScriptInstalacaoJar.zip
  rm ScriptInstalacaoJar.zip
  cd ScriptInstalacaoJar-main/ || exit 1
fi

# Concedendo permissões de execução ao script
chmod +x ScriptDocker.sh

# Para prosseguirmos, iremos iniciar o script do Docker
echo "Para prosseguirmos, iremos iniciar o script do Docker"
./ScriptDocker.sh # Executando o script com permissões de execução

echo "Script concluído"
