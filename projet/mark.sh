#!/bin/bash
make 
./factorielle $1

note=o


if test -f "factorielle"; then
    note=$((note+2))
    echo "La compilation fonctionne"
    echo "La note est de : $note"
else
    echo "La compilation fonctionne pas"
    echo "La note est de : $note"
fi

make clean



