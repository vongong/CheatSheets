## .bash_profile
```sh
if [ -s ~/.bashrc ]; then
  . ~/.bashrc
fi
```

## .bashrc
```sh
export GREP_OPTIONS='--color=always'

if [ -s ~/dotfiles/alias_list.sh ]; then
  . ~/dotfiles/alias_list.sh
fi
```

## alias_list.sh
```sh
alias clr="clear"
alias cd..="cd .."
alias ..="cd .."
alias ~="cd ~"
alias ls="ls -Fa"
alias ll="ls -Fal"
```