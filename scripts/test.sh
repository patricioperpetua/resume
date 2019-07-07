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

if ! type "hackmyresume" &> /dev/null; then
    echo "hackmyresume is not installed. Please install it and re-run this script."
	echo "you can install it using scripts/installers/installer_hack_my_resume.sh"
    exit 1
fi

if ! type "resume" &> /dev/null; then
    echo "jsonresume is not installed. Please install it and re-run this script."
	echo "you can install it using scripts/installers/installer_json_resume.sh"
    exit 1
fi

if [ -f src/basics.json ]; then
    hackmyresume validate src/basics.json
fi
for entry in "src"/*
do
	if [ -d ${entry} ]; then
		lang="${entry:4}"
		echo "found language ${lang}"
		if [ -f src/${lang}/${lang}-jrs.json ]; then
            hackmyresume validate src/${lang}/${lang}-jrs.json
            if [ -f src/${lang}/${lang}-complement-jrs.json ]; then
                hackmyresume validate src/${lang}/${lang}-complement-jrs.json
            fi
        fi
    fi
done