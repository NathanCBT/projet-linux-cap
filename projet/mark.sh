#!/bin/bash

make


#création du csv s'il n'existe pas
read firstname surname < readme.txt
if ! test -f "note.csv"; then
    echo "Nom,Prénom,Note" >> note.csv
fi

note=0


#compilation
if test -f "factorielle"; then
    note=$((note+2))
else
    echo "'$firstname','$surname',$note" >> note.csv
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


# signature dans main.c (obligatoire)
has_sig=1

if ! grep -q "int factorielle( int number )" main.c 2>/dev/null; then
    has_sig=0
fi


# si header.h existe, il doit aussi avoir la signature
if [ -f header.h ] && ! grep -q "int factorielle( int number )" header.h 2>/dev/null; then
    has_sig=0
fi

if [ $has_sig -eq 1 ]; then
    note=$((note+2))
fi


#points factorielle
note=$((note + $(./factorial_verification.sh)))


#malus
note=$((note + $(./penalty.sh)))


#note finale et csv
echo "'$firstname','$surname',$note" >> note.csv

make clean
