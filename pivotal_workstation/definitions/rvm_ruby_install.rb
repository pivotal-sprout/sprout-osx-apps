define :rvm_ruby_install do
  ruby_version = params[:version] || params[:name]
  options = params[:options]
  raise "options should be a hash with :env and :command_line_options keys" unless options.is_a?(Hash)

  include_recipe "pivotal_workstation::rvm"

  execute "clean out the archive and src directories each time.  bad downloads cause problems with rvm" do
    only_if params[:only_if] if params[:only_if]
    not_if params[:not_if] || "test -e #{::RVM_HOME}/bin/#{ruby_version}"
    command "rm -rf #{::RVM_HOME}/archives/*#{ruby_version}* #{::RVM_HOME}/src/*#{ruby_version}*"
    user params[:user] || node['current_user']
  end

  install_cmd = "#{options[:env]} #{RVM_COMMAND} install #{ruby_version} #{options[:command_line_options]}"
  #| (! grep 'error') : if we see rvm errors in stderr, fail
  #this is due to an rvm bug (we've notified the author).  as soon as curl error cause rvm to exit nonzero,
  #we can get rid of this
  #
  # Pat: if you get this error:
  #   "There has been an error fetching the ruby interpreter. Halting the installation."
  # then you probably need to add this to attributes/rvm.rb
  #   :command_line_options => "--verify-downloads 1"
  # For debugging you can add this after after 2>&1 below:
  #   add " tee '/tmp/rvm_install_err.txt' |" to help with debugging
  #
  install_cmd << " 2>&1 | (! grep error | grep -v \"clang: error: unsupported option '--with-libyaml'\")"

  execute "installing #{ruby_version} with RVM: #{install_cmd}" do
    only_if params[:only_if] if params[:only_if]
    not_if params[:not_if] || "test -e #{::RVM_HOME}/bin/#{ruby_version}"
    command install_cmd
    environment({ 'HOME' => node['sprout']['home'] })
    user params[:user] || node['current_user']
  end

  execute "check #{ruby_version}" do
    command "#{RVM_COMMAND} list | grep #{ruby_version}"
    user params[:user] || node['current_user']
    environment({ 'HOME' => node['sprout']['home'] })
  end
end
