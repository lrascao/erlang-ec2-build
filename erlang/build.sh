#!/bin/bash
VERSION=$1

curl -O https://raw.githubusercontent.com/kerl/kerl/master/kerl
chmod a+x kerl
./kerl update releases
KERL_CONFIGURE_OPTIONS="--with-ssl=/home/ec2-user/erlang-ec2-build/openssl/releases/latest --disable-dynamic-ssl-lib --enable-hipe --without-wx --without-observer --without-odbc --without-debugger --without-et --enable-builtin-zlib --without-javac --with-dynamic-trace=systemtap" CFLAGS="-g -O2 -march=native" ./kerl build $VERSION $VERSION

DST=/opt/erlang
echo "Going to install at $DST"
sudo mkdir -p $DST
sudo chown ec2-user:ec2-user $DST
./kerl install $VERSION $DST/$VERSION

cd $DST
TARB=/tmp/erlang-$VERSION.tar.gz
tar czf $TARB $VERSION
echo "Your OTP/Erlang $VERSION tarball can be found at $TARB"
