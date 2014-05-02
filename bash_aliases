# ls aliases
alias ll='ls -lA'
alias lll='ls -lAhS'

# misc commands
alias top='top -s1 -o cpu -R -F'
alias psg='ps aux | grep -v "grep" | grep -i'
alias vinginx='sudo mvim /usr/local/etc/nginx/nginx.conf'
## git
alias gits="git status --short --branch"
alias gitd="git diff"
alias gitll="git log --graph --pretty=format:\"%C(yellow)commit %h %Cred%cr %Cgreen%an%n      %Creset %s%n\""
alias gitl="gitll -n10"
alias gg="git grep --color"

## cd
alias cdd="cd ~/dev/"
alias cdr="cd ~/dev/ruby"
alias cdj="cd ~/dev/js"
alias cdi="cd ~/dev/ios"
alias yy="cd ~/dev/yahoo"
alias cdy="yy"
alias cdm="cd ~/dev/yahoo/mep"
alias cdl="cd ~/dev/yahoo/leftfield"

# dev
alias vi="mvim"
alias be='bundle exec'
alias br='bundle exec rspec'
alias r='bundle exec rails'
alias scone="bundle exec rails console"
alias rrg="rake routes | grep"

# Deploy and restart
capdep () {
  local env=$1
  if [[ $env == "production" ]]; then
    cap production deploy
  else
    cap deploy
    cap unicorn:stop
    cap unicorn:start
  fi
  echo $env
}

# Open XCode project
openx () {
  local x=$(ls -d *.xcodeproj 2> /dev/null | head -n1)
  if [[ $x != "" ]]; then
    open $x
  else
    echo "not XCode project"
  fi
}
