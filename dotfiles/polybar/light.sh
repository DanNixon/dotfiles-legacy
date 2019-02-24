#!/bin/bash

VAL=`light | cut --delimiter="." --fields="1"`
echo " ${VAL}%"
