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

#Changing to builds folder.
cd "${CV_FOLDER_PATH}"

lftp<<END_SCRIPT
set ftps:initial-prot "";
set ftp:ssl-force true;
set ftp:ssl-protect-data true;
set ssl:verify-certificate no;
open -u ${FTP_USER},${FTP_PASS} ${FTP_NAME}
mkdir files
cd files
mirror --reverse --only-newer ../builds/${VERSION}
mirror --reverse --only-newer ../builds/LATEST
bye
END_SCRIPT
exit 0