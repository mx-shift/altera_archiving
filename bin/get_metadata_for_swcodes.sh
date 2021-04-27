#!/usr/bin/env bash

for SWCODE in "$@"; do
	PRODUCT_ID="$(echo ${SWCODE} | cut -d'-' -f3)"

	case ${PRODUCT_ID} in
		SE | WE)
			PRODUCT_ID="QII"
			;;
		MDSW | MDSWE)
			PRODUCT_ID="MDS"
			;;
	esac

	METADATA_DIR="metadata/${PRODUCT_ID}"
	METADATA_FILE="${METADATA_DIR}/${SWCODE}.json"

	mkdir -p ${METADATA_DIR}

	curl -f --compressed \
	    -H 'User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:87.0) Gecko/20100101 Firefox/87.0' \
	    -H 'Accept: application/json, text/javascript, */*; q=0.01' \
	    -H 'Accept-Language: en-US,en;q=0.5' \
	    -H 'X-Requested-With: XMLHttpRequest' \
	    -H 'Connection: keep-alive' \
	    -H 'Referer: https://www.intel.com/content/www/us/en/programmable/downloads/thank-you.html?swcode=WWW-SWD-MP2-101-PC-ADSY' \
	    -H 'Cache-Control: max-age=0' \
	    -H 'TE: Trailers' \
	    "https://www.intel.com/content/www/us/en/programmable/bin/get-download?action=getDetails&swcode=${SWCODE}" \
	    | jq | tee ${METADATA_FILE}

	if [[ -z "$(cat ${METADATA_FILE} | jq -r .swcode)" ]] ; then
		rm ${METADATA_FILE}
	fi
done
