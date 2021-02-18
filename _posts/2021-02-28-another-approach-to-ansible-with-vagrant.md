To speed up the ansible development process it is common to use virtual machines and Vagrant is a pretty
good option for that, specially if, like me, you come from a ruby backgroud.

I just had a problem with using Vagrant because it sets up the `vagrant` user for you but you have no
direct `root` ssh access, which is a common form of accessing a real server.

Of course I could just use the `vagrant` user with some `become: yes` instruction but that wouldn't really
replicate the real world scenario.

So I came up with this configuration in order to address that problem:

```ruby
Vagrant.configure("2") do |config|
  # Base
  config.vm.box = "debian/stretch64"

  # Copy your ssh public key to /home/vagrant/.ssh/me.pub
  config.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "~/.ssh/me.pub"

  # Sets ups root ssh access with the copied key:
  config.vm.provision "shell", inline: <<-SHELL
    mkdir -p /root/.ssh
    chmod -R 700 /root/.ssh
    cat /home/vagrant/.ssh/me.pub > /root/.ssh/authorized_keys
    chmod 644 /root/.ssh/authorized_keys
  SHELL
end
```

With this, we can simply access the machine via the port `2222`:
```
ssh -p 2222 root@localhost
```

And add the machine to your inventory:

```
my-machine ansible_connection=local ansible_port=2222
```

## Improvements

Even though that already works, it difficult to control the machines with the port vagrant is granting access to via ssh.

In order to make it better we could add a private network to the box and access via the assigned IP address:

```ruby
Vagrant.configure("2") do |config|
  # other config
  config.vm.network :private_network, ip: "10.0.1.10", mask: "255.255.255.0"
  # some more config
```

This way we can simple access the machine via ssh:

```
ssh root@10.0.1.10
```

Or add it to the ansible inventory:

```
my-machine ansible_host=10.0.1.10
```