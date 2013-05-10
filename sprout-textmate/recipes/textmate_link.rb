link "/usr/local/bin/mate" do
  to "/Applications/TextMate.app/Contents/Resources/mate"
  owner node['current_user']
  only_if "test -d /usr/local/bin -a -w /usr/local/bin -a ! -e /usr/local/bin/mate"
end
