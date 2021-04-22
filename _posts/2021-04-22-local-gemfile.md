---
layout: post
title: Local Gemfile
---

Sometimes I like to use some gems that may not be present in the project `Gemfile`. If I have no
power to add to it, or that gem only make sense to me, I use a strategy to create a local `Gemfile`

Let's suppose the project uses `pry` but I'm a `byebug` fan. I will create a new Gemfile
in the project root called `Gemfile.local`:

```ruby
# Reads and evaluates the original Gemfile
eval File.read('Gemfile')

group :development do
  gem 'byebug'
end
```

This file will evaluate all contents of `Gemfile` and add the gems we describe below that line.
In this case, we will use all gems plus the `byebug` gem in the `developement` group.

Now let's copy the original `Gemfile.lock` to a `Gemfile.local.lock` to make sure we don't
change any gem version:

```shell
cp Gemfile.lock Gemfile.local.lock
```

And then we use the `--gemfile` bundle option to install the gems:

```shell
bundle install --gemfile Gemfile.local
```

And now we can use it:

```ruby
# my_code.rb
require 'byebug'

class SomeClass
  def some_method
    byebug
    p 'Hello'
  end
end

SomeClass.new.some_method
```

```shell
bundle exec --gemfile Gemfile.local ruby my_code.rb

[1, 10] in my_code.rb
    1: require 'byebug'
    2:
    3: class SomeClass
    4:   def some_method
    5:     byebug
=>  6:     p 'Hello'
    7:   end
    8: end
    9:
   10: SomeClass.new.some_method
(byebug)
```


Nice it works. But do I need to set the `--gemfile` in all my commands?

Not really. We can set a environment variable for that:

```bash
export BUNDLE_GEMFILE='Gemfile.local'
```