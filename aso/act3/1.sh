#!/bin/bash
read -p "Introduce un número --> " numero1
read -p "Introduce otra número --> " numero2

if [ $numero1 -ge $numero2 ]; then
	if [ $numero1 -eq $numero2 ]; then
		echo "$numero1 es igual que $numero2"
	else
		echo "$numero1 es mayor que $numero2"
	fi
else
	echo "$numero2 es mayor que $numero1"
fi
