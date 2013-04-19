Chef::Log.warn "Please use sprout-osx-settings::#{File.basename(__FILE__, '.rb')}"
include_recipe "sprout-osx-settings::#{File.basename(__FILE__, '.rb')}"
