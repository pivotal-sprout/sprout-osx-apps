dmg_package "SourceTree" do
  volumes_dir "SourceTree"
  source "http://downloads.atlassian.com/software/sourcetree/SourceTree_1.8.1.dmg"
  checksum "37a42f2d83940cc7e1fbd573a70c3c74a44134c956ac3305f6b153935dc01b80"
  action :install
  owner node['current_user']
end
