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
