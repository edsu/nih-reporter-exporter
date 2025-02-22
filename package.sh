#!/bin/bash

set -e

SSL_KEY_FILE=$HOME/certs/key.pem
SSL_CERT_FILE=$HOME/certs/crt.pem

if [[ ! -f $SSL_KEY_FILE || ! -f $SSL_CERT_FILE ]]; then
    echo "Please set SSL_KEY_FILE and SSL_CERT_FILE to use for signing."
    exit;
fi

if [[ ! `which nabit` ]]; then
    echo "Please install nabit: https://github.com/harvard-lil/bag-nabit/";
    exit;
fi

if [[ ! `which bagit.py` ]]; then
    echo "Please install bagit.py: https://github.com/LibraryOfCongress/bagit-python";
    exit;
fi

description="This Bagit package contains data that was downloaded from the NIH Reporter Exporter service https://reporter.nih.gov/exporter/ using the software at https://github.com/edsu/nih-reporter-exporter. You can use the Bagit manifests to verify the integrity of the package. In addition to the NIH Reporter Exporter data, a copy of the FAQ and data dictionary were printed as PDFs and added to the data directory. The data/headers.har file is a HTTP Archive file that contains the HTTP request and response headers that were generated as part of the download. The digital signatures in the signatures directory can be used to verify that the package has not been altered since it was signed by Stanford University Libraries."

# use bagit.py to create a standard bag using SHA-256 fixity values
bagit.py \
    --sha256 \
    --source-organization "Stanford University" \
    --contact-name "Ed Summers" \
    --contact-email "edsu@stanford.edu" \
    --external-description "${description}" \
    --external-identifier "PURL URL here" \
    nih-reporter-exporter;

# use nabit to generate the digital signatures
nabit sign nih-reporter-exporter \
    --sign $SSL_CERT_FILE:$SSL_KEY_FILE \
    --timestamp digicert
