#!/bin/bash

usage() {
    echo "Usage:"
    echo " $0 (-h|--help)"
    echo " $0 (-d|--dok-managed) <dok-managed-dir> [(-s|--source-out) <source-out-dir>] [(-a|--apply-patches) <patch-dir>] [(-m|--modified-source) <modified-source-dir> [(-g|--generate-patch) <generated-patch-file>]] [(-o|--artifacts-out) <artifacts-out-dir>]"
}

options=$(getopt \
    -o hs:a:d:m:g:o: \
    --long help,source-out:,dok-managed:,apply-patches:,modified-source:,generate-patch:,artifacts-out: \
    -n 'salvager' \
    -- "$@")

if [ $? != 0 ]; then usage; exit 1; fi

eval set -- "$options"

opt_source_out=
opt_dok_managed=
opt_patch_dir=
opt_modified_source=
opt_generated_patch=
opt_artifacts_out=
while true; do
  case "$1" in
    -h | --help ) usage; exit 0 ;;
    -s | --source-out ) opt_source_out="$2"; shift 2 ;;
    -d | --dok-managed ) opt_dok_managed="$2"; shift 2 ;;
    -a | --apply-patches ) opt_patch_dir="$2"; shift 2 ;;
    -m | --modified-source ) opt_modified_source="$2"; shift 2 ;;
    -g | --generate-patch ) opt_generated_patch="$2"; shift 2 ;;
    -o | --artifacts-out ) opt_artifacts_out="$2"; shift 2 ;;
    * ) break ;;
  esac
done

if [[ -z $opt_dok_managed ]]
then
    echo "Missing required option: (-d|--dok-managed) <dok-managed-dir>"
    echo
    usage
    exit 1
fi

params=()
if ! [[ -z $opt_source_out ]]; then
    path_out=$(readlink -f "$opt_source_out")
    params+=(--volume "$path_out:/src-out")
fi

if ! [[ -z $opt_patch_dir ]]; then
    path_patch_dir=$(readlink -f "$opt_patch_dir")
    params+=(--volume "$path_patch_dir:/patch")
fi

if ! [[ -z $opt_modified_source ]]; then
    path_modified_source=$(readlink -f "$opt_modified_source")
    params+=(--volume "$path_modified_source:/mod:ro")

    if ! [[ -z $opt_generated_patch ]]; then
        path_generated_patch=$(readlink -f "$opt_generated_patch")
        touch $path_generated_patch
        params+=(--volume "$path_generated_patch:/mod.patch.out")
    fi
else
    if ! [[ -z $opt_generated_patch ]]; then
        echo "Error: -g|--generate-patch requires -m|--modified-source"
        echo
        usage
        exit 1
    fi
fi

if ! [[ -z $opt_artifacts_out ]]; then
    path_artifacts_out=$(readlink -f "$opt_artifacts_out")
    params+=(--volume "$path_artifacts_out:/out")
fi

path_dok=$(readlink -f "$opt_dok_managed")

docker-compose run \
    --volume "$path_dok:/dok:ro" \
    "${params[@]}" \
    salvager
