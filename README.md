Erlang build using custom gcc/openssl on Amazon EC2
=====

Setup
-----

* Spin new Amazon EC2 instance (default AWS AMI)
* Clone this repo
    
```
    $ sudo yum install git -y
    $ git clone https://github.com/lrascao/erlang-ec2-build.git
```

* install prerequisite dependencies

```
    $ cd erlang-ec2-build
    $ ./setup.sh
```

Custom gcc
-----

* build a desired gcc version

```
    $ pushd gcc > /dev/null
    $ cat README.md             # for instructions
    $ ./build.sh <gcc_version>  # (eg. ./build.sh 6.3.0)
    $ popd > /dev/null
```

* Add latest gcc to .bashrc PATH, this is the one that will be used from now on
    * `export PATH=~/erlang-ec2-build/gcc/releases/latest/bin:$PATH`

Custom OpenSSL
-----

* Build desired openssl version

```
    $ pushd openssl > /dev/null
    $ cat README.md                 # for instructions
    $ ./build.sh <openssl_version>  # (eg. ./build.sh 1.0.2l)
    $ popd > /dev/null
```

Erlang
-----

* Build desired erlang version

```
    $ cd erlang
    $ cat README.md             # for instructions
```

