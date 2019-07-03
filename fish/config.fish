fish_vi_key_bindings

function fish_mode_prompt
end

function fish_greeting
end

function fish_prompt
  set_color cyan
  printf "%s" "$USER"
  set_color normal
  printf " using fish at %s in " $hostname
  set_color blue
  printf "%s" "$PWD"
  set -l git_branch (git branch ^/dev/null | sed -n '/\* /s///p')
  if test -n "$git_branch"
    set_color normal
    printf " on "
    set_color yellow
    printf "%s" "$git_branch"
  end
  set_color red
  printf "\f\r\$ "
end
