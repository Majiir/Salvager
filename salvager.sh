#!/bin/bash

usage() {
    echo "Usage:"
    echo " $0 (-h|--help)"
    echo " $0 (-m|--dok-managed) <dok-managed-dir> [(-s|--source-out) <source-out-dir>]"
}

options=$(getopt \
    -o hs:m: \
    --long help,source-out:,dok-managed: \
    -n 'salvager' \
    -- "$@")

if [ $? != 0 ]; then usage; exit 1; fi

eval set -- "$options"

opt_source_out=
opt_dok_managed=
while true; do
  case "$1" in
    -h | --help ) usage; exit 0 ;;
    -s | --source-out ) opt_source_out="$2"; shift 2 ;;
    -m | --dok-managed ) opt_dok_managed="$2"; shift 2 ;;
    * ) break ;;
  esac
done

if [[ -z $opt_dok_managed ]]
then
    echo "Missing required option: (-m|--dok-managed) <dok-managed-dir>"
    echo
    usage
    exit 1
fi

params=()
if ! [[ -z $opt_source_out ]]; then
    path_out=$(readlink -f "$opt_source_out")
    params+=(--volume "$path_out:/src")
fi

path_dok=$(readlink -f "$opt_dok_managed")

docker-compose run \
    --volume "$path_dok:/dok:ro" \
    "${params[@]}" \
    salvager
