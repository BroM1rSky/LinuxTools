#!/bin/bash
clear
# ------------------------------------------------------------------------------
#  canviar els membres d'un grup a un altre
# ------------------------------------------------------------------------------
vermell=`tput setaf 1`
verd=`tput setaf 2`
blanc=`tput setaf 7`
groc=`tput setaf 3`
if [ $# -lt 2 ]; then
   echo -e "\n${vermell}Falten els noms dels grups${blanc}"
else
   if [ $# -gt 2 ]; then
      echo -e "\n${vermell}Hi ha massa parametres${blanc}"
   else
      if [ ! $(grep -w "$1" /etc/group) ]; then
         echo -e "\n${vermell}El grup $1 no existeix${blanc}"
      else
         if [ ! $(grep -w "$2" /etc/group) ]; then
            echo -e "\n${vermell}El grup $2 no existeix${blanc}"
         else
            membres=$(cat /etc/group | grep -w "$1" | cut -d ":" -f 4)
            readarray -d ',' -t vDades <<< "$membres"
            for (( i=0; i < ${#vDades[@]}; i++ ))
            do
               if [ -n "${vDades[i]}" ]; then
                  nom=$(echo "${vDades[$i]}" | sed 's/h//')   # treiem els possibles intros
                  echo -e "${verd}$nom --> $2${blanc}"
				  # posem l'usuari com a membre del grup $2
                  usermod "$nom" -G "$2"
				  # treiem l'usuari del grup $1
                  gpasswd -d "$nom" "$1"
	       fi
            done
         fi
      fi
   fi
fi
echo -e "\n"
