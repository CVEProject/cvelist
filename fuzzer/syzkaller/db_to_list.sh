#!/bin/bash

sqlite3 -json mirror.sl3 ".read db_to_list.sql" | jq -c '. | map(. | to_entries | map({"key": .key, "value": (.value//""|split(","))}) | from_entries) | .[]'