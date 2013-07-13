dmg_package "GPGTools" do
  source 'https://s3.amazonaws.com/gpgtools/GPGTools-2013.5.20.dmg'
  checksum '032780e5fc4712410acd8d122aa833134ab4c87eb37b5c735e9f623f0720d387'
  type 'pkg'
  package_id 'org.gpgtools.*'
  action :install
  owner node['current_user']
end
