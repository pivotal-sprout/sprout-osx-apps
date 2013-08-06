dmg_properties = node['sprout']['daisydisk']['dmg']

dmg_package "DaisyDisk" do
  source      dmg_properties['source']
  checksum    dmg_properties['checksum']
  volumes_dir dmg_properties['volumes_dir']
  owner       node['current_user']
end

app_supportdir = "#{node['sprout']['home']}/Library/Application Support"

recursive_directories([app_supportdir, "DaisyDisk"]) do
  owner node['current_user']
end

template File.join(app_supportdir, 'DaisyDisk', 'License.DaisyDisk') do
  source "License.DaisyDisk.erb"
  owner node['current_user']
  variables :license => node['sprout']['daisydisk']['license']
  not_if { node['sprout']['daisydisk']['license']['customer_name'].nil? || node['sprout']['daisydisk']['license']['registration_key'].nil? }
end