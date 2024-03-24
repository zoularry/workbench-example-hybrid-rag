#!/bin/bash
# This file contains bash commands that will be executed at the beginning of the container build process,
# before any system packages or programming language specific package have been installed.
#
# Note: This file may be removed if you don't need to use it
export DEBIAN_FRONTEND=noninteractive

# add pip tsinghua source
sudo -E mkdir -p /root/.pip
sudo -E echo "[global]" >> /root/.pip/pip.conf
sudo -E echo "index-url = https://pypi.tuna.tsinghua.edu.cn/simple" >> /root/.pip/pip.conf

# Update the package index and install necessary packages
sudo -E sed -i 's/archive.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list

sudo -E apt-get update
sudo -E apt-get install -y --no-install-recommends tzdata
sudo -E ln -fs /usr/share/zoneinfo/Etc/UTC /etc/localtime
sudo -E dpkg-reconfigure --frontend noninteractive tzdata
sudo -E apt-get install -y cmake zip unzip
sudo -E apt-get clean
sudo -E rm -rf /var/lib/apt/lists/*

sudo -E mkdir -p /mnt/docs
