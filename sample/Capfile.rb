now_ip_addr	= "192.168.1.241"
new_ip_addr	= ""
host_name	= ""
nc_name		= ""
proxy 		= "http://proxy.tohtech.ac.jp:8080"
nameserver 	= "192.168.1.1"
domain		= "lab.tsunolab.net"

repo_1		= "deb http://downloads.eucalyptus.com/software/euca2ools/2.1/ubuntu precise main"
repo_2		= "deb http://downloads.eucalyptus.com/software/eucalyptus/3.1/ubuntu precise main"

if_conf		= "/etc/network/interfaces"
pkg_conf	= "/etc/apt/apt.conf"
src_list	= "/etc/apt/sources.list"
own_ipaddr	= ""
profile		= "/etc/profile"
resolv		= "/etc/resolv.conf"





set :user, 'root'

task :eucalyptus, :hosts => now_ip_addr do
	run 'echo Acquire::http::Proxy	\"'+   proxy   +'\"\; >> '+   pkg_conf
	run 'echo Acquire::https::Proxy	\"'+   proxy   +'\"\; >> '+   pkg_conf
	run 'echo Acquire::ftp::Proxy	\"'+   proxy   +'\"\; >> '+   pkg_conf
	run 'echo \"export https_proxy='   +   proxy   +'\" >> '  +   profile 
	run 'echo \"export http_proxy='    +   proxy   +'\" >> '  +   profile 
	run 'echo \"export ftp_proxy='     +   proxy   +'\" >> '  +   profile 
	run 'echo '+   nameserver   +' >> '+   nameserver
	run 'echo '+   domain       +' >> '+   domain
	run 'echo \"'+   repo_1   +'\" >> '+   src_list 
	run 'echo \"'+   repo_2   +'\" >> '+   src_list 
	run "aptitude install -y unzip"
	run "mkdir /root/creds"
	upload "/root/data/mycreds.zip","/root/creds/mycreds.zip"
	upload "/root/data/interfaces",if_conf
	upload "/root/data/chef-repo.tar","/root/chef-repo"
	run "unzip /root/creds/mycreds.zip"
	run "source /root/creds/mycreds.zip"
	run 'echo \"/root/creds/eucarc\" >> '+   profile
	run 'echo '+   now_ip_addr    +' >> '+   if_conf
	run '/etc/init.d/networking restart'
	run 'aptitude update'
	run 'wget ftp://ftp.ruby-lang.org/pub/ruby/1.9/ruby-1.9.2-p0.tar.bz2'
	run 'tar xjf ruby-1.9.2-p0.tar.bz2'
	run 'cd ruby-1.9.2-p0'
	run './configure'
	run 'make'
	run 'make install'
	run 'yes | aptitude install rubygems'
	run 'yes | gem install chef'
	run 'tar xfv /root/chef-repo.tar .'
	run 'cd /root/chef-repo'
	run 'chef-solo -c .chef/solo.rb -j .chef/chef.json'
	run '/etc/init.d/eucalyptus-nc start' 
	run 'yes | aptitude safe-upgrade'
end
