Chef::Log.warn "Please use sprout-textmate::#{File.basename(__FILE__, '.rb')}"
include_recipe "sprout-textmate::#{File.basename(__FILE__, '.rb')}"
