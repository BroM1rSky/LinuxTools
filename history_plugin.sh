echo -e " Ordres executades a la consola"
history | awk '{print $2}' | sort  --unique 
echo -e "\n*** Fi del procés ***\n"
