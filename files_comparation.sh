#!/bin/bash
clear
# ------------------------------------------------------------------------------
#  compara dos arxius
# ------------------------------------------------------------------------------
vermell=`tput setaf 1`
verd=`tput setaf 2`
blanc=`tput setaf 7`
groc=`tput setaf 3`

read -p "Introdueix el primer arxiu : " f1
if [ -f $f1 ] ; then
    read -p "Introdueix el segon arxiu : " f2
    if [ -f $f2 ] ; then
        if diff $f1 $f2 > /dev/null ; then
            echo -e "\n${verd}Els fitxers $f1 i $f2 són iguals${blanc}"
        else
            echo -e "\n${groc}Els fitxers $f1 i $f2 són diferents${blanc}"
        fi
    else
        echo -e "\n${vermell}El fitxer $f2 no existeix${blanc}"
    fi
else 
    echo -e "\n${vermell}El fitxer $f1 no existeix${blanc}"
fi
echo -e "\n"
