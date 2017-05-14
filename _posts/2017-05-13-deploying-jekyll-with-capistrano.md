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
# config valid only for current version of Capistrano
lock "3.8.1"

set :application, "my_app"
set :repo_url, "git@<git-url>.git"

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/home/deploy/mysite.com'

set :rvm_type, :user
set :rvm_ruby_version, '2.4.0@mysite'

namespace :deploy do

  task :jekyll_build do
    on roles(:app), in: :groups, limit: 3, wait: 10 do
      within current_path do
        execute :bundle, 'exec jekyll build'
      end
    end
  end

  # Run the jekyll build command after the release folder is created
  after "symlink:release", :jekyll_build
end
```

And `production.rb`:

```ruby
server "mysite.com", user: "deploy", roles: %w{app web}
```

That's it! Now just `cap production deploy` to update the site.
