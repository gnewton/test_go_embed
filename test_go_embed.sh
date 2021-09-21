#!/bin/env bash
# Author: Glen Newton
# Copyright (c) Glen Newton 2021
# License: BSD
#
set -e

# Num files to test (starting at 1)
max_num_files=100

((s0=1024)) #1K
((s1=s0*s0)) #1M
((s2= s1 * s0)) #1M
((embed_file_size=$s1*500)) #500M

# Size of test files
BIN=test_embed_size

block_size=4096

for (( num_files=0; num_files < max_num_files; num_files++))
#  for num_files in {0..10..2}               
do
    echo " "
    echo "####START################### num files=" $((num_files+1)) " file size=" $((embed_file_size/1024)) " MB  total size=" $((embed_file_size * (num_files+1)/1024)) "MB"
    rm $BIN || true

    if [ ! -f go.mod ]; then
        go mod init github.com/gnewton/${BIN}
    fi

    echo "package main" > main.go
    echo "import _ \"embed\"" >> main.go

    echo $embed_file_size
    for (( i=0; i<=${num_files}; i++ ))
    do
        filename="f_${embed_file_size}_${i}.data"
        variable="f_${embed_file_size}_${i}"
        echo $filename

        echo "//go:embed $filename">> main.go
        echo "var $variable []byte" >> main.go
        echo " " >> main.go
        if [ ! -f $filename ]; then
            dd if=/dev/urandom of=${filename} bs=${block_size} count=$((${embed_file_size}/${block_size}))
        fi
    done

    echo "func main() {" >> main.go
    echo "" >> main.go
    echo "" >> main.go

    echo $embed_file_size
    for (( i=0; i<=${num_files}; i++ ))
    do
        filename="f_${embed_file_size}_${i}"
        echo "    print(\"${filename}\", \" : \", string(${filename}[0]), \"\n\")" >> main.go
        echo "    print(\"${filename}\", \" : \", string(${filename}[len(${filename})-1]), \"\n\")" >> main.go
    done

    echo "" >> main.go
    echo "}" >> main.go

    echo "# Building Go"
    go build

    echo "# Running Go"
    ./test_embed_size
    echo "####END###################"
    echo ""
done


