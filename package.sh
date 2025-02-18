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

description="This Bagit package contains data that was downloaded from the NIH Reporter Exporter service https://reporter.nih.gov/exporter/ using the software at https://github.com/edsu/nih-reporter-exporter. A copy of the FAQ and data dictionary were printed as PDFs and added to the data directory."

nabit archive nih-reporter-exporter \
    --path data \
    --info "Contact-Name:Ed Summers" \
    --info "Contact-Email:ehs@pobox.com" \
    --info "External-Description:${description}" \
    --sign $SSL_CERT_FILE:$SSL_KEY_FILE \
    --timestamp digicert

echo "creating nih-reporter-exporter.zip"
zip -qr nih-reporter-exporter.zip nih-reporter-exporter
rm -rf nih-reporter-exporter
