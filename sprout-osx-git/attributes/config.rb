# When paging to less:
# * -x2 Tabs appear as two spaces
# * -S Chop long lines
# * -F Don't require interaction if paging less than a full screen
# * -X No scren clearing
# * -R Raw, i.e. don't escape the control characters that produce colored output

node.default['sprout']['git']['global_config'] = {
    'core.pager' => '"less -FXRS -x2"',
    'core.excludesfile' => "#{node['sprout']['home']}/.gitignore_global",
    'apply.whitespace' => 'nowarn',
    'color.branch' => 'auto',
    'color.diff' => 'auto',
    'color.interactive' => 'auto',
    'color.status' => 'auto',
    'color.ui' => 'auto',
    'branch.autosetupmerge' => 'true',
    'rebase.autosquash' => 'true',
    'push.default' => 'simple'
}
