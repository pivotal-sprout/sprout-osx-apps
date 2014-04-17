package "git"

sprout_osx_base_bash_it_custom_plugin "git-export_editor.bash"
git_global_config = node['sprout']['git']['global_config']

template "#{node['sprout']['home']}/.gitignore_global" do
  source "gitignore_global.erb"
  owner node['current_user']
  variables(:ignore_idea => node[:git_global_ignore_idea])
end

aliases =<<EOF
st status
di diff
co checkout
ci commit
br branch
sta stash
llog \"log --date=local\"
flog \"log --pretty=fuller --decorate\"
lg \"log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative\"
lol \"log --graph --decorate --oneline\"
lola \"log --graph --decorate --oneline --all\"
blog \"log origin/master... --left-right\"
ds \"diff --staged\"
fixup \"commit --fixup\"
squash \"commit --squash\"
unstage \"reset HEAD\"
rum \"rebase master@{u}\"
EOF

aliases.split("\n").each do |alias_string|
  abbrev = alias_string.split[0]
  execute "set alias #{abbrev}" do
    command "git config --global alias.#{alias_string}"
    user node['current_user']
    only_if "[ -z `git config --global alias.#{abbrev}` ]"
  end
end

git_global_config.each_pair do |setting, value|
  execute "set git config setting #{setting}" do
    command "git config --global #{setting} #{value}"
    user node['current_user']
  end
end