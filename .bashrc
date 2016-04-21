# Bash shell configuration

# general
set   -o noclobber                      # overwrite proctection for redirects
shopt -s autocd                         # directory chancge  by typing only dir.
shopt -s cdspell                        # directory spelling correction
shopt -s globstar                       # recursive matching with **
stty  -ixon                             # scroll lock key maps disable (legacy)
#shopt -s checkwinsize                   # window size check after every command
#shopt -s hostcomplete                   # hostname completion
#source /etc/profile.d/vte.sh            # new terminals adopt current directory

# history
#HISTSIZE=5000                                 # commands saved in memory #
#HISTFILESIZE=20000                            # commands saved in history file
HISTCONTROL=erasedups                         # erase previous duplicates
shopt -s histappend                           # history appended not overwriten
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"  # history appended from session

# color variables
txtblk='\e[0;30m' ; txtred='\e[0;31m' ; txtgrn='\e[0;32m' ; txtylw='\e[0;33m'
txtblu='\e[0;34m' ; txtpur='\e[0;35m' ; txtcyn='\e[0;36m' ; txtwht='\e[0;37m'
txiblk='\e[0;90m' ; txired='\e[0;91m' ; txigrn='\e[0;92m' ; txiylw='\e[0;93m'
txiblu='\e[0;94m' ; txipur='\e[0;95m' ; txicyn='\e[0;96m' ; txiwht='\e[0;97m'
bldblk='\e[1;30m' ; bldred='\e[1;31m' ; bldgrn='\e[1;32m' ; bldylw='\e[1;33m'
bldblu='\e[1;34m' ; bldpur='\e[1;35m' ; bldcyn='\e[1;36m' ; bldwht='\e[1;37m'
bliblk='\e[1;90m' ; blired='\e[1;91m' ; bligrn='\e[1;92m' ; bliylw='\e[1;93m'
bliblu='\e[1;94m' ; blipur='\e[1;95m' ; blicyn='\e[1;96m' ; bliwht='\e[1;97m'
undblk='\e[4;30m' ; undred='\e[4;31m' ; undgrn='\e[4;32m' ; undylw='\e[4;33m'
undblu='\e[4;34m' ; undpur='\e[4;35m' ; undcyn='\e[4;36m' ; undwht='\e[4;37m'
uniblk='\e[4;90m' ; unired='\e[4;91m' ; unigrn='\e[4;92m' ; uniylw='\e[4;93m'
uniblu='\e[4;94m' ; unipur='\e[4;95m' ; unicyn='\e[4;96m' ; uniwht='\e[4;97m'
bckblk='\e[40m'   ; bckred='\e[41m'   ; bckgrn='\e[42m'   ; bckylw='\e[43m'
bckblu='\e[44m'   ; bckpur='\e[45m'   ; bckcyn='\e[46m'   ; bckwht='\e[47m'
bciblk='\e[100m'  ; bcired='\e[101m'  ; bcigrn='\e[102m'  ; bciylw='\e[103m'
bciblu='\e[104m'  ; bcipur='\e[105m'  ; bcicyn='\e[106m'  ; bciwht='\e[107m'
txtrst='\e[0m'    # Text Reset

# prompt
txtred='\e[0;31m' ; txtgrn='\e[0;32m' ; txtblu='\e[0;34m' ; txtpur='\e[0;35m'
txtrst='\e[0m'
if (( $EUID )); then
  PS1='\['$txtgrn'\]\u@\h \['$txtblu'\]\W\['$txtpur'\]$(__git_ps1 " (%s)")\[\e[0;37m\]:\['$txtrst'\] '
else
  PS1='\['$txtred'\]\u@\h \['$txtblu'\]\W\['$txtpur'\]$(__git_ps1 " (%s)")\[\e[0;37m\]:\['$txtrst'\] '
fi
#echo -ne '\e]12;#8DD35E\a'              # green cursor
#echo -ne '\e]12;#EEEEEE\a'              # 255 cursor

# colors
#eval $(dircolors -b)                        # coloring for ls and grep
alias grep='grep --color=auto'
export GREP_COLOR="1;35"                    # purple

