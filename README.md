# Salvager

Code patch tool for Deserts of Kharak. Create `diff`-style patches for the game's C# code and apply them to the base game binaries to create a distributable mod.

## Requirements

- Docker
- Docker Compose
- an unmodified version of Deserts of Kharak (see [Usage](#usage) for details)

## Usage

```
./salvager.sh (-h|--help)
./salvager.sh (-d|--dok-managed) <dok-managed-dir> [(-s|--source-out) <source-out-dir>] [(-a|--apply-patches) <patch-dir>] [(-m|--modified-source) <modified-source-dir> [(-g|--generate-patch) <generated-patch-file>]] [(-o|--artifacts-out) <artifacts-out-dir>]
```

- `-h|--help`: display command usage.
- `-d|--dok-managed <dok-managed-dir>` (required): path to the `Deserts of Kharak/Data/Managed/` folder of a fresh, unmodified installation of Deserts of Kharak.
- `-s|--source-out <source-out-dir>` (optional): path where the tool will write decompiled source files.
- `-a|--apply-patches <patch-dir>` (optional): directory containing patch files to apply on top of the decompiled source.
- `-m|--modified-source <modified-source-dir>` (optional): path to modified source files. The compiled artifacts will be built from this source instead of the decompiled and patched source.
- `-g|--generate-patch <generated-patch-file>` (optional, requires `-m|--modified-source`): output location for patch file representing changes between decompiled and modified source.
- `-o|--artifacts-out <artifacts-out-dir>` (optional): path where the tool will write recompiled assemblies.
