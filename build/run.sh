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

if [ -d "/out" ]
then
    echo "Compiling..."
    dotnet build -o /out-tmp /src
    cp -r /out-tmp/BBI.*.dll /out/
fi
