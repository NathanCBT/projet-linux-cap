#!/bin/bash

note=0


#convention des 80 caractères
too_long=0

if grep -qE ".{81,}$" main.c 2>/dev/null; then
    too_long=1
fi


#présence du fichier .h ainsi que du contenu
if ! [ -f header.h ] ; then
    note=$((note-2))
else
    if grep -qE ".{81,}$" header.h 2>/dev/null; then
        too_long=1
    fi
fi

if [ $too_long -eq 1 ]; then
    note=$((note-2))
fi


# indentation
bad_indent=0

if grep -q $'\t' main.c; then
    bad_indent=1
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


echo "$note"