#!/bin/bash
set -ex
set -o pipefail

function process_osv() {
    ./db_to_list.sh > list.json
    python3 ./list_to_unique.py list.json > unique.json
    python3 ./unique_to_delta.py unique.json > delta.json
    python3 ./delta_to_summary.py delta.json > summary.json
    python3 ./summary_to_processed.py $1 summary.json > $2
    python3 ./processed_to_osv.py $2
}

wget -q -N https://linux-mirror-db.storage.googleapis.com/mirror.sl3
wget -q -N https://linux-mirror-db.storage.googleapis.com/syzkaller.tar.gz
tar xzf syzkaller.tar.gz syzkaller

process_osv $1 $2 | jq -c .[]