#!/bin/bash
# This file contains bash commands that will be executed at the beginning of the container build process,
# before any system packages or programming language specific package have been installed.
#
# Note: This file may be removed if you don't need to use it
export DEBIAN_FRONTEND=noninteractive

# add pip tsinghua source
sudo -E mkdir -p /root/.pip && \
    echo "[global]" >> /root/.pip/pip.conf && \
    echo "index-url = https://pypi.tuna.tsinghua.edu.cn/simple" >> /root/.pip/pip.conf

# Update the package index and install necessary packages
sudo -E apt-get update && apt-get install -y \
    software-properties-common \
    && apt-get clean && rm -rf /var/lib/apt/lists/*
# Add the Tsinghua University repository
sudo -E add-apt-repository "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ $(lsb_release -sc) main restricted universe multiverse"

# Add the Tsinghua University repository key
sudo -E apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9

sudo -E apt-get update
sudo -E apt-get install -y --no-install-recommends tzdata
sudo -E ln -fs /usr/share/zoneinfo/Etc/UTC /etc/localtime
sudo -E dpkg-reconfigure --frontend noninteractive tzdata
sudo -E apt-get install -y cmake zip unzip
sudo -E apt-get clean
sudo -E rm -rf /var/lib/apt/lists/*

sudo -E mkdir -p /mnt/docs
