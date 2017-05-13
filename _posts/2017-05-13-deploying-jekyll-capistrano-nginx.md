---
layout: post
title: Deploying a jekyll blog with capistano and nginx
---

Let me tell you how I got this site/blog up and running.

What are we going to use?

* [Jekyll](https://jekyllrb.com/)
* [Capistrano](http://capistranorb.com/)
* [Nginx](https://www.nginx.com/)
* [Hyde Theme](http://hyde.getpoole.com/)

# Getting Hyde

For the theme, we'll be using `Hyde`. As `Hyde` already brings `jekyll`
structure ready, we don't need to `jekyll new` to start our blog.
Instead, just clone the [hyde repository](https://github.com/poole/hyde) directly from github:

```bash
$ git clone https://github.com/poole/hyde my_blog
```

Since hyde was cloned, it is a git repository. So let's remove the original git
repository so we can configured our own repository latter.

```bash
$ cd my_blog
$ rm -rf .git

```
# Installing and updating Jekyll

Since `jekyll` is a gem, this is as simple as:

```bash
$ gem install jekyll
```

Since Hyse was made with jekyll 2 we need to change some things. First of all
jekyll gem has dropped some direct dependencies as `jekyll-paginate` and
`jekyll-gist`.

So in order to use them we need to manually install them:

```bash
$ gem install jekyll-paginate jekyll-gist
```

and require them in the `_config.yml` file:

```yaml
gems: [jekyll-paginate, jekyll-gist]
```

Other dropped dependencies were `redcarpet` and `pygments.rb`. We can replace
them for the `kramdown` and `rouge` in the `_config.yml` file:

```yaml
# Dependencies
markdown:         kramdown
highlighter:      rouge
```

Jekyll 3 also has [removed relative permalink support](https://jekyllrb.com/docs/upgrading/2-to-3/#relative-permalink-support-removed),
which we can fix by removing this option from `_config.yml`

```yaml
# relative_permalinks: true
```

Now, we can try our blog by serving it with `jekyll serve` and accessing
`http://localhost:4000`
