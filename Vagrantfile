Vagrant.require_version ">= 1.7.0"

Vagrant.configure(2) do |config|

  if Vagrant.has_plugin?("HostManager")
    config.hostmanager.enabled = true
    config.hostmanager.manage_host = true
    config.hostmanager.ignore_private_ip = false
    config.hostmanager.include_offline = true
  end

  config.vm.define "TGC" do |tgc|
    tgc.vm.box = "ubuntu/xenial64"
    tgc.vm.network :private_network, ip: "192.168.33.151"
    tgc.vm.hostname = "globe.dev"

    # Forward the Rails server default port to the host
    tgc.vm.network :forwarded_port, guest: 3000, host: 3000
    tgc.vm.network :forwarded_port, guest: 5432, host: 5432

    tgc.vm.provision :ansible do |ansible|
      # ansible.verbose = "v"
      ansible.playbook = "provisioning/playbook.yml"
    end
  end

  config.vm.synced_folder ".", "/srv/tgc", type: "nfs"

  config.vm.provider "virtualbox" do |v|
    v.memory = 512
    v.cpus = 1
  end
end
