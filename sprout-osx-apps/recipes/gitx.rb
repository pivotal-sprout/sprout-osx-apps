sprout_osx_apps_homebrew_cask 'gitx-rowanj'

gitx_path = `brew cask list gitx-rowanj | awk '{print $1}'`.strip
gitx_bin_path = File.join(gitx_path, 'Resources', 'gitx')

execute "symlink gitx command line utility to gitx binary" do
  command "ln -s #{gitx_bin_path} /usr/local/bin/gitx"
  user node['current_user']
  not_if { File.symlink?("/usr/local/bin/gitx") }
end

execute "test to see if gitx link worked" do
  command "test -L /usr/local/bin/gitx"
end
