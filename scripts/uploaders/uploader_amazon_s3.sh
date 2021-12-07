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

# Setting global variables.
source scripts/config.sh

function publish_to_aws {
	BUCKET_ADDRESS="s3://${1}/${AMAZON_S3_FOLDER}/${VERSION}"
	echo "Working in ${BUCKET_ADDRESS}"
	aws s3 cp --acl public-read "${CV_FOLDER_PATH}" "${BUCKET_ADDRESS}" --recursive

	if [ "${CURRENT_BRANCH}" == "master" ]; then
		aws s3 cp --acl public-read "${CV_FOLDER_NAME}/latest" "${BUCKET_ADDRESS}" --recursive
	fi
}

# Check if AMAZON_S3_BUCKET is array or not
if [[ "$(declare -p AMAZON_S3_BUCKET)" =~ "declare -a" ]]; then
    for BUCKET in "${AMAZON_S3_BUCKET[@]}"; do
		publish_to_aws "${BUCKET}"
	done
else
    publish_to_aws "${AMAZON_S3_BUCKET}"
fi
