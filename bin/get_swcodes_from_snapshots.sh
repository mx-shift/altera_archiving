#!/usr/bin/env bash

find snapshots -type f | while read SNAPSHOT; do
	grep WWW-SWD ${SNAPSHOT} \
	       	| sed -E -e 's/.*(WWW-SWD-[A-Z0-9-]+).*/\1/'
done
