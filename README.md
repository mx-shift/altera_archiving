# Scripts for archiving legacy Altera software

In 2020, Intel published Customer Advisories
[ADV2011](https://www.intel.com/content/dam/www/programmable/us/en/pdfs/literature/pcn/adv2011.pdf)
and
[ADV2030](https://www.intel.com/content/dam/www/programmable/us/en/pdfs/literature/pcn/adv2030.pdf)
which formally discontinued MAX+PLUS II entirely and Quartus II versions
released prior to 2014. Downloads of these software were removed from Intel's
FPGA download center.  By researching the various download infrastructures used
by Altera over time, some versions were discovered to still be available if you
knew where to look.  This repository provides scripts and cached versions of
metadata used to discover these versions and enable bulk download of them.

## Altera's legacy download infrastructure

Prior to 2003, Altera mostly just placed downloads on their FTP server,
ftp.altera.com, which is no longer online.  Interestingly, the directory
structure of the FTP server appears to be replicated on
https://fpgadownload.intel.com despite disallowing directory listings.

In 2003, Altera switched to a scheme where downloads were vended via a web
service. Individual downloads are identified by a query parameter named
`swcode`. These appear to be of the form `WWW-SWD-<product code>-<download id>`.
A partial list of swcodes, swcodes/scrape.txt, was assembled by scraping
snapshots of various download pages via Wayback Machine. Additional swcodes for
Quartus II downloads were discovered by guessing based on known supported
platforms, released versions, and released service packs.

For Quartus II v13.0 (circa 2013), Altera changed to a different scheme that
looks up a download URL by individual query parameters for platform, version
number, edition, and filename. Version numbers changed to a `<major>.<minor>.<service_pack>.<build>` format.

## Scripts

### get_snapshots_for_url.sh

Uses [memgator](https://github.com/oduwsdl/MemGator) to download historical
snapshots of a URL from various archive sources.  Snapshots are saved to a
`snapshots` folder.

### get_swcodes_from_snapshots.sh

Scrapes swcodes from all the snapshots stored in the `snapshots` folder and
dumps them to stdout.

### get_metadata_for_swcodes.sh

Fetches metadata about swcodes from
https://www.intel.com/content/www/us/en/programmable/bin/get-download?action=getDetails.
Metadata is stored in JSON format as a file per swcode in the `metadata` folder.

### get_download_urls_from_metadata.py

Extracts the canonical download URL from a metadata file and tries permutations
of the filename and various base URLs known to hold downloads to find a working
URL.  Working URLs are written to stdout.

### get_url_for_quartus_build.sh

Looks up download URLs for Quartus II v13 and later.