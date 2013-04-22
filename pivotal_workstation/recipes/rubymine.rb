include_recipe "pivotal_workstation::java"

dmg_package "RubyMine" do
  source "http://download-ln.jetbrains.com/ruby/RubyMine-5.4.1.dmg"
  checksum "87d70c1ca11ecb292b6acc8075232cbf4e14bdacfac0f8931c6bc9ac09e05613"
  action :install
  owner WS_USER
end