if [[ ${TERM} == "xterm" ]]; then           # manpage colors with less pager
  export LESS_TERMCAP_mb=$'\e[1;31m'        # mode blinking     - unused?! (red)
  export LESS_TERMCAP_md=$'\e[01;38;5;12m'  # mode double-bright- primary  (blu)
  export LESS_TERMCAP_so=$'\e[01;38;5;08m'  # mode standout     - info/find(gry)
  export LESS_TERMCAP_us=$'\e[38;5;13m'     # underline start   - secondary(pur)
  export LESS_TERMCAP_me=$'\e[0m'           # mode end (reset: mb, md, so, us)
  export LESS_TERMCAP_se=$'\e[0m'           # standout-mode end
  export LESS_TERMCAP_ue=$'\e[0m'           # underline end
else
  export LESS_TERMCAP_mb=$'\e[01;31m'
  export LESS_TERMCAP_md=$'\e[01;34m'
  export LESS_TERMCAP_so=$'\e[01;30m'
  export LESS_TERMCAP_us=$'\e[01;35m'
  export LESS_TERMCAP_me=$'\e[0m'
  export LESS_TERMCAP_se=$'\e[0m'
  export LESS_TERMCAP_ue=$'\e[0m'
fi

# msys-git-bash
#PATH="/e/bin:/usr/local/bin:/usr/bin:/bin:/mingw32/bin:/usr/bin:/e/bin:/c/ProgramData/Oracle/Java/javapath:/c/Windows/system32:/c/Windows:/c/Windows/System32/Wbem:/c/Windows/System32/WindowsPowerShell/v1.0:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/mingw32/bin"
PATH="~/Development/general-scripts:"$PATH""
PATH="~/Development/arpa:"$PATH""
PATH="/c/Program Files (x86)/Mozilla Firefox/:"$PATH""
PATH="/c/Users/Public.SEVIERLIBRARY/AppData/Roaming/Inkscape/:"$PATH""
PATH=~/Downloads/Imagine/:"$PATH"
PATH=~/Downloads/KeePass/:"$PATH"
PATH=~/Downloads/Pickard/:"$PATH"
PATH=~/Downloads/notepad++/:"$PATH"
EXECIGNORE=*.dll:*inkscape.com:*.lnk:*.wcx:*.wlx
alias git="/usr/bin/git.exe"

# executable directory paths
scrpt_dir=~/.local/bin/                     # local script directory
PATH="$scrpt_dir:"$PATH""

# Aliases
alias cda="cd ~/.local/abs/"                         # directory shortcuts
alias cdb="cd $scrpt_dir"
alias cdd="cd ~/Desktop/"
alias cdt="cd ~/.local/share/Trash/files/"

alias ls="ls --color=auto --group-directories-first"
alias ls1="ls -1"                                    # list by line
alias lsd="ls -lAtrh"                                # list by date
alias lsl="ls -lAh"                                  # list by details, humanly
alias lss="ls -shAxSr"                               # list by size
alias lsx="ls -lAhX"                                 # list by extension

alias c="clear"                                      # other
alias chx="chmod +x"
alias cp="cp -ai"                                    # cp interactive if exists
alias iotop="sudo iotop"
alias mv="mv -ni"                                    # mv interactive if exists
alias rm="rm -i"                                     # remove interactively
alias rsync-backup="rsync -av --info=progress2 --human-readable"
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
  [ -f "$file" ] && source $file
done

# Functions
abacus    () { awk "BEGIN { print $* ; }" ; }
bat       () { echo "$(<"$@")" ; }
g         () { nohup gedit "$@" &> /dev/null & }
mountlist () { mount | awk '{ print $1" "$3" "$5" "$6 }' | sort -uV | \
                 column -t -o " " ; }
pb        () { if curl -Is https://www.archlinux.org -o /tmp/url-head; then
                 echo "Network is connected."
               else
                 echo "Network unavailable."
               fi ; }
treeview  () { if [ $# -gt 0 ]; then
                 dir=$(realpath "$1")
               else
                 dir=$(realpath $PWD)
               fi
               tree -C -a "$dir" | less -R ; }

# ssh-agent auto-launch (0 = agent running with key; 1 = w/o key; 2 = not run.)
agent_run_state=$(ssh-add -l >| /dev/null 2>&1 ; echo $?)
if   [ $agent_run_state = 2 ]; then
  eval $(ssh-agent -s)
  ssh-add "$HOME"/.ssh/id_rsa
elif [ $agent_run_state = 1 ]; then
  ssh-add "$HOME"/.ssh/id_rsa
fi

# vim:set tabstop=2 shiftwidth=2 expandtab
