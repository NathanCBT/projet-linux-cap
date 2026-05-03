#!/bin/bash

note=0

#convention des 80 caractères

if grep -qE ".{81,}$" main.c header.h 2>/dev/null; then
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

#présence du fichier .h

if find . -type f -name "*.h" -exec grep -q "int factorielle( int number )" {} \; ; then
    :
else
    note=$((note-2))
fi

echo "$note"