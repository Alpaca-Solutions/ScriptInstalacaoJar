#!/bin/bash

# Bem-vindo ao Script de instalação da Alpaca Solutions
echo "Bem-vindo ao Script de instalação da Alpaca Solutions"
echo "Para começarmos, iremos atualizar o seu apt"

sudo apt update && sudo apt upgrade
sleep 10

# Agora iremos instalar o pacote de instalações
read -p "Você possui nosso pacote de instalações? (Sim/Não): " installProject
if [ "$installProject" = "Sim" ]; then
  # Atualizando o pacote
  echo "Atualizando o pacote"
  git pull
  sleep 10
  echo "Pacote atualizado com sucesso"
  cd ScriptInstalacaoJar/ || exit 1
else
  echo "Iremos baixar nosso pacote de instalação usando wget"
  wget -O ScriptInstalacaoJar.zip https://github.com/Alpaca-Solutions/ScriptInstalacaoJar/archive/main.zip
  unzip ScriptInstalacaoJar.zip
  rm ScriptInstalacaoJar.zip
  cd ScriptInstalacaoJar-main/ || exit 1
fi

# Para prosseguirmos, iremos iniciar o script do Docker
echo "Para prosseguirmos, iremos iniciar o script do Docker"
bash ScriptDocker.sh

# Agora, vamos baixar a pasta do projeto usando wget
echo "Baixando a pasta do projeto usando wget"
wget -O nome_do_arquivo.zip https://caminho/do/arquivo.zip
# Substitua "nome_do_arquivo.zip" e "https://caminho/do/arquivo.zip" pelos valores reais

# Adicione qualquer outra lógica necessária para descompactar ou instalar o projeto, se necessário

echo "Script concluído"
