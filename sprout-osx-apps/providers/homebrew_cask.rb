action :install do
  run_context.include_recipe "sprout-osx-apps::homebrew_cask"
  package = new_resource.name

  execute "brew cask install #{package}" do
    only_if { system("brew cask info #{package} | grep 'Not installed' > /dev/null 2>&1") }
    user node['current_user']
    command "brew cask install #{new_resource.opts} #{package}"
  end
end
