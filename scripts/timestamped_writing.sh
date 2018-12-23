#!/bin/bash

FILENAME=$1

date > ${FILENAME}
echo >> ${FILENAME}
echo >> ${FILENAME}

${EDITOR} ${FILENAME}

echo >> ${FILENAME}
date >> ${FILENAME}
