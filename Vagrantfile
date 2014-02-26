# -*- mode: ruby -*-
# vi: set ft=ruby :
VAGRANTFILE_API_VERSION = "2"

$install_chef = <<SCRIPT
if ! [ -d '/opt/chef' ];
then
  curl -L https://www.opscode.com/chef/install.sh | sudo bash
fi
SCRIPT

provisioner = {
  cookbooks: "cookbooks",
  roles: "roles",
  databags: "data_bags"
}

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.provision :shell, :inline => $install_chef

  config.vm.define "centos" do |centos|
    centos.vm.box = "Centos-6.4-x86_64"
    centos.vm.provider "virtualbox" do |v|
      v.memory = 256
    end
    if Vagrant.has_plugin?("vagrant-cachier")
      centos.cache.auto_detect = true
      # If you are using VirtualBox, you might want to enable NFS for shared folders
      # centos.cache.enable_nfs  = true
    end
    centos.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = provisioner[:cookbooks]
      chef.roles_path = provisioner[:roles]
      chef.data_bags_path = provisioner[:databags]
      chef.arguments = '-l debug'
      chef.run_list = [
        "recipe[ffmpeg]"
      ]
      chef.json = {
        "ffmpeg" => {
          "compile_flags" => [
            "--enable-pthreads",
            "--enable-libmp3lame",
            "--disable-avdevice",
            "--disable-network",
            "--enable-libopencore-amrnb",
            "--enable-libopencore-amrwb",
            "--enable-version3",
            "--disable-decoder=amrnb"
          ],
          "git_repository" => "git://github.com/FFmpeg/FFmpeg.git"
        }
      }
    end
  end

  config.vm.provision :shell, :inline => $install_chef

  config.vm.define "ubuntu" do |ubuntu|
    ubuntu.vm.box = "ubuntu-12.04-x86_64"
    ubuntu.vm.provider "virtualbox" do |v|
      v.memory = 256
    end
    if Vagrant.has_plugin?("vagrant-cachier")
      ubuntu.cache.auto_detect = true
      # If you are using VirtualBox, you might want to enable NFS for shared folders
      # ubuntu.cache.enable_nfs  = true
    end
    ubuntu.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = provisioner[:cookbooks]
      chef.roles_path = provisioner[:roles]
      chef.data_bags_path = provisioner[:databags]
      chef.arguments = '-l debug'
      chef.run_list = [
        "recipe[ffmpeg]"
      ]
      chef.json = {
        "ffmpeg" => {
          "compile_flags" => [
            "--enable-pthreads",
            "--enable-libmp3lame",
            "--disable-avdevice",
            "--disable-network",
            "--enable-libopencore-amrnb",
            "--enable-libopencore-amrwb",
            "--enable-version3",
            "--disable-decoder=amrnb"
          ],
          "git_revision" => "ace432f62cdcedf812e7c4d77fc5b03322170fa8" # 0.6.3
        }
      }
    end
  end

end
