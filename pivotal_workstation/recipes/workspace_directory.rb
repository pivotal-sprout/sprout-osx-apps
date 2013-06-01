Chef::Log.warn "Please use sprout-osx-base::#{File.basename(__FILE__, '.rb')}"
include_recipe "sprout-osx-base::#{File.basename(__FILE__, '.rb')}"
