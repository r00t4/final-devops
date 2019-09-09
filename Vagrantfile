servers=[
  {
    :hostname => "host1",
    :ip1 => "192.168.100.10",
    :ip2 => "172.16.100.10",
    :box => "centos/7",
    :ram => 1024,
    :cpu => 1
  },
  {
    :hostname => "host2",
    :ip1 => "192.168.100.11",
    :ip2 => "172.16.100.11",
    :box => "centos/7",
    :ram => 1024,
    :cpu => 1
  }
]

Vagrant.configure(2) do |config|
    servers.each do |machine|
        config.vm.define machine[:hostname] do |node|
            node.vm.box = machine[:box]
            node.vm.hostname = machine[:hostname]
            node.vm.network "private_network", ip: machine[:ip1]
            node.vm.network "private_network", ip: machine[:ip2]
            node.vm.provider "virtualbox" do |vb|
                vb.customize ["modifyvm", :id, "--memory", machine[:ram]]
              end
            end
          end
        config.vm.provision "ansible" do |ansible|
            ansible.playbook = "redis.yml"
            ansible.groups = {
                "centos" => ["host1", "host2" ]
            }
      	end
end
