intellij_version = "12.1.2"
dmg_package "IntelliJ IDEA 12 CE" do
  source "http://download.jetbrains.com/idea/ideaIC-#{intellij_version}.dmg"
  checksum "2438958ae3f5d553b009fd8a9382374974eb92ad69b32cecb2e9d9c206da1e95"
  owner WS_USER
  action :install
end
