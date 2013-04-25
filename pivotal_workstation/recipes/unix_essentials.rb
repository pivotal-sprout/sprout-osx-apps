include_recipe "sprout-osx-apps::ack"
include_recipe "pivotal_workstation::tmux"
include_recipe "sprout-osx-apps::xquartz"

brew "watch"
brew "ssh-copy-id"
brew "pstree"
brew "tree"
brew "wget"
