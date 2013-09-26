define :ruby_install do
  ruby_version = params[:version] || params[:name]
  options = params[:options] || {}

  include_recipe "sprout-osx-rbenv"

  rbenv_cmd = node['sprout']['rbenv']['command']
  install_cmd = "#{rbenv_cmd} install #{ruby_version} #{options[:command_line_options]}"

  execute "installing #{ruby_version} with RBENV: #{install_cmd}" do
    command install_cmd
    user params[:user] || node['current_user']
    only_if params[:only_if] if params[:only_if]
    not_if params[:not_if] || "#{rbenv_cmd} versions | grep #{ruby_version}"
    env params[:options][:env]
  end

  execute "check #{ruby_version}" do
    command "#{rbenv_cmd} versions | grep #{ruby_version}"
    user params[:user] || node['current_user']
  end
end
