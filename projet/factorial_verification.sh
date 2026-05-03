#!/bin/bash

#correction de la factorielle
note=0

correct_factorial() {
    nb=$1
    f=1
    for (( i=2; i<=nb; i++ )); do
        f=$((f * i))
    done
    echo "$f"
}

#cas particulier

result=$(./factorielle 0 )
if [ $result -eq 1 ]; then
    note=$((note+3))
fi

#cas général

index=1
is_result_true=1
while [ $index -le 10 ] && [ $is_result_true -eq 1 ]; do
    result=$(./factorielle "$index")
    true_result=$(correct_factorial "$index")
    if [ $result -ne $true_result ]; then
        is_result_true=0
    fi
    index=$((index+1))
done

if [ $is_result_true -eq 1 ]; then
    note=$((note+5))
fi

#points finaux concernant l'algorithme de la factorielle

echo "$note"