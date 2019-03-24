#!/bin/bash

sudo yum install gcc gcc-c++ cpp openssl-devel libmpc-devel mpfr-devel gmp-devel zlib-devel* ncurses-devel tar make automake autoconf patch wget -y

sudo yum-config-manager --enable "Red Hat Enterprise Linux Server 7 Debug (Debug RPMs)"
yum -y install kernel-debuginfo kernel kernel-devel systemtap systemtap-sdt-devel
