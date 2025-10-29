#!/bin/bash
if [ $# -eq 0 ]; then
	cont=0
	while [ $cont -le 10 ]; do
		echo "$cont"
		cont=$(($cont + 1))
	done
else
	echo "El número de parámetros no es el correcto"
fi
