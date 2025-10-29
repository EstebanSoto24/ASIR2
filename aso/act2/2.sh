#!/bin/bash
if [ $# -eq 1 ]; then
	if [ -r $1 ]; then
		cat $1
	else
		echo "Este fichero no tiene permisos de escritura"
	fi
else
	echo "Debes introducir al menos un parámetro"
fi



