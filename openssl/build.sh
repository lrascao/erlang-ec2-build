#!/bin/bash
TARBALL=openssl-$1.tar.gz

mkdir -p releases src tarballs

pushd tarballs  > /dev/null
	if [ ! -e "$TARBALL" ]
	then
		wget http://www.openssl.org/source/openssl-$1.tar.gz
		wget http://www.openssl.org/source/openssl-$1.tar.gz.asc
	fi
	# verify the signature
	gpg --verify $TARBALL.sig $TARBALL
	if [ ! $? -eq 0 ]
	then
		echo "invalid signature for openssl-$1"
	fi
popd

mkdir -p releases/$1
pushd src
	cp ../tarballs/openssl-$1.tar.gz .
	tar xzvf openssl-$1.tar.gz
	pushd openssl-$1
		./config --prefix=/home/ec2-user/openssl/releases/$1 shared

		make depend
		make
		make install
	popd
popd

pushd releases
	ln -s $1 latest
popd

