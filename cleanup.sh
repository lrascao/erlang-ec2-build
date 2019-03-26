#!/bin/bash

sudo yum remove gcc gcc-c++ cpp openssl-devel libmpc-devel mpfr-devel gmp-devel zlib-devel* ncurses-devel tar make automake autoconf patch wget -y

sudo yum-config-manager --enable "Red Hat Enterprise Linux Server 7 Debug (Debug RPMs)"
yum remove kernel-debuginfo kernel kernel-devel systemtap systemtap-sdt-devel -y

yum autoremove -y
