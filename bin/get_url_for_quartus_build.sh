#!/usr/bin/env bash

if [ $# -lt 3 ]; then
	echo "$(basename $0) <edition> <version> <build>" >&2
	exit 1
fi

EDITION="$1"
VERSION="$2"
BUILD="$3"

case ${EDITION} in
	web)
		FILENAME_PREFIX="Quartus-web"
		FILENAME_SUFFIX=""
		;;
	subscription)
		FILENAME_PREFIX="Quartus"
		FILENAME_SUFFIX=""
		;;
	lite)
		FILENAME_PREFIX="Quartus-lite"
		FILENAME_SUFFIX=""
		;;
	standard)
		FILENAME_PREFIX="Quartus"
		FILENAME_SUFFIX="-complete"
		;;
	pro)
		FILENAME_PREFIX="Quartus-pro"
		FILENAME_SUFFIX="-complete"
		;;
esac

for PLATFORM in linux windows; do

curl -X POST 'https://fpgasoftware.intel.com/api/get_direct_build_file_url/' \
	-H 'User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:87.0) Gecko/20100101 Firefox/87.0' \
	-H 'Accept: */*' \
	-H 'Accept-Language: en-US,en;q=0.5' \
	--compressed \
	-H 'Content-Type: application/x-www-form-urlencoded; charset=UTF-8' \
	-H 'X-CSRFToken: Hvgv5aGczdZc2Z7ccz4BD77hL71oeQcc' \
	-H 'X-Requested-With: XMLHttpRequest' \
	-H 'Origin: https://fpgasoftware.intel.com' \
	-H 'Connection: keep-alive' \
	-H 'Referer: https://fpgasoftware.intel.com/15.0/?edition=subscription' \
	-H 'Cookie: detected_bandwidth=HIGH; src_countrycode=US; SecureSESSION=i/KKFFOXkpJACfildLElfeFqQlCPo2RsLzxusaoz8wKC5tzrAWTlWGozJIbB25qWfBYhHU9vPA0MYlxlG5EtmEkbIzETquArXDNHEydHUih2hGh3hNr5S6/EoRzlGmCdQjwzqM3sBVNdZkpIy6f24jEH1VlG9rgz3aDiJPP54FDtVA+cZCn4/DZTJhtGEkYxLVGS8SFy5Lc9vTVsjs7lqSYwKUtdkSu6miNC+PlmAI3iqxkEs9cobPCsj/P29OqF0KDFOAQFSNFT2WUP+WTj7oFw9dbKUcjAOSZ1QOk5YW2NMdQknv6I1fjc7nOZfWNgJLrC1zAkWiw+NwTPld5HPEfh6toBjjARKB/0l1qa8IlDFUxii2ricGNdgeAl9+0bUD7lpXmi5IaxXqooVvl4U0aFEscmM07cFXh7uXrIEnw4wze6G4MrLA5Z8BY2jpMPqUCmcFgGzroC7dgyAEMZZMYdwckzHUULiLzz2ilt2XvUmzw3jLWiWElkQXenn/+WWF7gAr8O48bbLpiNPuaVS1zhN3fMGVAYC8QGu6WhvPFs5GnwnoKU1N8kJl53oaLeA+vrLvIjRnLPviIQW+N0LXy+l9gXreSLLMBHTiXL/On3Uh40ePBxJR7THHs2beXHLCoJhk3ZtL5OMSt8nXywfJxZF5eq5EB9YLZsHHdWLLoFrf+x9Mqq7uPpT2Fz0oHwYfY0jadcRv9mwKcydotxJCBl0mKtrKXzGOqCIaFcAvplJnavJOJYE+Q48Lf+asbCzPdaDkEcAIEjozR5eJ+5tLs31t19l/PcpSC0HbnH9rXHMxLAUcZqM3bYQrPg+CuRXIspU6uPfxRcDukP6jukYEg3nYnKoYGI+bVhUcGQoJ4LimnDLex2iz2RzH4MJGPyqTYE0Q1dILwrG4EiLENY1mhwUx3BzdrumrxEqsOnLVBbu2OFwHXqgBDwEabvQMyqjox2rMFiTIpRkogLQMHT9hK8kc+00dfPristPITWgChMz5icRkzzf6DI+qYESSxqWDkYjHPcFQ2ZIC9joQAFEfB6nRlcpO2KVyfAeWEtd0Kl0XH96jiZZcs3w3GQ8qD75W9I4jWpM7G23hIsmAAh5eFctfJwGC6QnLTpjFerA4zUKwRGjxFRMMnhm3PFQ8Vp3dFBQ8yUx6/T7w5ehK+VMhmwk25s0lrIlwik57wBFQ19TVEtTs2oxAHAdOzuF4HdI66EjTcVAub3m4tMcXK5n+/qjIasPnkv; SMSESSION=A92JRWGlFh8H2HKiLn4HffpvS33OH28IJEQ4ucsC3iigC9s8JINqYAPP4ViAKqhcnv541MoFn4dxbFGcBLnk7AGhIcFqAsyRnoaDG67viTsd+3WFqUSDhBBdJuX5+ICGKthsNftEGSyq/RoBwQTqb2lAso25uHvhCEq2VCmRXMm5FNVZwuOa5hHwwhtW4wf7taabDO+tSUDhseg0HOfpZodhmxkIwRiaklgkjyh3LEHmaDk4GFOi2ELWp/HVLOM8HfXUQ7qM8MuiN82XzJHZz3rGQK4psUXwrleExZf4axefaupKBcKwhf6Udjv06gxyT/1YX9UVeouZVf5kxnWsTzS4qaOwiHO7wvXl57g/nt/m/V3G3jlKrrUZBuTm+B74fH9Kbk77f1S7U0iv97T0n6F7HZNzjIR0h8J/8V88CXp1Gmi+YE3x5IwtDZrsBhSdW2h6FXUfAkJcRS5/oEv8MPO/MuaRQ80czKbsIa0ujJOR8k/5sAZPYqu77y0yJ0UL3LtRgNF/qR3/vjJ3yo0OMx6mWFfrbZPr9yNekcgvGy08N+xd3cUfx18pElNs8gGdPvnHDJS9RI4QA1lpd1c1xwgwpVW7WA2CxVS124wwG7pIYXg+5BPwze0Avohn2t8RxyOqCdUiPJd/JDXaXEfPcSLaje2xoM6dBz5Mm2F2ZH/fXoPmVI78PfHlGbS3ManeLNYukCtPq1HLtd0rE2KAQ4YQir91kQlFOPvpWIcKyQyNxz/D4SHZqpe8sXuXgk+k8ShVnATGQMzZ5AhphXmsXrPdq3iQXD4EjvZbqES6HBP84QDjbCswcoxQxQP9frXRw5qBV0vFgc2CwK+wyD1PiGoHESeE1iJRYHvU/zVKqCFTIigRnrWvJNRFNR/6UtMFgvq8xEncF7mrboSpHSqECFdRSvxTAIGrmS2FUHXi+qiXSqOg25zgWFpUI/If16wr+NcRvJp3G0Wsy680OgLQEsPRGsaYJ2NbS8OMAQsN7qsos8B71SzKu+79KLTaW5CoVqZ4NevgDOhZSiKMnozTAYhJdcFzUdHYtzKOOQAyFAYEY1qrFaOCE31BYKjtpbslqOSVvquY4SnEQRTiX9vHoKgKJuLVzDApdE+xJBNJLV3x1uztVAIJgrKylSof9gJam1jVOQYSorFh8i9yeXSx2dOkWdJ3VvOH; TS0138fa28=01eb8d28b3a674f788a971211d0bbb06221ddaa58cd30a76af3823087b196043ebd344afa75d32c79d632ae22d7c26ca278021a9b283ef5466b00f4c452a2f0fdb492fd3aa; IGHFLoggedIn=true; eRPMID=; targetloaded=1; csrftoken=Hvgv5aGczdZc2Z7ccz4BD77hL71oeQcc; sessionid=hini1j1ue0fmgpawe3crf7237hjvk8tg; samlTargetResource=/content/www/us/en/programmable/downloads/software/archives/arc-index.html; intelresearchREF=https%3A//fpgasoftware.intel.com/; tms_timeout=true' \
	--data-raw "csrfmiddlewaretoken={{csrf_token}}&platform=${PLATFORM}&version_number=${VERSION}&edition=${EDITION}&direct_file=${FILENAME_PREFIX}-${BUILD}-${PLATFORM}${FILENAME_SUFFIX}.tar" | jq -r .data | sed -e 's/\(.*\)/url = "\1"/'

done
