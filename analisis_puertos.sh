#!/bin/bash

#Declaramos la variables que podemos usar para formatear el color del texto
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

#si hacemos control+c para salir de la aplicación se ejecuta la función ctrl_c
trap ctrl_c INT

function ctrl_c(){
        #salimos
        echo -e "\n\n${yellowColour}[*]${endColour}${grayColour} Exiting...\n${endColour}"
        #devolvemos el cursor (que hemos ocultado con tput civis al final) y realizamos una salida "NO" exitosa
        tput cnorm; exit 1
}
tput civis
ip=$1
if [ ! $ip ];then
        echo -e "\nModo de empleo:\n"
        echo -e "\n.\analisis_puertos.sh <DIRECCION_IP>\n"
        exit 1
fi

for port in $(seq 1 65535); do
        timeout 1 bash -c "echo '' > /dev/tcp/$ip/$port" 2> /dev/null
        valido=$(echo $?)
        if [ $(echo $valido) -eq "0"  ]; then
                echo -e "\n${redColour}[*] El puerto $port esta abierto\n${endColour}"
        fi
done
tput cnorm; exit 0
