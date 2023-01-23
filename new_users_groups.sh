#!/bin/bash
# ----------------------------------------------------------------
#  funcions
# ----------------------------------------------------------------
function nouGrup {
   if $(grep -q "$1" /etc/group) ; then
      echo -e "El grup $1 ja existeix"
   else
      groupadd "$1"
      echo -e "S'ha creat el grup $1"  
   fi
}

function nouUsuari {
   if $(grep -q "$1" /etc/passwd) ; then
   
      echo -e "L'usuari $1 ja existeix"
   else
      a=$(date +%Y)
      psw="_$1@$a"
      pswKrypt=$(openssl passwd -1 ${psw})
      useradd "$1"  -c "$2" -p "$pswKrypt"
      echo -e "S'ha creat l'usuari $1 ($2)"
   fi
}

function gestioLinia {
   readarray -d '#' -t vDades <<< "$1"
   case ${vDades[0]} in
      "group") nouGrup "${vDades[1]}" "${vDades[2]}"
               ;;
      "user")  nouUsuari  "${vDades[1]}" "${vDades[2]}"
               grups=${vDades[3]}
               for (( i=4; i < ${#vDades[@]}; i++ ))
               do
                  grups="${grups},${vDades[i]}"
               done
               usermod -a ${vDades[1]} -G ${grups}
               ;;
   esac
}
# ----------------------------------------------------------------
# main
# ----------------------------------------------------------------
clear
nomFitxer="GrupsUsuaris.txt"

if [ -f "$nomFitxer" ]; then
   while IFS= read -r ln
   do
      gestioLinia "$ln"
   done < "$nomFitxer"

else
   echo "No trobo el fitxer $nomFitxer"
fi
# ----------------------------------------------------------------
