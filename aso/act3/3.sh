#!/bin/bash

function operacion() {
	read -p "Introduce un número --> " numero1
	read -p "Introduce otro número --> " numero2
	
	case "$1" in
		1)
			echo "La suma de $numero1 mas $numero2 es $(($numero1 + $numero2))"
		;;
		2)
			echo "La resta de $numero1 menos $numero2 es $(($numero1 - $numero2))"
		;;
		3)
			if [ $numero2 -eq 0 ]; then
				echo "La division entre 0 no se puede hacer"
			else
				echo "La división de $numero1 entre $numero2 es $(($numero1 /$numero2))"
			fi
		;;
		4)
			echo "La multiplicacion de $numero1 por $numero2 es $(($numero1 * $numero2))"
		;;
	esac
}

function sumar() {
	numeros=$(pedir_numeros)
	echo $numeros[0]
}

function restar() {
	echo "hola"
}

function dividir() {
	echo "hola"
}

function multiplicar() {
	echo "hola"
}

if [ $# -eq 0 ]; then
	while true; do
		clear
		echo -e "1 - Sumar \n2 - Restar\n3 - Dividir\n4 - Multiplicar\n0 - Salir"
		read -p "Escribe la opcion --> " opcion
		case "$opcion" in
			0)
				echo "Saliendo...."
				exit 123
			;;
			1)
				operacion 1				
			;;
			2)
				operacion 2
			;;
			3)
				operacion 3
			;;
			4)
				operacion 4
			;;
			*)
				echo "Esta opción no es valida"
			;;
		esac
		read -p "Pulsa Intro para volver al menú "
	done
else
	echo "El número de parámetros es incorrecto"
fi
