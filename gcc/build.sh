#!/bin/bash
TARBALL=gcc-$1.tar.gz
PWD=`pwd`

# ensure dirs
mkdir -p src tarballs releases

pushd tarballs > /dev/null
    if [ ! -e "$TARBALL" ]
    then
        wget ftp://ftp.gnu.org/pub/gnu/gcc/gcc-$1/$TARBALL
        wget ftp://ftp.gnu.org/pub/gnu/gcc/gcc-$1/$TARBALL.sig
    fi
    # verify the signature
    gpg --verify $TARBALL.sig $TARBALL
    if [ ! $? -eq 0 ]
    then
        echo "invalid signatures for gcc $1"
    fi
popd

pushd src > /dev/null
	cp ../tarballs/$TARBALL .
	tar xzvf $TARBALL
	rm $TARBALL

	pushd gcc-$1 > /dev/null
		./configure --prefix=$PWD/releases/$1 --with-system-zlib --disable-multilib --enable-languages=c,c++

		make
		make install
	popd
popd

pushd releases
	rm -f latest
	ln -s $1 latest
popd
