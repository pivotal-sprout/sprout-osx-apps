dmg_package "LibreOffice" do
  volumes_dir "LibreOffice"
  source "http://download.documentfoundation.org/libreoffice/stable/4.0.3/mac/x86/LibreOffice_4.0.3_MacOS_x86.dmg"
  checksum "11eab948d4982340ef92ec46d3bb247c087cf7d831bd1c0c6ffcfb3b6bfd28d2"
  owner node['current_user']
  action :install
end
