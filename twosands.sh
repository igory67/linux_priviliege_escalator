#!/bin/bash

source global.sh
source gtfobins_variables.sh
{ source "$1" ; source "$2"; source "$3"; } | tee out

