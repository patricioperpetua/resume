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

echo "loading configuration from file scripts/config.sh"
#Setting global variables.
source scripts/config.sh

#Deleting builds folder if exists.
if [ -d ${CV_FOLDER_PATH} ]; then
	echo "removing previous builds..."
	for entry in "${CV_FOLDER_PATH}"/*
	do
		if [ -f ${entry} ]; then
			if [ "${entry}" != "${CV_FOLDER_PATH}/*" ]; then
				rm -r ${entry}
			fi
		fi
	done
else
	echo "creating new build folder..."
	#Creating builds folder.
	mkdir -p ${CV_FOLDER_PATH}
fi

#Deleting builds folder if exists.
if [ -d ${CV_FOLDER_PATH_PDF} ]; then
	echo "removing previous builds..."
	for entry in "${CV_FOLDER_PATH_PDF}"/*
	do
		if [ -f ${entry} ]; then
			if [ "${entry}" != "${CV_FOLDER_PATH_PDF}/*" ]; then
				rm -r ${entry}
			fi
		fi
	done
else
	echo "creating new build folder..."
	#Creating builds folder.
	mkdir -p ${CV_FOLDER_PATH_PDF}
fi

#Deleting builds folder if exists.
if [ -d ${CV_FOLDER_PATH_HTML} ]; then
	echo "removing previous builds..."
	for entry in "${CV_FOLDER_PATH_HTML}"/*
	do
		if [ -f ${entry} ]; then
			if [ "${entry}" != "${CV_FOLDER_PATH_HTML}/*" ]; then
				rm -r ${entry}
			fi
		fi
	done
else
	echo "creating new build folder..."
	#Creating builds folder.
	mkdir -p ${CV_FOLDER_PATH_HTML}
fi

for entry in "src"/*
do
	if [ -d ${entry} ]; then
		lang="${entry:4}"
		echo "found language ${lang}"
		if [ -f src/${lang}/${lang}-jrs.json ]; then
			# merge jsons to use to jsonresume
			hackmyresume build src/basics.json src/${lang}/${lang}-jrs.json \
				TO ${CV_FOLDER_PATH}/${CV_OUTPUT_FILE_NAME}-${lang}.json

			hackmyresume build src/basics.json src/${lang}/${lang}-jrs.json \
				src/${lang}/${lang}-complement-jrs.json \
				TO ${CV_FOLDER_PATH}/${CV_OUTPUT_FILE_NAME}-${lang}-complement.json

			hackmyresume build src/basics.json src/${lang}/${lang}-jrs.json \
				TO ${CV_FOLDER_PATH_PDF}/${CV_OUTPUT_FILE_NAME}-${lang}.pdf \
				-o src/${lang}/${lang}-option.json \
				-t ${THEME_PDF}

			rm ${CV_FOLDER_PATH_PDF}/${CV_OUTPUT_FILE_NAME}-${lang}.pdf.html

			hackmyresume build src/basics.json src/${lang}/${lang}-jrs.json \
				TO ${CV_FOLDER_PATH_HTML}/${CV_OUTPUT_FILE_NAME}-${lang}.html \
				-o src/${lang}/${lang}-option.json \
				-t ${THEME_HTML}

			cp assets/profile.jpg builds/html/profile.jpg

			if [ -f src/${lang}/${lang}-complement-jrs.json ]; then
				hackmyresume build src/basics.json src/${lang}/${lang}-jrs.json \
					src/${lang}/${lang}-complement-jrs.json \
					TO ${CV_FOLDER_PATH_HTML}/${CV_OUTPUT_FILE_NAME}-${lang}-complement.html \
					-o src/${lang}/${lang}-option.json \
					-t ${THEME_HTML}

				hackmyresume build src/basics.json src/${lang}/${lang}-jrs.json \
					src/${lang}/${lang}-complement-jrs.json \
					TO ${CV_FOLDER_PATH_PDF}/${CV_OUTPUT_FILE_NAME}-${lang}-complement.pdf \
					-o src/${lang}/${lang}-option.json \
					-t ${THEME_PDF}

				rm ${CV_FOLDER_PATH_PDF}/${CV_OUTPUT_FILE_NAME}-${lang}-complement.pdf.html

				cp ${CV_FOLDER_PATH_HTML}/${CV_OUTPUT_FILE_NAME}-${lang}-complement.html ${CV_FOLDER_PATH_HTML}/index.html
				cp ${CV_FOLDER_PATH_PDF}/${CV_OUTPUT_FILE_NAME}-${lang}-complement.pdf ${CV_FOLDER_PATH_PDF}/index.pdf
			else
				cp ${CV_FOLDER_PATH_HTML}/${CV_OUTPUT_FILE_NAME}-${lang}.html ${CV_FOLDER_PATH_HTML}/index.html
				cp ${CV_FOLDER_PATH_PDF}/${CV_OUTPUT_FILE_NAME}-${lang}.pdf ${CV_FOLDER_PATH_PDF}/index.pdf
			fi
		fi
	fi
done
