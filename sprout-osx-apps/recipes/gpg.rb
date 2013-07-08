if node["platform"] != "mac_os_x"
  package "gpg"
else
  brew "gpg"
end