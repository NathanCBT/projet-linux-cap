#!/bin/bash

make

#création du csv s'il n'existe pas

read firstname surname < readme.txt
if ! test -f "notes.xlsx"; then
    echo "Nom,Prénom,Note" >> notes.xlsx
fi

note=0

#compilation

if test -f "factorielle"; then
    note=$((note+2))
else
    echo "'$firstname','$surname',$note" >> notes.xlsx
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

#convention des 80 caractères

if grep -Ec ".{81,}$" main.c -o header.h ; then
    note=$((note-2))
fi

# indentation
bad_indent=0

if grep -q $'\t' main.c; then
    bad_indent=1=
fi

if grep -qE "^(  )* [^ ]" main.c; then
    bad_indent=1
fi

if grep -qE "[^[:space:]]+.*\{" main.c; then
    bad_indent=1
fi

if grep "}" main.c | grep -vE "^[[:space:]]*\}[[:space:]]*$" > /dev/null; then
    bad_indent=1
fi

if grep "}" main.c | grep -E "^[[:space:]]*\}" | grep -qvE "^(  )*\}"; then
    bad_indent=1
fi

if [ $bad_indent -eq 1 ]; then
    note=$((note-2))
fi

#règle make clean

if grep -q "^clean:" Makefile ; then
    make clean >/dev/null 2>&1
    if [ -f factorielle ]; then
        note=$((note-2))
    fi
else
    note=$((note-2))
fi

#présence du fichier .h

if find . -type f -name "*.h" -exec grep -q "int factorielle( int number )" {} \; ; then
    :
else
    note=$((note-2))
fi


#note finale et csv
echo "'$firstname','$surname',$note" >> notes.xlsx

make clean
