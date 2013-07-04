include_recipe "pivotal_workstation::user_owns_usr_local"

node.default["textmate"]["url"] = "http://archive.textmate.org/TextMate_alpha-9443.tbz"
node.default["textmate"]["shasum"] = "298c31f8dab803840de238e24bde7f82744816061244740d6ae54237688492d6"

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
