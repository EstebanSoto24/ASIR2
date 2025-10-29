#!/bin/bash

if [ $USER == "root" ]; then
	echo "Enhorabuena eres superusuario si puedes ejecutar este script"
else
	echo "Lo siento no puedes ejecutar el script"
fi
