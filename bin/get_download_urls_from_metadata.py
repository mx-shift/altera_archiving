#!/usr/bin/env python3

import copy
import json
import pathlib
import sys
import urllib.parse
import urllib.request

BASE_URLS = [
        "https://fpgadownload.intel.com/outgoing/release/",
        "https://fpgadownload.intel.com/outgoing/download/",
        "https://www.intel.com/content/dam/altera-www/global/en_US/scripts/patches/",
        "https://www.intel.com/content/dam/altera-www/global/en_US/others/patches/",
]

for path in sys.argv[1:]:
    with open(path) as fp:
        metadata = json.load(fp)

        swcode = metadata["swcode"]
        swurl = urllib.parse.urljoin("https://www.intel.com", metadata["swUrl"].strip())

        swpath = pathlib.PurePosixPath(urllib.parse.unquote(urllib.parse.urlparse(swurl).path))
        swfile = swpath.name

        test_urls = [swurl]
        test_urls += list({urllib.parse.urljoin(base_url, test_file) for test_file in set([swfile, swfile.lower()]) for base_url in BASE_URLS} - set(test_urls))

        for test_url in test_urls:

            req = urllib.request.Request(test_url, method="HEAD")
            try:
                with urllib.request.urlopen(req) as rsp:
                    pass

                rsp_path = pathlib.PurePosixPath(urllib.parse.unquote(urllib.parse.urlparse(rsp.url).path))
                rsp_file = rsp_path.name

                if rsp_file in [swfile, swfile.lower()]:
                    print("SUCCESS ({}): {}".format(rsp.status, rsp.url), file=sys.stderr)
                    print(test_url)
                    break
                else:
                    print("FAIL: {}".format(test_url), file=sys.stderr)
            except urllib.error.HTTPError as e:
                print("FAIL: {}".format(test_url), file=sys.stderr)
                pass
