#!/usr/bin/env bash

CV_NAME="Patricio_Perpetua"

VERSION=`cat VERSION`

if [ -z ${CURRENT_BRANCH+x} ]; then
    CURRENT_BRANCH="$(git branch | grep \* | cut -d ' ' -f2)"
fi
echo "Current branch: ${CURRENT_BRANCH}"
if [ "${CURRENT_BRANCH}" == "master" ]; then
	echo "Uploading latest content."
else
    echo "Building for a branch content."
    VERSION="${CURRENT_BRANCH}"
fi

CV_FOLDER_NAME=builds
CV_FOLDER_PATH=${CV_FOLDER_NAME}/${VERSION}
CV_FOLDER_PATH_PDF=${CV_FOLDER_PATH}/pdf
CV_FOLDER_PATH_HTML=${CV_FOLDER_PATH}/html

CV_OUTPUT_FILE_NAME=${CV_NAME}-${VERSION}
CV_OUTPUT_FILE_NAME_LATEST=${CV_NAME}-latest

THEME_PDF=node_modules/jsonresume-theme-stackoverflow
THEME_HTML=node_modules/jsonresume-theme-kendall

declare -a AVAILABLE_THEMES=( 'business-card' 'elegant' 'paper' 'kendall' 'flat' 'classy' 'class' 'short' 'slick' 'onepage' 'spartan' 'stackoverflow');
declare -a AVAILABLE_THEMES_FRESH=( 'positive' 'modern' 'compact' 'basis' 'awesome' )

FTP_DOMAIN=
FTP_USER=
FTP_PASS=
FTP_PORT=21

if [ -z ${DROPBOX_ACCESS_TOKEN+x} ]; then
    DROPBOX_ACCESS_TOKEN=
else
    echo "dropbox access token provided."
fi
DROPBOX_FOLDER=resume

AMAZON_S3_BUCKET=("patricioperpetua.com" "patricioperpetua.com.au")
AMAZON_S3_FOLDER="assets/resume"