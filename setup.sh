#!/bin/bash

sudo yum install gcc gcc-c++ cpp openssl-devel libmpc-devel mpfr-devel gmp-devel zlib-devel* ncurses-devel tar make automake autoconf patch wget -y

sudo yum -y install systemtap systemtap-sdt-devel
sudo yum -y install kernel-debuginfo-$(uname -r) kernel-$(uname -r) kernel-devel-$(uname -r)

