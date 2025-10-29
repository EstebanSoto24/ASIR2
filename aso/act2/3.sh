#!/bin/bash
if [ $# -eq 0 ]; then
	for i in $(seq 0 1 10); do
		echo "$i"
	done
else
	echo "El número de parámetros no es el correcto"
fi
