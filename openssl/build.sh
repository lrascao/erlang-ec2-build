#!/bin/bash
VERSION=$1
TARBALL=openssl-$1.tar.gz
BASE_DIR=`pwd`

mkdir -p releases src tarballs

pushd tarballs > /dev/null
	if [ ! -e "$TARBALL" ]
	then
		wget http://www.openssl.org/source/$TARBALL
		wget http://www.openssl.org/source/$TARBALL.asc
	fi
	# verify the signature
	gpg --verify $TARBALL.sig $TARBALL
	if [ ! $? -eq 0 ]
	then
		echo "invalid signature for openssl-$1"
	fi
popd > /dev/null

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

