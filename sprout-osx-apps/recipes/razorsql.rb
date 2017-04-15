unless File.exists?('/Applications/RazorSQL.app')

  dmg_package node['sprout']['razorsql']['package_name'] do
    volumes_dir node['sprout']['razorsql']['volumes_dir']
    source node['sprout']['razorsql']['download_uri']
    checksum node['sprout']['razorsql']['checksum']
    action :install
    owner node['current_user']
  end

  ruby_block 'test to see if RazorSQL was installed' do
    block do
      raise 'RazorSQL.app was not installed' unless File.exists?('/Applications/RazorSQL.app')
    end
  end

end

