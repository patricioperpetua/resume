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

#Setting global variables.
source config.sh

#Execute builder if builds folder does not exists...
if [ ! -d ${CV_FOLDER_PATH} ]; then
	echo -ne "Building resume..."
	source scripts/builder.sh
fi

if [ -d builds/${VERSION} ]; then
	echo -ne "Deleting older files under ${VERSION} folder...\n"
	rm -r builds/${VERSION}
fi
mkdir -p builds/${VERSION}

for lang in ${LANGUAGES[@]}
do
	mkdir LATEST/${lang}
	mkdir ${VERSION}/${lang}
	echo -ne "*Copying cv (${lang}):\n"
	for format in ${FORMATS[@]}
	do
		if [ -f ${CV_OUTPUT_FILE_NAME}-${lang}.${format} ]; then
			echo -ne "   -(${format})\n"
			echo -ne "      .Folder ${VERSION}...\n"
			cp "${CV_OUTPUT_FILE_NAME}-${lang}.${format}" "${VERSION}/${lang}/${CV_OUTPUT_FILE_NAME}-${lang}.${format}"
            echo -ne "      .Folder LATEST...\n"
			cp "${CV_OUTPUT_FILE_NAME}-${lang}.${format}" "LATEST/${lang}/${CV_OUTPUT_FILE_NAME_LATEST}-${lang}.${format}"
		fi
	done
done