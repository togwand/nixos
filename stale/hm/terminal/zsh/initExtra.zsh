# Default options to false
unsetopt HIST_FCNTL_LOCK
unsetopt HIST_IGNORE_DUPS
unsetopt HIST_IGNORE_SPACE
unsetopt SHARE_HISTORY
# Active options
setopt autolist
setopt listambiguous
setopt listpacked
setopt listrowsfirst
setopt globdots
setopt histexpiredupsfirst
setopt histfcntllock
setopt histfindnodups
setopt histignorespace
setopt histreduceblanks
setopt incappendhistory
# Custom prompts
export PROMPT='%n:'
export RPROMPT='%0~ %t'
