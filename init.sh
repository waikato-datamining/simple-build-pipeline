#!/bin/bash
#
# Downloads and sets up ADAMS for executing the build pipeline

root=`expr "$0" : '\(.*\)/'`

read -N 1 -p "Start download/setup of ADAMS application for executing the build pipeline, cancel with Ctrl+C..."

echo "Removing old download/installation..."
rm -f /tmp/adams.zip
rm -Rf /tmp/adams-basic-app-*
rm -Rf $root/adams

echo "Downloading ADAMS..."
wget -O /tmp/adams.zip https://adams.cms.waikato.ac.nz/snapshots/adams/adams-basic-app-snapshot-bin.zip

echo "Decompressing ADAMS..."
unzip -q /tmp/adams.zip -d /tmp

echo "Moving ADAMS application..."
mv /tmp/adams-basic-app-* $root/adams

echo "Cleaning up..."
rm -f /tmp/adams.zip
