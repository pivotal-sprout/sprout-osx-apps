dmg_package "TrueCrypt 7.1a" do
  source 'http://www.truecrypt.org/download/TrueCrypt%207.1a%20Mac%20OS%20X.dmg'
  checksum '04db58b737c05bb6b0b83f1cb37a29edec844b59ff223b9e213ee1f4e287f586'
  type 'mpkg'
  accept_eula true
  package_id 'org.TrueCryptFoundation.TrueCrypt' # mpkg also installs: com.github.osxfuse.pkg.Core, com.google.macfuse.core
  action :install
  owner node['current_user']
end
