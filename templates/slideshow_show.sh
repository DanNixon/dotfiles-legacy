#!/bin/sh

NAME=name_of_presentation_markdown_file

TMP_DIR=/tmp/presentation/

slideshow build ${NAME}.md -t reveal.js -o ${TMP_DIR}
cp * ${TMP_DIR}
firefox ${TMP_DIR}${NAME}.html
