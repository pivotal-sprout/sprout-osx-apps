dmg_package "PhpStorm" do
  source "http://download.jetbrains.com/webide/PhpStorm-5.0.4.dmg"
  action :install
  owner node['current_user']
end



