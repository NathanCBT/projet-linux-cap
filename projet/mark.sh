#!/bin/bash

make

note=0

#compilation

if test -f "factorielle"; then
    note=$((note+2))
else
    echo "La note est de : $note"
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

#note finale

echo "La note finale est de : $note"

make clean
