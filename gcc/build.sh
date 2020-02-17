#!/bin/bash
VERSION=$1
TARBALL=gcc-$VERSION.tar.gz
BASE_DIR=`pwd`

# ensure gcc and g++
if [ "$(which gcc 2>/dev/null)" = "" ]
then
    echo "no valid gcc found. use update-alternatives to configure one"
    exit 1
fi
if [ "$(which g++ 2>/dev/null)" = "" ]
then
    echo "no valid g++ found. use update-alternatives to configure one"
    exit 1
fi

# ensure dirs
mkdir -p src tarballs releases

pushd tarballs > /dev/null
    if [ ! -e "$TARBALL" ]
    then
        wget ftp://ftp.gnu.org/pub/gnu/gcc/gcc-$VERSION/$TARBALL
        wget ftp://ftp.gnu.org/pub/gnu/gcc/gcc-$VERSION/$TARBALL.sig
    fi
    # verify the signature
    gpg --verify $TARBALL.sig $TARBALL
    if [ ! $? -eq 0 ]
    then
        echo "invalid signatures for gcc $VERSION"
    fi
popd > /dev/null

pushd src > /dev/null
	cp ../tarballs/$TARBALL .
	tar xzvf $TARBALL
	rm $TARBALL

	pushd gcc-$VERSION > /dev/null
		./configure --prefix=$BASE_DIR/releases/$VERSION --with-system-zlib --disable-multilib --enable-languages=c,c++

		make
		make install
	popd > /dev/null
popd > /dev/null

pushd releases > /dev/null
	rm -f latest
	ln -s $VERSION latest
popd > /dev/null

# update alternative gcc
# update alternative gcc
sudo update-alternatives --install /usr/bin/gcc gcc $BASE_DIR/releases/$VERSION/bin/gcc 10
sudo update-alternatives --install /usr/bin/g++ g++ $BASE_DIR/releases/$VERSION/bin/g++ 10

sudo update-alternatives --set gcc "$BASE_DIR/releases/$VERSION/bin/gcc"
sudo update-alternatives --set g++ "$BASE_DIR/releases/$VERSION/bin/g++"

