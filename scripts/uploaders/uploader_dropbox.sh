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
__base="$(basename "${__file}" .sh)"
__root="$(cd "$(dirname "${__dir}")" && pwd)"

#Setting global variables.
source scripts/config.sh

# To create a folder if needed
# curl -X POST https://api.dropboxapi.com/2/files/create_folder_v2 \
#     --header "Authorization: Bearer ${DROPBOX_ACCESS_TOKEN}" \
#     --header "Content-Type: application/json" \
#     --data "{\"path\": \"/${DROPBOX_FOLDER}/${VERSION}\",\"autorename\": false}" \
# 	> /dev/null 2>&1

CV_FOLDER_PATH_LATEST="${CV_FOLDER_NAME}/latest"

for entry in "src"/*
do
	lang="${entry:4}"
	if [ -f "src/${lang}/${lang}-jrs.json" ]; then
		echo "found language ${lang}"
		if [ -f "${CV_FOLDER_PATH_PDF}/${CV_OUTPUT_FILE_NAME}-${lang}.pdf" ]; then
			echo "${CV_OUTPUT_FILE_NAME}-${lang}.pdf"
			curl -X POST https://content.dropboxapi.com/2/files/upload \
				--header "Authorization: Bearer ${DROPBOX_ACCESS_TOKEN}" \
				--header "Dropbox-API-Arg: {\"path\": \"/${DROPBOX_FOLDER}/${VERSION}/pdf/${CV_OUTPUT_FILE_NAME}-${lang}.pdf\", \"mode\": \"overwrite\"}" \
				--header "Content-Type: application/octet-stream" \
				--data-binary @"${CV_FOLDER_PATH_PDF}/${CV_OUTPUT_FILE_NAME}-${lang}.pdf"

			curl -X POST https://content.dropboxapi.com/2/files/upload \
				--header "Authorization: Bearer ${DROPBOX_ACCESS_TOKEN}" \
				--header "Dropbox-API-Arg: {\"path\": \"/${DROPBOX_FOLDER}/${VERSION}/html/${CV_OUTPUT_FILE_NAME}-${lang}.html\", \"mode\": \"overwrite\"}" \
				--header "Content-Type: application/octet-stream" \
				--data-binary @"${CV_FOLDER_PATH_HTML}/${CV_OUTPUT_FILE_NAME}-${lang}.html"

			curl -X POST https://content.dropboxapi.com/2/files/upload \
				--header "Authorization: Bearer ${DROPBOX_ACCESS_TOKEN}" \
				--header "Dropbox-API-Arg: {\"path\": \"/${DROPBOX_FOLDER}/${VERSION}/${CV_OUTPUT_FILE_NAME}-${lang}.json\", \"mode\": \"overwrite\"}" \
				--header "Content-Type: application/octet-stream" \
				--data-binary @"${CV_FOLDER_PATH}/${CV_OUTPUT_FILE_NAME}-${lang}.json"

			if [ "${CURRENT_BRANCH}" == "master" ]; then
				curl -X POST https://content.dropboxapi.com/2/files/upload \
					--header "Authorization: Bearer ${DROPBOX_ACCESS_TOKEN}" \
					--header "Dropbox-API-Arg: {\"path\": \"/${DROPBOX_FOLDER}/latest/pdf/${CV_OUTPUT_FILE_NAME_LATEST}-${lang}.pdf\", \"mode\": \"overwrite\"}" \
					--header "Content-Type: application/octet-stream" \
					--data-binary @"${CV_FOLDER_PATH_LATEST}/pdf/${CV_OUTPUT_FILE_NAME}-${lang}.pdf"

				curl -X POST https://content.dropboxapi.com/2/files/upload \
					--header "Authorization: Bearer ${DROPBOX_ACCESS_TOKEN}" \
					--header "Dropbox-API-Arg: {\"path\": \"/${DROPBOX_FOLDER}/latest/html/${CV_OUTPUT_FILE_NAME_LATEST}-${lang}.html\", \"mode\": \"overwrite\"}" \
					--header "Content-Type: application/octet-stream" \
					--data-binary @"${CV_FOLDER_PATH_LATEST}/html/${CV_OUTPUT_FILE_NAME}-${lang}.html"

				curl -X POST https://content.dropboxapi.com/2/files/upload \
					--header "Authorization: Bearer ${DROPBOX_ACCESS_TOKEN}" \
					--header "Dropbox-API-Arg: {\"path\": \"/${DROPBOX_FOLDER}/latest/${CV_OUTPUT_FILE_NAME_LATEST}-${lang}.json\", \"mode\": \"overwrite\"}" \
					--header "Content-Type: application/octet-stream" \
					--data-binary @"${CV_FOLDER_PATH_LATEST}/${CV_OUTPUT_FILE_NAME}-${lang}.json"
			fi

			if [ -f "${CV_FOLDER_PATH_PDF}/${CV_OUTPUT_FILE_NAME}-${lang}.pdf" ]; then
				echo "${CV_OUTPUT_FILE_NAME}-${lang}-complement.pdf"
				curl -X POST https://content.dropboxapi.com/2/files/upload \
					--header "Authorization: Bearer ${DROPBOX_ACCESS_TOKEN}" \
					--header "Dropbox-API-Arg: {\"path\": \"/${DROPBOX_FOLDER}/${VERSION}/pdf/${CV_OUTPUT_FILE_NAME}-${lang}-complement.pdf\", \"mode\": \"overwrite\"}" \
					--header "Content-Type: application/octet-stream" \
					--data-binary @"${CV_FOLDER_PATH_PDF}/${CV_OUTPUT_FILE_NAME}-${lang}-complement.pdf"

				curl -X POST https://content.dropboxapi.com/2/files/upload \
					--header "Authorization: Bearer ${DROPBOX_ACCESS_TOKEN}" \
					--header "Dropbox-API-Arg: {\"path\": \"/${DROPBOX_FOLDER}/${VERSION}/html/${CV_OUTPUT_FILE_NAME}-${lang}-complement.html\", \"mode\": \"overwrite\"}" \
					--header "Content-Type: application/octet-stream" \
					--data-binary @"${CV_FOLDER_PATH_HTML}/${CV_OUTPUT_FILE_NAME}-${lang}-complement.html"

				curl -X POST https://content.dropboxapi.com/2/files/upload \
					--header "Authorization: Bearer ${DROPBOX_ACCESS_TOKEN}" \
					--header "Dropbox-API-Arg: {\"path\": \"/${DROPBOX_FOLDER}/${VERSION}/${CV_OUTPUT_FILE_NAME}-${lang}-complement.json\", \"mode\": \"overwrite\"}" \
					--header "Content-Type: application/octet-stream" \
					--data-binary @"${CV_FOLDER_PATH}/${CV_OUTPUT_FILE_NAME}-${lang}-complement.json"

				if [ "${CURRENT_BRANCH}" == "master" ]; then
					curl -X POST https://content.dropboxapi.com/2/files/upload \
						--header "Authorization: Bearer ${DROPBOX_ACCESS_TOKEN}" \
						--header "Dropbox-API-Arg: {\"path\": \"/${DROPBOX_FOLDER}/latest/pdf/${CV_OUTPUT_FILE_NAME_LATEST}-${lang}-complement.pdf\", \"mode\": \"overwrite\"}" \
						--header "Content-Type: application/octet-stream" \
						--data-binary @"${CV_FOLDER_PATH_LATEST}/pdf/${CV_OUTPUT_FILE_NAME_LATEST}-${lang}-complement.pdf"

					curl -X POST https://content.dropboxapi.com/2/files/upload \
						--header "Authorization: Bearer ${DROPBOX_ACCESS_TOKEN}" \
						--header "Dropbox-API-Arg: {\"path\": \"/${DROPBOX_FOLDER}/latest/html/${CV_OUTPUT_FILE_NAME_LATEST}-${lang}-complement.html\", \"mode\": \"overwrite\"}" \
						--header "Content-Type: application/octet-stream" \
						--data-binary @"${CV_FOLDER_PATH_LATEST}/html/${CV_OUTPUT_FILE_NAME_LATEST}-${lang}-complement.html"

					curl -X POST https://content.dropboxapi.com/2/files/upload \
						--header "Authorization: Bearer ${DROPBOX_ACCESS_TOKEN}" \
						--header "Dropbox-API-Arg: {\"path\": \"/${DROPBOX_FOLDER}/latest/${CV_OUTPUT_FILE_NAME_LATEST}-${lang}-complement.json\", \"mode\": \"overwrite\"}" \
						--header "Content-Type: application/octet-stream" \
						--data-binary @"${CV_FOLDER_PATH_LATEST}/${CV_OUTPUT_FILE_NAME_LATEST}-${lang}-complement.json"
				fi
			fi
		fi
	fi
done