Chef::Log.warn("[pivotal_workstation::java] is deprecated please use [sprout-osx-apps::java] in the future.")

include_recipe "sprout-osx-apps::java"
