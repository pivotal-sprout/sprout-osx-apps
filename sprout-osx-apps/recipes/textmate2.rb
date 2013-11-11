include_recipe "pivotal_workstation::user_owns_usr_local"

node.default["textmate"]["url"] = "http://archive.textmate.org/TextMate_2.0-alpha.9487.tbz"
node.default["textmate"]["shasum"] = "b710dae92bedec95825e2ce79ea35ecf50abdf707367a1c5e108293333bfeeaf"

unless File.exists?("/Applications/TextMate.app")
  directory Chef::Config[:file_cache_path] do
    action :create
    recursive true
  end

  remote_file "#{Chef::Config[:file_cache_path]}/textmate.zip" do
    source node["textmate"]["url"]
    checksum node["textmate"]["shasum"]
    owner node['current_user']
  end

  execute "extract text mate to /Applications" do
    command "tar -xvf #{Chef::Config[:file_cache_path]}/textmate.zip -C /Applications/"
    user node['current_user']

    # This is required to unzip into Applications
    group "admin"
  end

  execute "link textmate" do
    command "ln -s /Applications/TextMate.app/Contents/Resources/mate /usr/local/bin/mate"
    not_if "test -e /usr/local/bin/mate"
  end

  ruby_block "test to see if TextMate was installed" do
    block do
      raise "TextMate install failed" unless File.exists?("/Applications/TextMate.app")
    end
  end
end

execute "link textmate" do
  command "ln -s /Applications/TextMate.app/Contents/Resources/mate /usr/local/bin/mate"
  not_if "test -e /usr/local/bin/mate"
end
