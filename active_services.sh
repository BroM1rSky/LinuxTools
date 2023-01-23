#!/bin/bash
clear
# ---------------------------------------------------------------------------------------------------------------------------------------------
#  Funcions
# ---------------------------------------------------------------------------------------------------------------------------------------------
#
# -- capçalera de l'HTML
#
fitxer="serveisActius.html"
function printHdr {
    titol=$1
    echo -e "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\"  \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">" >$fitxer
    echo -e "<html xmlns=\"http://www.w3.org/1999/xhtml\">" >>$fitxer
    echo -e "   <head>" >>$fitxer
    echo -e "       <title>$titol</title>" >>$fitxer
    echo -e "   </head>" >>$fitxer
    echo -e "   <body>" >>$fitxer
}
#
# -- peu de l'HTML
#
function printFooter {
    echo -e "  </body>" >>$fitxer
    echo -e "</html>" >>$fitxer
}

# ---------------------------------------------------------------------------------------------------------------------------------------------
#  main
# ---------------------------------------------------------------------------------------------------------------------------------------------
printHdr "serveis"
echo -e "\t\t\t<table border=\"1\">" >>$fitxer
echo -e "\t\t\t\t<th>Procés</th>" >>$fitxer
echo -e "\t\t\t\t<th>Estat</th>" >>$fitxer

for p in $(systemctl | grep "running" | awk '{print $1}') ; do
    echo -e "\t\t\t\t<tr><td>$p</td>" >>$fitxer
    echo -e "\t\t\t\t<td>running</td></tr>" >>$fitxer
done

echo -e "\t\t\t</table>" >>$fitxer

printFooter;