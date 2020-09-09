#!/bin/bash
VERSION=$1
TARBALL=openssl-$1.tar.gz
BASE_DIR=`pwd`

mkdir -p releases src tarballs

if [ ! -e "$TARBALL" ]
then
    pushd tarballs > /dev/null
	wget https://www.openssl.org/source/$TARBALL
    popd > /dev/null
fi

mkdir -p releases/$VERSION
pushd src > /dev/null
	cp ../tarballs/$TARBALL .
	tar xzvf $TARBALL
    rm $TARBALL
	pushd openssl-$VERSION > /dev/null
		./config --prefix=$BASE_DIR/releases/$VERSION shared

		make depend
		make
		make install
	popd > /dev/null
popd > /dev/null

pushd releases > /dev/null
    rm -f latest
	ln -s $1 latest
popd > /dev/null

