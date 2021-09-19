#!/bin/bash

readFile() {
    FILE_CONTENT=""
    while IFS= read -r line; do
    FILE_CONTENT="${FILE_CONTENT} ${line}"
    done < "${1}"
}


readFile "assets/packages"
FINAL_CONTENT="${FILE_CONTENT}"

apk add --no-cache "${FINAL_CONTENT}"