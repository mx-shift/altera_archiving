#!/usr/bin/env bash

URL="$1"
URL_SLUG="$(echo "${URL}" | tr "/:" "-")"
SNAPSHOTS_DIR="snapshots/${URL_SLUG}"

mkdir -p ${SNAPSHOTS_DIR}

~/Downloads/memgator-linux-amd64 -f json ${URL} \
	| jq -r .mementos.list[].uri \
	| while read SNAPSHOT_URL; do
		SNAPSHOT_SLUG="$(echo "${SNAPSHOT_URL}" | tr "/:" "-")"
		curl ${SNAPSHOT_URL} > "${SNAPSHOTS_DIR}/${SNAPSHOT_SLUG}"
	  done
