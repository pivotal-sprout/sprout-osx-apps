ruby_block "Install Jumpcut" do
  block do
    system("cd #{Chef::Config[:file_cache_path]}/ && curl -L 'http://downloads.sourceforge.net/project/jumpcut/jumpcut/0.63/Jumpcut_0.63.tgz?r=http%3A%2F%2Fjumpcut.sourceforge.net%2F&ts=1319134739&use_mirror=iweb' | gunzip | tar xf -")
    system("mv #{Chef::Config[:file_cache_path]}/Jumpcut.app /Applications")
    system("chown -R #{node['current_user']} /Applications/Jumpcut.app")
  end
  not_if {File.exists?("/Applications/Jumpcut.app")}
end

ruby_block "test that Jumpcut install worked" do
  block do
    raise "Jumpcut install failed!" if ! File.exists?("/Applications/Jumpcut.app")
  end
end
