#!/usr/bin/env bash

set -euxo pipefail

echo ">> Setting up environment for Bitnion build on CentOS i686..."

# Enable EPEL and SCL repos for updated devtools
yum install -y epel-release centos-release-scl

# Install dependencies
yum install -y \\
    gcc \\
    gcc-c++ \\
    make \\
    libtool \\
    curl \\
    git \\
    autoconf \\
    automake \\
    pkgconfig \\
    which \\
    libstdc++-devel \\
    bzip2

# Optional: Use devtoolset for modern GCC
yum install -y devtoolset-8
source /opt/rh/devtoolset-8/enable

# Set environment variables
export CC=gcc
export CXX=g++
export CONFIG_SITE=$PWD/depends/i686-pc-linux-gnu/share/config.site

# Confirm environment
gcc --version
uname -a

echo ">> Environment setup for Bitnion on CentOS i686 completed."
