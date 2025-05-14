#!/usr/bin/bash

cwd=`pwd`

. ./scriptVariables.txt

cd $dirData/transferWget

for f in *; do
    if [ -d "$f" ]; then
        cat $f/*opsproc3*.txt > ${f}.opsproc3.txt
    fi
done

