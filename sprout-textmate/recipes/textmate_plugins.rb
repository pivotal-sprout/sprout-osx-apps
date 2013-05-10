homedir = node['etc']['passwd'][node['current_user']]['dir']

unless File.exists?("#{homedir}/Library/Application Support/TextMate/PlugIns/ProjectPlus.tmplugin")
  ["curl -o #{Chef::Config[:file_cache_path]}/projectplus.dmg http://ciaranwal.sh/projectplus-files/ProjectPlus-1.3.dmg",
   "hdiutil mount #{Chef::Config[:file_cache_path]}/projectplus.dmg",
  ].each do |tmate_cmd|
    execute tmate_cmd do
      user node['current_user']
    end
  end

  execute "make textmate plugins directory" do
    command "mkdir -p '#{homedir}/Library/Application Support/TextMate/PlugIns'"
    user node['current_user']
    not_if { File.exists?("#{homedir}/Library/Application Support/TextMate/PlugIns") }
  end

  execute "copy to TextMate" do
    command "cp -Rf /Volumes/ProjectPlus/ProjectPlus.tmplugin '#{homedir}/Library/Application Support/TextMate/PlugIns'"
    user node['current_user']
  end

  execute "unmount dmg" do
    command "hdiutil detach  /Volumes/ProjectPlus"
    user node['current_user']
  end
end
