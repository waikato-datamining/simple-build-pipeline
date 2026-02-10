#!/bin/bash

root=`expr "$0" : '\(.*\)/'`

if [ ! -d "$root/adams" ]
then
  echo "Missing 'adams' directory with ADAMS application! Run './init.sh' first!"
  exit 1
fi

$root/adams/bin/exec.sh -input $root/execute.flow -headless
