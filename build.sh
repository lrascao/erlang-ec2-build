#!/bin/bash
echo "Installing git"
sudo yum install git -y

echo -e "\nInstalling development environment"
./setup.sh

echo -e "\nInstalling your choice of GCC: $GCC"
pushd gcc > /dev/null
./build.sh $GCC
export PATH=~/`pwd`/releases/latest/bin:$PATH
popd > /dev/null

echo -e "\nInstalling your choice of OpenSSL: $OPENSSL"
pushd openssl > /dev/null
./build.sh $OPENSSL
popd > /dev/null

echo -e "\nBuilding your choice of OTP/Erlang: $OTP"
pushd erlang > /dev/null
./build.sh $OTP
popd > /dev/null
