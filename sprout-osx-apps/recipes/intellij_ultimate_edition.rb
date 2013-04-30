intellij_version = "12.1.2"
dmg_package "IntelliJ IDEA 10" do
  source "http://download.jetbrains.com/idea/ideaIU-#{intellij_version}.dmg"
  checksum "75d981489c52e2af8a015186fbd94cb6c72684622c35d4b6ef91f8e929f2ee77"
  owner WS_USER
  action :install
end
