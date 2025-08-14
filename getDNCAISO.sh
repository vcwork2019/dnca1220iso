#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

#use 7-zip to split source files, keep each file under 25Mb.
echo ""
echo "merging DNCA1220-ISO.iso from 7-zip files..."
echo "destination folder: /root/tmp/"
sudo mkdir /root/tmp && cd /root/tmp

if ! command -v 7z &> /dev/null; then
sudo dnf install -y epel-release
sudo dnf install -y p7zip p7zip-plugins
fi
7z x DNCA1220-ISO.7z.001
