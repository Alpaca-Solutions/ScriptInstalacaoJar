#!/bin/bash
sudo apt update && sudo apt upgrade


java -version 
if [ $? = 0 ]; 
then 
echo “Cliente possui java instalado!” 
else 
echo “Você não possui java instalado!”
  
  read instalar
  if [ \“$intalar\” == \“s\” ];
then #entao
sudo apt install openjdk-17-jre -y 
fi 

fi 

git clone https://github.com/Alpaca-Solutions/Jar-Api-Conectando-ao-Banco.git

cd Jar-Api-Conectando-ao-Banco/

git pull/

cd v2-jar-alpaca-solutions/target/

java -jar v2-jar-alpaca-solutions-1.0-jar-with-dependecies.jar