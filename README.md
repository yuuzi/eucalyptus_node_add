for eucalyptus version 3.1

target dist are Ubuntu12.04server & CentOS6.3

you should modify Capfile
for example targetIPs,proxy,nameserver,domain,,,and more

if you want to eucalyptus-nc & eucalyptus-walrus on Ubuntu12.04server
you should be
# apt-get install capistrano
# cd hogehoge/sample
# cap eucalyptus


if you want to eucalyptus-nc on Ubuntu12.04server
you should be
# apt-get install capistrano
# cd hogehoge/sample
# cap nc


if you want to eucalyptus-walrus on Ubuntu12.04server
you should be
# apt-get install capistrano
# cd hogehoge/sample
# cap walrus
