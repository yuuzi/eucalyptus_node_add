######## initializing #########
        host = '/etc/hosts'
        repos = '/etc/apt/sources.list.d/eucalyptus.list'
        resolv = '/etc/resolv.conf'
        pub_key = '/tmp/c1240596-eucalyptus-release-key.pub'
        eucalyptus_conf = '/etc/eucalyptus/eucalyptus.conf'

######## files putting ########
%W(#{host} #{repos} #{resolv} #{pub_key}).each do |package_name|
name = package_name.split("/")
name = name.last.chomp+".erb"
        template package_name do
                source name
        end
end

###### command initializing ####
execute "apt_update" do
command 'apt-key add /tmp/c1240596-eucalyptus-release-key.pub'
end
execute "euca_install" do
command 'apt-get install debian-archive-keyring'
end
execute "update" do
command 'aptitude update'
end

####### command running #######
file host do
        notifies        :run,   resources(:execute => "apt_update")
        notifies        :run,   resources(:execute => "euca_install")
        notifies        :run,   resources(:execute => "update")
end



%w(eucalyptus-walrus).each do |package_name|
  package package_name do
    action :install
  end
end

########### eucalyptus.conf putting ###############
template eucalyptus_conf do
        source "eucalyptus.conf.erb"
end
