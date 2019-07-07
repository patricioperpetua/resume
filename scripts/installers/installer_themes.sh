#!/usr/bin/env bash

# Web Page of BASH best practices https://kvz.io/blog/2013/11/21/bash-best-practices/
#Exit when a command fails.
set -o errexit
#Exit when script tries to use undeclared variables.
set -o nounset
#The exit status of the last command that threw a non-zero exit code is returned.
set -o pipefail

#Trace what gets executed. Useful for debugging.
#set -o xtrace

# Set magic variables for current file & dir
__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__file="${__dir}/$(basename "${BASH_SOURCE[0]}")"
__base="$(basename ${__file} .sh)"
__root="$(cd "$(dirname "${__dir}")" && pwd)"

if ! type "npm" &> /dev/null; then
    echo "npm is not installed. Please install it and re-run this script."
    exit 1
fi

# TODO: use available themes to generate npm install script.
# NPM_TEXT=
# for theme in ${AVAILABLE_THEMES[@]}
# do
# done

npm install \
    jsonresume-theme-eloquent \
    jsonresume-theme-polymer \
    jsonresume-theme-modern \
    jsonresume-theme-business-card \
    jsonresume-theme-elegant \
    jsonresume-theme-paper \
    jsonresume-theme-kendall \
    jsonresume-theme-flat \
    jsonresume-theme-classy \
    jsonresume-theme-class \
    jsonresume-theme-short \
    jsonresume-theme-slick \
    jsonresume-theme-kwan \
    jsonresume-theme-onepage \
    jsonresume-theme-spartan \
    jsonresume-theme-stackoverflow \
    fresh-standard/fresh-themes