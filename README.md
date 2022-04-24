# Salvager

Code patch tool for Deserts of Kharak. Create `diff`-style patches for the game's C# code and apply them to the base game binaries to create a distributable mod.

## Requirements

- Docker
- Docker Compose
- an unmodified version of Deserts of Kharak (see [Usage](#usage) for details)

## Usage

```
./salvager.sh <DOK-MANAGED-PATH> <SOURCE-OUTPUT-PATH>
```

where

- `<DOK-MANAGED-PATH>` is the path to the `Deserts of Kharak/Data/Managed/` folder of a fresh, unmodified installation of Deserts of Kharak.
- `<SOURCE-OUTPUT-PATH>` is the path where the tool will write decompiled source files.
