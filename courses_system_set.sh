#!/bin/bash
clear
# ------------------------------------------------------------------------------
#  fer carpetes de documents per a un grup
# ------------------------------------------------------------------------------
vermell=`tput setaf 1`
verd=`tput setaf 2`
blanc=`tput setaf 7`
groc=`tput setaf 3`
#-------------------------------------------------------------------------------
#  funcions
# ------------------------------------------------------------------------------
function crearCarpeta {
	if [ -d "$1" ] ; then 
		echo -e "${vermell}La carpeta $1 ja existeix${blanc}"
	else
		mkdir "$1"
		if [ -d "$1" ]; then
			echo "${verd} S'ha creat la carpeta $1 ${blanc}"
		else
			echo "${vermell} No s'ha pogut crear la carpeta $1 ${blanc}"
		fi
	fi
}
# ------------------------------------------------------------------------------

if [ $# -lt 2 ]; then
   echo -e "\n${vermell}Cal introduir 2 paràmetres: curs i grup${blanc}"
else
	if [ $# -gt 2 ]; then
		echo -e "\n${vermell}Hi ha massa parametres${blanc}"
	else
		#  carpeta arrel dels documents
		docs="/DOCUMENTS"
		if [ ! -d "$docs" ]; then
			crearCarpeta $docs
		fi
		if [ -d "$docs" ]; then
			if [ -d "$docs/$1" ]; then
				rm "$docs/$1" -r
			fi
			crearCarpeta "$docs/$1"
		fi
		if [ -d "$docs/$1" ]; then
			#  En el grep afegim :x: per a assegurar-nos que filtrem per la primera part de la línia
			if [ $(grep "$2:x:" /etc/group) ]; then
				membres=$(cat /etc/group | grep -w "$2:x:" | cut -d ":" -f 4)
				readarray -d ',' -t vDades <<< "$membres"
				for u in ${vDades[@]}
				do
					usuari=$(echo "$u" | sed 's/h//')   # treiem els possibles intros
					crearCarpeta "$docs/$1/$u"
					if [ -d "$docs/$1/$u" ] ; then
						chown root "$docs/$1/$u"
						chgrp $u "$docs/$1/$u"
						chmod 770 "$docs/$1/$u"
					fi
				done
			else
				echo -e "\nEl grup $1 no existeix\n"
			fi
		fi
	fi
fi
echo -e "\n"

