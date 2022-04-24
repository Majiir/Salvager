#!/bin/bash

set -e

echo "Decompiling..."
export PATH="$PATH:/root/.dotnet/tools"
ilspycmd \
    -o /src \
    -p \
    -lv CSharp5 \
    /dok/BBI.*.dll
echo "Done."

if [ -d "/src-out" ]
then
    echo "Copying sources..."
    cp -r /src/. /src-out/
    echo "Done."
fi
