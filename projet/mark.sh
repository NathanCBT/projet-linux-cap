#!/bin/bash

if [ -z "$1" ]; then
    echo "Mettre en paramètre un nombre"
    echo "Exemple : $0 <nombre>"
    exit 1
fi

make

note=0

if test -f "factorielle"; then
    note=$((note+2))
    echo "La compilation fonctionne"
else
    echo "La compilation ne fonctionne pas"
    echo "La note est de : $note"
    exit 1
fi

#correction de la factorielle
nb=$1
f=1

for (( i=2; i<=nb; i++ )); do
    f=$((f * i))
done

echo "Résultat attendue : $f"

#résultat du projet
result=$(./factorielle "$nb")

echo "Résultat du programme : $result"

if [ "$result" -eq "$f" ]; then
    echo "Le résultat est correcte"
    note=$((note+5))
else
    echo "Le résultat est faux"
fi

echo "La note finale est de : $note"

make clean
