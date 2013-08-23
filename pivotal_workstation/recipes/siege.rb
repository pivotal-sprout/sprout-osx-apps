Chef::Log.warn "Please use sprout-osx-apps::#{File.basename(__FILE__, '.rb')}"
include_recipe "sprout-osx-apps::#{File.basename(__FILE__, '.rb')}"
