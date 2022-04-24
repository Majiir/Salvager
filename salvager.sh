#!/bin/bash

usage() {
    echo "Usage:"
    echo " $0 (-h|--help)"
    echo " $0 (-d|--dok-managed) <dok-managed-dir> [(-s|--source-out) <source-out-dir>] [(-m|--modified-source) <modified-source-dir>] [(-o|--artifacts-out) <artifacts-out-dir>]"
}

options=$(getopt \
    -o hs:d:m:o: \
    --long help,source-out:,dok-managed:,modified-source:,artifacts-out: \
    -n 'salvager' \
    -- "$@")

if [ $? != 0 ]; then usage; exit 1; fi

eval set -- "$options"

opt_source_out=
opt_dok_managed=
opt_modified_source=
opt_artifacts_out=
while true; do
  case "$1" in
    -h | --help ) usage; exit 0 ;;
    -s | --source-out ) opt_source_out="$2"; shift 2 ;;
    -d | --dok-managed ) opt_dok_managed="$2"; shift 2 ;;
    -m | --modified-source ) opt_modified_source="$2"; shift 2 ;;
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

if ! [[ -z $opt_modified_source ]]; then
    path_modified_source=$(readlink -f "$opt_modified_source")
    params+=(--volume "$path_modified_source:/mod:ro")
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
