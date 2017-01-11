set FISH_THEME_DIR (dirname (realpath (status -f)))
source $FISH_THEME_DIR/plugin-vcs/init.fish
source $FISH_THEME_DIR/plugin-vcs/functions/vcs.name.fish
source $FISH_THEME_DIR/plugin-vcs/functions/vcs.present.fish
init $FISH_THEME_DIR/plugin-vcs

function _get_color
  set mode 24bit
  if test $mode = 24bit
    switch $argv[1]
      case 003
        echo '808000'
      case 038
        echo '00afd7'
      case 081
        echo '5fd7ff'
      case 111
        echo '87afff'
      case 112
        echo '87d700'
      case 172
        echo 'd78700'
      case 202
        echo 'ff5f00'
      case 220
        echo 'ffd700'
      case 227
        echo 'ffff5f'
      case 243
        echo '767676'
      case 250
        echo 'bcbcbc'
    end
  else
    echo $argv[1]
  end
end

function _pwd_with_tilde
  echo $PWD | sed 's|^'$HOME'\(.*\)$|~\1|'
end

function _git_branch_name_or_revision
  set -l branch (git symbolic-ref HEAD ^ /dev/null | sed -e 's|^refs/heads/||')
  set -l revision (git rev-parse HEAD ^ /dev/null | cut -b 1-7)

  if test (count $branch) -gt 0
    echo $branch
  else
    echo $revision
  end
end

function _git_upstream_configured
  git rev-parse --abbrev-ref @"{u}" > /dev/null 2>&1
end

function _git_behind_upstream
  test (git rev-list --right-only --count HEAD...@"{u}" ^ /dev/null) -gt 0
end

function _git_ahead_of_upstream
  test (git rev-list --left-only --count HEAD...@"{u}" ^ /dev/null) -gt 0
end

function _git_upstream_status
  set -l arrows

  if _git_upstream_configured
    if _git_behind_upstream
      set arrows "$arrows⇣"
    end

    if _git_ahead_of_upstream
      set arrows "$arrows↑"
    end
  end

  if test "$arrows"
    echo "$arrows "
  end
end

function _print_in_color
  set -l string $argv[1]
  set -l color  $argv[2]

  set_color $color
  printf $string
  set_color normal
end

function _prompt_color_for_status
  if test $argv[1] -eq 0
    echo (_get_color 081)
  else
    echo red
  end
end

function _print_vcs_symbol -a vcs_name
  if test "$vcs_name" = 'git'
    _print_in_color "\n± " (_get_color 202)
    return
  end
  if test "$vcs_name" = 'svn'
    _print_in_color "\n☿ " (_get_color 220)
    return
  end
  if test "$vcs_name" = 'hg'
    _print_in_color "\n⑆ " (_get_color 111)
  end
end

function _print_virtual_env
  # Echoing the variable fixes an "test: Missing argument at index 2" issue
  if test (echo $VIRTUAL_ENV) != ''
    set -l base_virtualenv (basename $VIRTUAL_ENV)
    _print_in_color "(" (_get_color 003)
    _print_in_color $base_virtualenv (_get_color 038)
    _print_in_color ") " (_get_color 003)
  end
end

function fish_prompt
  set -l last_status $status
  set -l vcs_name (vcs.name)

  if test "$vcs_name" = ''
    printf "\n"
  end
  _print_vcs_symbol $vcs_name
  if test "$vcs_name" = 'git'
    set -l git_arrows (_git_upstream_status)
    if test $git_arrows
      _print_in_color $git_arrows (_get_color 220)
    end
  end
  _print_virtual_env
  # ~/...
  _print_in_color (_pwd_with_tilde) (_get_color 112)

  if test "$vcs_name" = 'git'
    _print_in_color " "(vcs.branch) (_get_color 172)
    set -l conflict (vcs.conflict)
    if test "$conflict"
      _print_in_color "|$conflict" (_get_color 172)
    end
    if test (vcs.stashed)
      _print_in_color "∃" yellow
    end
    if vcs.dirty
      _print_in_color "*" red
    end
    if vcs.staged
      _print_in_color "+" green
    end
  end

  # Not sure if $SSH_CONNECTION is set on a fish shell
  if test "$SSH_CONNECTION" != ''
    _print_in_color " >_" (_get_color 220)
    _print_in_color (whoami) (_get_color 081)
    printf "@"
    _print_in_color (hostname) (_get_color 220)
  else if test (command id -u $user) = 0
    _print_in_color " "(whoami) (_get_color 202)
    _print_in_color "@" (_get_color 250)
    switch (hostname)
      case "*local*"
        _print_in_color "local" (_get_color 220)
      case "*"
        _print_in_color (hostname) (_get_color 220)
    end
  end

  printf "\n"
  if test $last_status -ne 0
    _print_in_color "[$last_status] " white
  end
  _print_in_color "❯ " (_prompt_color_for_status $last_status)
end
