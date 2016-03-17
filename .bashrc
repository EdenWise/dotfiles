# Bash shell configuration

# General settings
shopt -s autocd                         # directory change by entering only dir.
shopt -s cdspell                        # directory misspelling correction
#shopt -s checkwinsize                   # window size check after every command
#shopt -s hostcomplete                   # hostname completion
#source /etc/profile.d/vte.sh            # new terminals adopt current directory
set -o noclobber                        # redirect overwrite prevention

# History: http://git.io/Y18IYA
#HISTSIZE=5000
#HISTFILESIZE=20000
#HISTCONTROL=erasedups
#shopt -s histappend
#PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# Prompt
txtblk='\e[0;30m'; txtred='\e[0;31m'    # colored text variables
txtgrn='\e[0;32m'; txtblu='\e[0;34m'
txtpur='\e[0;35m'; txtrst='\e[0m'
usernm="\[$txtgrn\]\u@\[$txtrst\]"      # username
hostnm="\[$txtgrn\]\h\[$txtrst\]"       # hostname
#msystm="\[$txtpur\]$MSYSTEM\[$txtrst\]" # mysysgit variable
folder="\[$txtblu\]\W\[$txtrst\]"       # directory
gitvar="\[$txtpur\]`__git_ps1`\[$txtrst\]"
prompt="\[$txtblk\]:\[$txtrst\]"        # prompt character
if [ $EUID = 0 ]; then
  usernm=""
  hostnm="\[$txtred\]\h\[$txtrst\]"
fi
#PS1="${usernm}${hostnm} ${folder}`__git_ps1`${prompt} "
#PS1="$txtgrn\u@\h$txtrst $txtblu\W$txtrst$(__git_ps1 " (%s)")$txtrst\$ "
PS1='\['$txtgrn'\]\u@\h \['$txtblu'\]\W\['$txtpur'\]$(__git_ps1 " (%s)")\[\e[0;37m\]:\['$txtrst'\] '

#echo -ne '\e]12;#8DD35E\a'              # green cursor
#echo -ne '\e]12;#EEEEEE\a'              # 255 cursor

# Colors
#eval $(dircolors -b)                        # coloring for ls and grep
#alias grep='grep --color=auto'
#export GREP_COLOR="1;35"                    # purple

#if [[ ${TERM} == "xterm" ]]; then           # manpage colors with less pager
#  export LESS_TERMCAP_mb=$'\e[1;31m'        # mode blinking     - unused?! (red)
#  export LESS_TERMCAP_md=$'\e[01;38;5;12m'  # mode double-bright- primary  (blu)
#  export LESS_TERMCAP_so=$'\e[01;38;5;08m'  # mode standout     - info/find(gry)
#  export LESS_TERMCAP_us=$'\e[38;5;13m'     # underline start   - secondary(pur)
#  export LESS_TERMCAP_me=$'\e[0m'           # mode end (reset: mb, md, so, us)
#  export LESS_TERMCAP_se=$'\e[0m'           # standout-mode end
##  export LESS_TERMCAP_ue=$'\e[0m'           # underline end
#else
#  export LESS_TERMCAP_mb=$'\e[01;31m'
#  export LESS_TERMCAP_md=$'\e[01;34m'
#  export LESS_TERMCAP_so=$'\e[01;30m'
#  export LESS_TERMCAP_us=$'\e[01;35m'
#  export LESS_TERMCAP_me=$'\e[0m'
#  export LESS_TERMCAP_se=$'\e[0m'
#  export LESS_TERMCAP_ue=$'\e[0m'
#fi

# Executable paths
scrpt_dir=$HOME/.local/bin                           # local script directory
export PATH="$scrpt_dir:~/Development/general-scripts:$PATH"
export PATH="~/Downloads/7-zip_9.2/:$PATH 7za.exe"
export PATH="~/Downloads/7-zip_15.12/:$PATH 7z.exe 7z.dll"
export PATH="~/Downloads/Inkscape/:$PATH inkscape.exe"
export PATH="~/Downloads/KeePass/:$PATH KeePass.exe"
export PATH="~/Downloads/vlc-2.2.1/:$PATH vlc.exe"
export PATH="~/Downloads/:$PATH Pickard.exe windirstat.exe"
export PATH="~/Development/genscripts:$PATH"

# Aliases
alias ls="ls --color=auto --group-directories-first" # Lists
alias ls1="ls -1"                                    # sort by line
alias lsd="ls -lAtrh"                                # sort by date
alias lsl="ls -lAh"                                  # long list, human-readable
alias lss="ls -shAxSr"                               # sort by size
alias lsx="ls -lAhX"                                 # sort by extension

alias cda="cd ~/.local/abs/"                         # Directory shortcuts
alias cdb="cd $scrpt_dir"
alias cdd="cd ~/Desktop/"
alias cdt="cd ~/.local/share/Trash/files/"

alias c="clear"                                      # Other
alias chx="chmod +x"
alias cp="cp -ai"                                    # cp interactive if exists
alias iotop="sudo iotop"
alias mv="mv -ni"                                    # mv interactive if exists
alias rm="rm -i"                                     # remove interactively
alias tarlist="tar -tvf"                             # archive list contents
alias v="vim"
alias vi="vim"
alias vim="vim -p"
alias sv="sudo vim -p"

# Command completion
complete -cf bgcmd
complete -W "`awk '{ print $2 }' /etc/hosts`" ssh
complete -cf sudo

bashcompfiles=(/usr/share/bash-completion/completions/burp
               /usr/share/bash-completion/completions/dkms
               /usr/share/bash-completion/completions/systemctl
               /usr/share/doc/pkgfile/command-not-found.bash)
               #/usr/share/git/completion/git-completion.bash)
for file in ${bashcompfiles[@]}; do
  [ -f "$file" ] && source "$file"
done

# Functions
abacus    () { awk "BEGIN { print $* ; }" ; }
g         () { nohup gedit "$@" &> /dev/null & }
mountlist () { mount | awk '{ print $1" "$3" "$5" "$6 }' | sort -uV | \
                 column -t -o " " ; }
pb        () { if curl -Is https://www.archlinux.org -o /tmp/url-head; then
                 echo "Network is connected."
               else
                 echo "Network unavailable."
               fi ; }
treeless  () { if [ $# -gt 0 ]; then
                 dir=$(realpath "$1")
               else
                 dir=$(realpath $PWD)
               fi
               tree -C -a "$dir" | less -R ; }

# SSH agent auto-launch
# 0 = agent running with key; 1 = agent running w/o key; 2 = agent not running
agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)
if   [ $agent_run_state = 2 ]; then
  eval $(ssh-agent -s)
  ssh-add
elif [ $agent_run_state = 1 ]; then
  ssh-add
fi

# vim:set tabstop=2 shiftwidth=2 expandtab:
