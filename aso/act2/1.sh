#!/bin/bash
if [ $# -eq 1 ]; then
	if [ -f $1 ]; then
		echo "El fichero $1 si existe"
		echo "El tamaño del fichero es $(stat -c %s $1)"
	else
		echo "El fichero $1 no existe"
	fi

	if [ -d $1 ];then
		echo "$1 si es un directorio"
		echo "El tamaño del directorio es $(du -sh $1)"
	fi

else
	echo "Debes introducir al menos un parámetro"
fi
