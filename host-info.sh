#!/bin/bash
# ------------------------------------------------------------
#  funcions
# ------------------------------------------------------------
function menu {
   opcio=""
   clear

   echo "INXI"
   echo "-----------------------------------------"
   echo " A - Sistema operatiu"
   echo " B - Processador"
   echo " C - Temperatura CPU"
   echo " D - Temperatura Granollers"
   echo " E - Memòria RAM"
   echo " F - Emmagatzematge"
   echo " G - Velocitat targes xarxa"
   echo -e " Z - Sortir\n"

   read -p " Selecciona una opcio : " opcio
   opcio=${opcio}             # converteix a majúscules
}

function sistema {
   distro=$(inxi -S | cut -d ":" -f 7)
   kernel=$(inxi -S | awk '{print $5}')
   bits=$(inxi -S | awk '{print $8}')
   echo -e "\nDistribució : $distro"
   echo -e "Kernel      : $kernel"
   echo -e "Bits        : $bits"
}

function processador {
   model=$(inxi -C | grep "model" | cut -d ":" -f 3)
   variant=$(inxi -C | grep "model" | cut -d ":" -f 5 | awk '{print $1}')
   echo -e "\nModel  : $model"
   echo -e "Variant: $variant"
}

function tempCPU {
   temp=$(inxi -s | grep "cpu" | cut -d ":" -f 4 | awk '{print $1}')
   echo -e "\nTemperatura CPU  : $temp"

}

function tempGranollers {
   temp=$(inxi -W "Granollers,Spain")
   echo -e "\nTemperatura Granollers : $temp"
}

function ram {
   grandaria=$(inxi -m | grep "total" | cut -d ":" -f 4 | awk '{print $1}')
   unitatsGrandaria=$(inxi -m | grep "total" | cut -d ":" -f 4 | awk '{print $2}')
   ocupada=$(inxi -m | grep "used" | cut -d ":" -f 5 | awk '{print $1}')
   unitatsOcupada=$(inxi -m | grep "used" | cut -d ":" -f 5 | awk '{print $2}')
   lliure=$(free -h | grep "Mem:" | awk '{print $4}')
   echo -e "\nRAM total      : $grandaria $unitatsGrandaria"
   echo -e "RAM disponible : $lliure"
   echo -e "RAM ocupada    : $ocupada $unitatsOcupada"
}

function emmagatzematge {
   grandaria=$(inxi -d | grep "total" | cut -d ":" -f 4 | awk '{print $1}')
   unitatsGrandaria=$(inxi -d | grep "total" | cut -d ":" -f 4 | awk '{print $2}')
   ocupada=$(inxi -d | grep "used" | cut -d ":" -f 5 | awk '{print $1}')
   unitatsOcupada=$(inxi -d | grep "used" | cut -d ":" -f 5 | awk '{print $2}')
   echo -e "\nEspai total      : $grandaria $unitatsGrandaria"
   echo -e "Espai ocupada    : $ocupada $unitatsOcupada"
}

function velocitatTarges {
   eth0=$(inxi -n | grep "eth0" | grep "speed" | cut -d ":" -f 4 | awk '{print $1}')
   wlan0=$(inxi -n | grep "wlan0" | grep "speed" | cut -d ":" -f 4 | awk '{print $1}')
   echo -e "\nVelocitat eth0  : $eth0"
   echo -e "Velocitat wlan0 : $wlan0"
}


# -----------------------------------------------------------
#  main
# -----------------------------------------------------------
while [ "$opcio" != "Z" ]; do
   menu

   case  "$opcio" in
      "A") sistema
           ;;
      "B") processador
           ;;
      "C") tempCPU
           ;;
      "D") tempGranollers
           ;;
      "E") ram
           ;;
      "F") emmagatzematge
           ;;
      "G") velocitatTarges
           ;;
      "Z") echo -e "\nAdéu, que vagi bé!!!!   :)\n\n"
           ;;
      *)   echo "Opció incorrecta"
           ;;
   esac
   if [ "$opcio" != "Z" ]; then
      echo  -e "\n<prem intro per a continuar>"
      read
   fi
done
# ----------------------------------------------------------
