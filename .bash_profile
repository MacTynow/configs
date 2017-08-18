NORMAL="\[\033[00m\]"
BLUE="\[\033[01;34m\]"
RED="\[\e[31m\]"
YELLOW="\[\e[33m\]"
GREEN="\[\e[32m\]"
LBLUE="\[\e[36m\]"
PS1_WORKDIR="\w"
PS1_HOSTNAME="\h"
PS1_USER="\u"

export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# source ~/git-completion.bash

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

alias switchkube="~/honestbee/switchkube"
alias grep="rg" 
eval $(thefuck --alias)
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

__kube_ps1()
{
    CONTEXT=$(kubectl config current-context)
    if [ -n "$CONTEXT" ]; then
        case "$CONTEXT" in
          *prod*)
            echo "${RED}⎈ ${CONTEXT}"
            ;;
          *staging*)
            echo "${YELLOW}⎈ ${CONTEXT}"
            ;;
          *)
            echo "${GREEN}⎈ ${CONTEXT}"
            ;;
        esac
    fi
}

export GITAWAREPROMPT=~/.bash/git-aware-prompt

export PROMPT_COMMAND='PS1="${LBLUE}${PS1_USER}\[\033[m\]@\[\033[32m\]\h\[\033[33;1m\]:\w\[\033[m\]\[$txtcyn\]\${git_branch}\[$txtred\]\${git_dirty}\[$txtrst\]$(__kube_ps1)${BLUE} $ ${NORMAL}"'

source "${GITAWAREPROMPT}/main.sh"

# Bash completion support
source /usr/local/etc/bash_completion

# Kubectl shell completion
source '/Users/honestbee/.kube/completion.bash.inc'

# git 
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi
