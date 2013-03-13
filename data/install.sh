#!/bin/bash

wget ftp://ftp.ruby-lang.org/pub/ruby/1.9/ruby-1.9.2-p0.tar.bz2 $ tar xjf ruby-1.9.2-p0.tar.bz2
tar xjf ruby-1.9.2-p0.tar.bz2
cd ruby-1.9.2-p0
./configure
make
make install 
yes | aptitude install rubygems
yes | gem install chef

