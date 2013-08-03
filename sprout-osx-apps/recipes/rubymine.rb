include_recipe "sprout-osx-apps::java"

dmg_package "RubyMine" do
  source "http://download.jetbrains.com/ruby/RubyMine-5.4.3.dmg"
  checksum "dd391ac16983e5ccd876ddd8ac1323b2eae40e69814ecf9ab34b005fecd623df"
  action :install
  owner node['current_user']
end
