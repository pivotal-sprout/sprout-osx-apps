Chef::Log.warn "Please use sprout-pivotal::#{File.basename(__FILE__, '.rb')}"
include_recipe "sprout-pivotal::#{File.basename(__FILE__, '.rb')}"
