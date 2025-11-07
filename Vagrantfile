IMAGE_NAME = "ubuntu/jammy64"

Vagrant.configure("2") do |config|
  config.ssh.insert_key = false

  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
    v.cpus = 2
  end

  config.vm.define "ubuntu" do |ubuntu|
    ubuntu.vm.box = IMAGE_NAME

    # SSH forwarding host 22222 → guest 22
    ubuntu.vm.network "forwarded_port", guest: 22, host: 22222

    # HTTP forwarding host 8080 → guest 80
    ubuntu.vm.network "forwarded_port", guest: 80, host: 8080

    ubuntu.vm.hostname = "ubuntu"
  end

  # Přidání vlastního veřejného SSH klíče
  config.vm.provision "file", source: "id_rsa.pub", destination: "/home/vagrant/.ssh/me.pub"

  config.vm.provision "shell", inline: <<-SHELL
    mkdir -p /home/vagrant/.ssh
    cat /home/vagrant/.ssh/me.pub >> /home/vagrant/.ssh/authorized_keys
    chmod 700 /home/vagrant/.ssh
    chmod 600 /home/vagrant/.ssh/authorized_keys
    chown -R vagrant:vagrant /home/vagrant/.ssh
  SHELL

  # Instalace Zabbix Agent 2
  config.vm.provision "shell", path: "install-zabbix-agent2.sh"

  # Konfigurace Zabbix Agent 2
  config.vm.provision "shell", path: "configure-zabbix-agent2.sh"
end
