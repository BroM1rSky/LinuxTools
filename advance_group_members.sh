#!/bin/bash
clear
# ------------------------------------------------------------------------------
#  quins usuaris són membres d'un grup
# ------------------------------------------------------------------------------
hdr="--------------------------------------------"
vermell=`tput setaf 1`
verd=`tput setaf 2`
blanc=`tput setaf 7`
groc=`tput setaf 3`

if [ $# -lt 1 ]; then
   echo -e "\n${vermell}Falta el nom del grup${blanc}"
else
   if [ $# -gt 1 ]; then
      echo -e "\n${vermell}Hi ha massa parametres${blanc}"
   else
      if [ $(grep -w "$1" /etc/group) ]; then
         membres=$(cat /etc/group | grep "$1:x:" | cut -d ":" -f 4)

		echo -e "\n${hdr}"
		echo -e "Membres del grup $1"
		echo -e "${hdr}"
		 # fem un split per la coma
			 readarray -d ',' -t vDades <<< "$membres"
			 for u in ${vDades[@]}
			 do
				usuari=$(echo "$u" | sed 's/h//')   # treiem els possibles intros
				echo -e "${verd}$usuari${blanc}"
			 done
		 echo ${hdr}
		  else
			 echo -e "\n${vermell}El grup $1 no existeix${blanc}"
		  fi
   fi
fi
echo -e "\n"