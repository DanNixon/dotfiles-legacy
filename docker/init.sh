#!/bin/bash

usermod --uid ${PUID} dan
groupmod --gid ${PGID} dan

su dan
