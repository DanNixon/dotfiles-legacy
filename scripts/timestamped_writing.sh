#!/bin/bash

label=$1
filename_timestamp=`date "+%s"`

if [ -n "${label}" ];
then
  filename="${filename_timestamp}_${label}.txt"
else
  filename="${filename_timestamp}.txt"
fi

touch ${filename}

date >> ${filename}
echo >> ${filename}
echo >> ${filename}

${EDITOR} ${filename}

echo >> ${filename}
date >> ${filename}
