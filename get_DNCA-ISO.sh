#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

#check download url if source file has been changed
echo ""
echo "downloading DNCA1220-ISO.iso from GoogleDrive..."
echo "destination folder: /root/tmp"
sudo mkdir /root/tmp
wget https://drive.usercontent.google.com/download?id=1o_pIKYUK_wnHNc5570wrVCYqYAdydhxS&export=download&authuser=0&confirm=t&uuid=254ca051-355a-4994-9808-69bc8f55b01c&at=AN8xHor5fGdpJzWY0XnR2CSbL4ls:1755176374344
