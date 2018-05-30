#!/usr/bin/env bash
# convert_pdf_to_svg.sh
# take a bunch of PDF files and convert to svg files
#
# brew install pdf2svg

for pdf in "$@"; do
  command="pdf2svg $pdf $pdf.svg"
  echo "$command ..."
  `$command`
done

