#Bem vindo ao Script de instalação da Alpaca Solutions
echo "Bem vindo ao Script de instalação da Alpaca Solutions"
echo "Para começarmos, iremos atualizar o seu apt"
sudo apt update && sudo apt upgrade -y

#Verificando se o pacote de instalação está presente
read -p "Você possui nosso pacote de instalações? (Sim/Nao): " installProject
if [ "$installProject" = "Sim" ]; then
  # Atualizando o pacote
  echo "Atualizando o pacote"
  if [ -d "ScriptInstalacaoJar" ]; then
    cd ScriptInstalacaoJar/ || exit 1
    git pull
    sleep 5
    echo "Pacote atualizado com sucesso"
  else
    echo "Diretório 'ScriptInstalacaoJar' não encontrado."
    exit 1
  fi
else
  echo "Iremos baixar nosso pacote de instalação usando wget"
  sudo apt install wget -y
fi

#Para prosseguirmos, iremos iniciar o script do Docker
echo "Para prosseguirmos, iremos iniciar o script do Docker"
if [ -f "ScriptDocker.sh" ]; then
  chmod +x ScriptDocker.sh
  ./ScriptDocker.sh # Executando o script com permissões de execução
else
  echo "Arquivo 'ScriptDocker.sh' não encontrado."
  exit 1
fi

echo "Script concluído"