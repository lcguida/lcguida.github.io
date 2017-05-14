---
layout: post
title: Deploying jekyll with capistrano
---

Assumptions:

* Server uses RVM
* Jekyll uses bundle

## Install Capistrano

Add capistrano and dependencies to Gemfile:

```ruby
group :deployment do
  gem 'capistrano'
  gem 'capistrano-rvm'
  gem 'capistrano-bundler'
end
```

And `bundle install`:

```shell_session
$ blog cap install .

mkdir -p config/deploy
create config/deploy.rb
create config/deploy/staging.rb
create config/deploy/production.rb
mkdir -p lib/capistrano/tasks
create Capfile
Capified

```

## Configuring capistrano

`deploy.rb`:

```ruby
lock "3.8.1"

# Application name
set :application, "lcguida"

# Github URL
set :repo_url, "git@github.com:lcguida/lcguida.github.io.git"

# Deployment path
set :deploy_to, '/home/deploy/blog'

# RVM Configuration
set :rvm_type, :user
set :rvm_ruby_version, '2.4.0@blog'

# Add a task to build the site, after it has been

namespace :deploy do

  task: :jekyll_build do
    on roles(:app), in: :groups, limit: 3, wait: 10 do
      within current_path do
        execute :bundle, 'exec jekyll build'
      end
    end
  end

end

# Run the jekyll build command after the release folder is created
after "symlink:release", "update_jekyll"
```

And `production.rb`:

```ruby
server "mysite.com", user: "deploy", roles: %w{app web}
```

That's it! Now just `cap production deploy` to update the site.
