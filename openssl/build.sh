#!/bin/bash
VERSION=$1
TARBALL=openssl-$1.tar.gz
BASE_DIR=`pwd`

mkdir -p releases src tarballs

pushd tarballs  > /dev/null
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
popd

mkdir -p releases/$VERSION
pushd src
	cp ../tarballs/$TARBALL .
	tar xzvf $TARBALL
    rm $TARBALL
	pushd openssl-$VERSION
		./config --prefix=$BASE_DIR/releases/$VERSION shared

		make depend
		make
		make install
	popd
popd

pushd releases
    rm -f latest
	ln -s $1 latest
popd

