#!/bin/bash

if ! [ -x "$(command -v jq)" ]; then
    echo >&2 "Missing required dependency: jq"
    exit 1
fi

if [[ $# != 1 ]]; then
    echo >&2 "Usage: $0 <filepath>"
    exit 1
fi

FILE="$1"

REQUIRED_VALUES=(
    ".CVE_data_meta.ASSIGNER=security@kubernetes.io"
    ".CVE_data_meta.STATE=PUBLIC"
    ".affects.vendor.vendor_data[0].vendor_name=Kubernetes"
)

for REQ in "${REQUIRED_VALUES[@]}"; do
    FIELD="${REQ%%=*}"
    EXPECTED="${REQ#*=}"
    ACTUAL="$(jq -r "$FIELD" "$FILE")"
    if [[ "$ACTUAL" != "$EXPECTED" ]]; then
        echo "ERROR: required $FIELD to be '$EXPECTED'; found '$ACTUAL'"
    fi
done

REQUIRED_FIELDS=(
    ".CVE_data_meta.TITLE"
    ".affects.vendor.vendor_data[0].product.product_data[0].product_name"
    ".affects.vendor.vendor_data[0].product.product_data[0].version.version_data[0].version_value"
    ".description.description_data[0].value"
    ".references.reference_data[] | select(.refsource==\"MLIST\")"   # Mailing list
    ".references.reference_data[] | select(.refsource==\"CONFIRM\")" # Tracking issue
    ".source.defect[0]"
)

for FIELD in "${REQUIRED_FIELDS[@]}"; do
    ACTUAL="$(jq "$FIELD" "$FILE")"
    if [[ "$ACTUAL" == "null" ]] || [[ "$ACTUAL" == '""' ]] || [[ "$ACTUAL" == "false" ]]; then
        echo "ERROR: required $FIELD"
    fi
done

EXPECTED_VALUES=(
    ".affects.vendor.vendor_data[0].product.product_data[0].product_name=Kubernetes"
)

for REQ in "${EXPECTED_VALUES[@]}"; do
    FIELD="${REQ%%=*}"
    EXPECTED="${REQ#*=}"
    ACTUAL="$(jq -r "$FIELD" "$FILE")"
    if [[ "$ACTUAL" != "$EXPECTED" ]]; then
        echo "WARNING: expected $FIELD to be '$EXPECTED'; found '$ACTUAL'"
    fi
done

EXPECTED_FIELDS=(
    ".CVE_data_meta.DATE_PUBLIC"
    ".credit[0].value"
    ".impact.cvss"
    ".problemtype.problemtype_data[0].description[0].value"
    ".source.discovery!=\"UNKNOWN\""
)

for FIELD in "${EXPECTED_FIELDS[@]}"; do
    ACTUAL="$(jq -e "$FIELD" "$FILE")"
    if [[ "$ACTUAL" == "null" ]] || [[ "$ACTUAL" == '""' ]] || [[ "$ACTUAL" == "false" ]]; then
        echo "WARNING: expected $FIELD"
    fi
done
