#!/usr/bin/env bash

CV_NAME="Patricio_Perpetua"

VERSION=`cat VERSION`

CV_FOLDER_NAME=builds
CV_FOLDER_PATH=${CV_FOLDER_NAME}
CV_FOLDER_PATH_PDF=${CV_FOLDER_PATH}/pdf
CV_FOLDER_PATH_HTML=${CV_FOLDER_PATH}/html

CV_OUTPUT_FILE_NAME=${CV_NAME}-${VERSION}
CV_OUTPUT_FILE_NAME_LATEST=${CV_NAME}-latest

THEME_PDF=node_modules/jsonresume-theme-stackoverflow
THEME_HTML=node_modules/jsonresume-theme-kendall

declare -a AVAILABLE_THEMES=( 'business-card' 'elegant' 'paper' 'kendall' 'flat' 'classy' 'class' 'short' 'slick' 'onepage' 'spartan' 'stackoverflow');

FTP_DOMAIN=
FTP_USER=
FTP__PASS=
FTP_PORT=21

DROPBOX_ACCESS_TOKEN=
DROPBOX_FOLDER=