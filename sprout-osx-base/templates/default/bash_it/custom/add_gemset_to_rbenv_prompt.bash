function rbenv_version_prompt {
  if which rbenv &> /dev/null; then
    rbenv=$(rbenv version-name) || return
    gemset=$(rbenv gemset active 2> /dev/null | sed 's% %+%')
    if [ -n "$gemset" ]; then
      rbenv="$rbenv@$gemset"
    fi
    echo -e "$RBENV_THEME_PROMPT_PREFIX$rbenv$RBENV_THEME_PROMPT_SUFFIX"
  fi
}
