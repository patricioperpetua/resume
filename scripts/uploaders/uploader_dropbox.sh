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
source scripts/config.sh

#Changing to builds folder.
cd ${CV_FOLDER_PATH}

for entry in "src"/*
do
	if [ -f ${CV_FOLDER_PATH}/pdf/${CV_OUTPUT_FILE_NAME}-${lang}.${format} ]; then
		echo "${CV_OUTPUT_FILE_NAME}-${lang}.${format}"
		curl -X POST https://content.dropboxapi.com/2/files/upload \
			--header "Authorization: Bearer ${DROPBOX_ACCESS_TOKEN}" \
			--header "Dropbox-API-Arg: {\"path\": \"${DROPBOX_FOLDER}/${VERSION}/${lang}/${CV_OUTPUT_FILE_NAME}-${lang}.pdf\"}" \
			--header "Content-Type: application/octet-stream" \
			--data-binary @"${CV_FOLDER_PATH_PDF}/${CV_OUTPUT_FILE_NAME}-${lang}.pdf"
	fi
done