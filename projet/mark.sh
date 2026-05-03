#!/bin/bash

make

#création du csv s'il n'existe pas

read firstname surname < readme.txt
if ! test -f "notes.csv"; then
    echo "Nom,Prénom,Note" | iconv -f UTF-8 -t ISO-8859-1 >> notes.csv
fi

note=0

#compilation

if test -f "factorielle"; then
    note=$((note+2))
else
    echo "'$firstname','$surname',$note" >> notes.csv
    exit 1
fi

#messages d'erreur

msg=$(./factorielle)
if  [ "$msg" = "Erreur: Mauvais nombre de parametres" ]; then
    note=$((note+4))
fi

msg=$(./factorielle -16)
if [ "$msg" = "Erreur: nombre negatif" ]; then
    note=$((note+4))
fi

if grep -q "int factorielle( int number )" * ; then
    note=$((note+2))
fi

#points factorielle

note=$((note + $(./factorial_verification.sh)))

#malus

note=$((note + $(./penalty.sh)))

#note finale et csv
echo "'$firstname','$surname',$note" >> notes.csv

make clean
