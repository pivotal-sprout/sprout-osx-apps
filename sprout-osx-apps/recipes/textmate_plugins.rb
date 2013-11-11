run_unless_marker_file_exists("textmate_plugins_0") do
  ["curl -o #{Chef::Config[:file_cache_path]}/projectplus.dmg http://ciaranwal.sh/projectplus-files/ProjectPlus-1.3.dmg",
   "hdiutil mount #{Chef::Config[:file_cache_path]}/projectplus.dmg",
   "rm -rf '#{node['sprout']['home']}/Library/Application Support/TextMate/PlugIns/ProjectPlus.tmplugin'",
  ].each do |tmate_cmd|
    execute tmate_cmd do
      user node['current_user']
    end
  end

  execute "make textmate plugins directory" do
    command "mkdir -p '#{node['sprout']['home']}/Library/Application Support/TextMate/PlugIns'"
    user node['current_user']
    not_if { File.exists?("#{node['sprout']['home']}/Library/Application Support/TextMate/PlugIns") }
  end

  execute "copy to TextMate" do
    command "cp -Rf /Volumes/ProjectPlus/ProjectPlus.tmplugin '#{node['sprout']['home']}/Library/Application Support/TextMate/PlugIns'"
    user node['current_user']
  end

  execute "unmount dmg" do
    command "hdiutil detach  /Volumes/ProjectPlus"
    user node['current_user']
  end
end
