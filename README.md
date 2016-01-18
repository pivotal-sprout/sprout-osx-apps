# sprout

[![Build Status](https://travis-ci.org/pivotal-sprout/sprout.png?branch=master)](https://travis-ci.org/pivotal-sprout/sprout)

Roadmap in Pivotal Tracker: https://www.pivotaltracker.com/s/projects/884116

Chef cookbooks to configure an OS X Mavericks workstation. The easiest way 
to get started with sprout is by using [sprout-wrap](https://github.com/pivotal-sprout/sprout-wrap).

## Homebrew env ##
In case `soloist` command fails, re-run command in debug mode
```
LOG_LEVEL=debug bundle exec soloist
```

You will need to setup Homebew env variables

```
export HOMEBREW_PREFIX=/usr/local
export HOMEBREW_REPOSITORY=/usr/local
export HOMEBREW_LIBRARY=/usr/local/Library
export HOMEBREW_CELLAR=/usr/local/Cellar
```

## Discussion List

  Join [sprout-users@googlegroups.com](https://groups.google.com/forum/#!forum/sprout-users) if you use Sprout.

## References

* Slides from @hiremaga's [lightning talk on Sprout](http://sprout-talk.cfapps.io/) at Pivotal Labs in June 2013
* [Railscast on chef-solo](http://railscasts.com/episodes/339-chef-solo-basics) by Ryan Bates (PAID)

## Tips

### Finding the checksum for dmg_package

```
shasum -a 256 /var/chef/cache/ccmenu-1.5-b.dmg
=> "c11302c03c90bffeafb25b36a0a77c97fc27f32f2c32845df2292416b46457aa"
```
