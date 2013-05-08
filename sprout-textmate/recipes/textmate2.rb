node.default["textmate"]["url"] = "https://github.com/downloads/textmate/textmate/TextMate_r9345.tbz"
node.default["textmate"]["shasum"] = "ecfc4546db94945ca74765ad78363219"

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

  ruby_block "test to see if TextMate was installed" do
    block do
      raise "TextMate install failed" unless File.exists?("/Applications/TextMate.app")
    end
  end
end

include_recipe "sprout-osx-apps::textmate_link"
