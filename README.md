# sprout

[![Build Status](https://travis-ci.org/pivotal-sprout/sprout.png?branch=master)](https://travis-ci.org/pivotal-sprout/sprout)
[![Stories in Ready](https://badge.waffle.io/pivotal-sprout/sprout.png)](http://waffle.io/pivotal-sprout/sprout)

Chef cookbooks to configure an OS X Mountain Lion workstation. Successor to pivotal_workstation. The easiest way 
to get started with sprout is by using [sprout-wrap](https://github.com/pivotal-sprout/sprout-wrap).

## Cookbooks

| Cookbook            | Description                                            |
| ------------------- | -------------------------------------------------------|
| sprout-osx-base     | A handful of things every Sprout recipe needs          |
| sprout-osx-apps     | Commonly used OS X Mountain Lion applications          |
| sprout-osx-settings | Various settings & preferences for OS X Mountain Lion. |
| sprout-pivotal      | Pivotal Labs specific configuration and settings       |
| pivotal_workstation | DEPRECATED in favor of sprout-*                        |

## Discussion List

  Join [sprout-users@googlegroups.com](https://groups.google.com/forum/#!forum/sprout-users) if you use Sprout.

## References

* Slides from @hiremaga's [lightning talk on Sprout](http://sprout-talk.cfapps.io/) at Pivotal Labs in June 2013

## Tips

### Finding the checksum for dmg_package

```
shasum -a 256 /var/chef/cache/ccmenu-1.5-b.dmg
=> "c11302c03c90bffeafb25b36a0a77c97fc27f32f2c32845df2292416b46457aa"
```
