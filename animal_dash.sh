#!/bin/sh
printf '\033c\033]0;%s\a' flappy bat adventure
base_path="$(dirname "$(realpath "$0")")"
"$base_path/animal_dash.x86_64" "$@"
