#!/usr/bin/env bash

readonly MIN_BASH_REQUIRED=4
readonly SCRIPT_DIR=$(dirname $0)
readonly GLOBIGNORE=*~:.*:README*:Rakefile:$(basename $0)

if [[ ${BASH_VERSINFO[0]} < $MIN_BASH_REQUIRED ]]; then
    echo -e "Error: bash ${MIN_BASH_REQUIRED}+ required. Your version: $BASH_VERSION"
    exit 1
fi

cd "$SCRIPT_DIR"

replace_all=0
for file in *; do
    replace=0
    source="$PWD/$file"
    target="$HOME/.$file"
    if [[ (( -L "$target" ) || ( -e "$target" )) && !( $replace_all = 1 ) ]]; then
        read -n 1 -p "$target: file exists. Replace? [ynaq]: " && echo
        case $REPLY in
            y) replace=1 ;;
            n) echo "Skipping." && continue ;;
            a) replace_all=1 ; replace=1 ;;
            q) echo "Aborting." && exit 1 ;;
            *) echo "Unrecognized option '$REPLY.' Skipping." && continue ;;
        esac
        if [[ $replace = 1 ]]; then
            ln -Ff -s "$source" "$target"
            echo "Replaced."
        fi
    else
        echo "Linking $target"
        ln -Ff -s "$source" "$target"
    fi
done
