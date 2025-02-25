# ~/.bashrc

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# append to the history file, don't overwrite it
shopt -s histappend

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth
HISTTIMEFORMAT="%F %T "

# To set the number of lines in active history and to set the number of lines saved in Bash history
HISTSIZE=2000
HISTFILESIZE=2000

# navigation
up () {
  local d=""
  local limit="$1"

  # Default to limit of 1
  if [ -z "$limit" ] || [ "$limit" -le 0 ]; then
    limit=1
  fi

  for ((i=1;i<=limit;i++)); do
    d="../$d"
  done

  # perform cd. Show error if cd fails
  if ! cd "$d"; then
    echo "Couldn't go up $limit dirs.";
  fi
}

### ARCHIVE EXTRACTION
# usage: ex <file>
ex (){
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   unzstd $1    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# if a tmux session exists then attach to that or create a new one
tx() {
  if ! command -v tmux >/dev/null 2>&1; then
    echo "tmux is not installed."
    return 1
  fi

  if [ -n "$TMUX" ]; then
    echo "Already inside a tmux session."
    return 0
  fi

  if tmux has-session 2>/dev/null; then
    tmux attach-session
  else
    tmux new-session
  fi
}

### BASH ALIASES
alias ls='lsd'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'

alias rs='exec $0'
alias h='history'
alias c='clear'
alias grep='grep --color=auto'

### GIT ALIASES
alias gl='git log --pretty=format:"%C(yellow)%h\\ %ad%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --date=short'
alias gb='git branch'
alias gr='git remote'
alias gc='git clone'
alias gs='git status'
alias gw='git worktree'
alias gm='git merge'
alias gf='git fetch'
alias gck='git checkout'
alias gsw='git switch'
alias gpl='git pull'

### NPM ALIASES
alias nit='npm init'
alias ni='npm install'
alias nu='npm uninstall'
alias nr='npm run'

### YARN ALIASES
alias yit='yarn init'
alias yi='yarn install'
alias ya='yarn add'
alias yr='yarn remove'

### CARGO ALIASES
alias cn='cargo new'
alias cr='cargo run'
alias ct='cargo test'
alias cb='cargo build'

# cargo watch must be installed
alias cw='cargo watch -x run'

# RUN FADE SCRIPT
sh ~/fade

### SETTING THE STARSHIP PROMPT 
eval "$(starship init bash)"
