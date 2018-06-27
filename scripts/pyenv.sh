#!/bin/sh

virtualenv --python $3 $2
echo "#%Module1.0\n\nprepend-path PATH $2/bin\n" > ~/.modules/$1
