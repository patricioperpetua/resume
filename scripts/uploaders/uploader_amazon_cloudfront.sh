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
source "${__root}/config.sh"

function invalite_cloudfront_cache {
	DISTRIBUTION_ID="${1}"
	echo "Invalidating distribution with ID ${DISTRIBUTION_ID}"

    DISTRIBUTION_PATHS="${CURRENT_BRANCH}"

	if [ "${CURRENT_BRANCH}" == "master" ]; then
		DISTRIBUTION_PATHS="latest"
	fi

    aws cloudfront create-invalidation --no-cli-pager \
        --distribution-id "${1}" \
        --paths "/${AMAZON_S3_FOLDER}/${DISTRIBUTION_PATHS}/*"
}

# Check if AMAZON_CLOUDFRONT_DISTRIBUTIONS_ID is array or not
if [[ "$(declare -p AMAZON_CLOUDFRONT_DISTRIBUTIONS_ID)" =~ "declare -a" ]]; then
    for DISTRIBUTION_ID in "${AMAZON_CLOUDFRONT_DISTRIBUTIONS_ID[@]}"; do
		invalite_cloudfront_cache "${DISTRIBUTION_ID}"
	done
else
    invalite_cloudfront_cache "${AMAZON_CLOUDFRONT_DISTRIBUTIONS_ID}"
fi