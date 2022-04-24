#!/bin/bash

set -e

echo "Decompiling..."
export PATH="$PATH:/root/.dotnet/tools"
ilspycmd \
    -o /src \
    -p \
    -lv CSharp5 \
    /dok/BBI.*.dll

if [ -d "/src-out" ]
then
    echo "Copying sources..."
    cp -r /src/. /src-out/
fi

if [ -d "/mod" ]
then
    echo "Applying modified source..."
    exit_code=0
    diff -Naur src/ mod/ > mod.patch || exit_code=$?
    if [ $exit_code -gt 1 ]
    then
        cat mod.patch
        exit 1
    fi
    cp -f mod.patch mod.patch.out
    patch -p0 < mod.patch
fi

if [ -d "/out" ]
then
    echo "Compiling..."
    dotnet build -o /out-tmp /src
    cp -r /out-tmp/BBI.*.dll /out/
fi
