#!/bin/bash

if [[ ! -f crt.pem || ! -f key.pem ]]; then
    echo "Please put the key.pem and crt.pem files to use when signing in this directory."
    exit;
fi

if [[ ! `which nabit` ]]; then
    echo "Please install nabit: https://github.com/harvard-lil/bag-nabit/";
    exit;
fi

description="This Bagit package contains data that was downloaded from the NIH Reporter Exporter service https://reporter.nih.gov/exporter/ using the software at https://github.com/edsu/nih-reporter-exporter. A copy of the FAQ and data dictionary were printed as PDFs and added to the data directory."

nabit archive bag \
    --path data \
    --info "contact-name:Ed Summers" \
    --info "contact-email:ehs@pobox.com" \
    --info "external-description:${description}" \
    --info "source-organization:" \
    --sign crt.pem:key.pem \
    --timestamp digicert
