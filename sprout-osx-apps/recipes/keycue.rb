unless File.exists?('/Applications/KeyCue.app')

  dmg_package node['sprout']['keycue']['package_name'] do
    volumes_dir node['sprout']['keycue']['volumes_dir']
    source node['sprout']['keycue']['download_uri']
    checksum node['sprout']['keycue']['checksum']
    action :install
    owner node['current_user']
  end

  ruby_block 'test to see if KeyCue was installed' do
    block do
      raise 'KeyCue.app was not installed' unless File.exists?('/Applications/KeyCue.app')
    end
  end

end


