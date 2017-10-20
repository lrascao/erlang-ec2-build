# Building Erlang

$ curl -O https://raw.githubusercontent.com/kerl/kerl/master/kerl; chmod a+x kerl
$ ./kerl update releases
$ KERL_CONFIGURE_OPTIONS="--with-ssl=/home/ec2-user/erlang-ec2-build/openssl/releases/latest --disable-dynamic-ssl-lib" CFLAGS="-g -O2 -march=native" ./kerl build <version> <version>

$ kerl install 19.3 /opt/erlang/19.3-gcc5.4.0

$ cd /opt/erlang/
$ tar czf /tmp/erlang-19.3-gcc5.4.0.tar.gz 19.3-gcc5.4.0/
