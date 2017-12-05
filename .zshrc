source ~/.zplug/init.zsh

zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "rhysd/zsh-bundle-exec", from:github
zplug "mafredri/zsh-async", from:github, defer:0  # Load this first
zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme

export PATH="$HOME/.rbenv/shims:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init - zsh)"

alias g='git'
alias dc='docker-compose'

zplug load

# pecoとghqでリポジトリに飛ぶ
function peco-src() {
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src
bindkey '^]' peco-src

if [ -d ${HOME}/.zsh/zsh-completions/src ] ; then
  fpath=(${HOME}/.zsh/zsh-completions/src $fpath)
  compinit
fi
