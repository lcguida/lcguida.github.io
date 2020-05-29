---
layout: post
title: Splitting ssh config in multiple files
---

I have an extensive `~/.ssh/config` file due to multiple credentials in differents servers for work
and for personal purposes. This means different public/private ssh keys pairs, different users,
different servers, etc.

My file something like :

```config
# General configuration
Host: *
  Port 22
  IdentityFile ~/.ssh/id_rsa
  ServerAliveInterval 60
  ServerAliveCountMax 5

# Personal config
Host github
  HostName github.com
  IdentityFile ~/.ssh/github_rsa

Host lcguida
  HostName lcguida.com
  User admin

# Work servers
# ...

# Another company servers
# ...
```

This was OK at the beginning but as time passes and the file grows (Raspberry access, another server at work, etc, etc) this has become a huge mess.

But since the [7.3p1 release](https://www.openssh.com/txt/release-7.3) in 2016, `ssh` allows us to use a `Include` directive to import other config files. It supports the `~` shortcut as well as wildcard notation (`*`).

Inspired by the `.d` directory pattern present in many linux programs, I configured my system as the following:

```
.ssh
├── config
├── config.d
│   ├── work.config
│   ├── home.config
│   └── code.config
└── known_hosts
```

So each `<name>.config` file has credential informations for a specific topic (work, personal, home, etc) and I have the `config` file configure as following:

```
Host *
  Port 22
  IdentityFile ~/.ssh/id_rsa
  ServerAliveInterval 60
  ServerAliveCountMax 5

Include ~/.ssh/config.d/*.config
```

Voilà. Sanity is back to ssh config files.






