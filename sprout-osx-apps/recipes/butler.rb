dmg_package "Butler" do
  source      "http://manytricks.com/download/butler"
  checksum    "d0b9962d506815bf0605aaee136cfdd783fdc6c5bcd5d2efe5e1d23b37be184a"
  action :install
  owner node['current_user']
end

execute "Start Butler on login" do
  command "addloginitem /Applications/Butler.app"
  user node['current_user']
end
