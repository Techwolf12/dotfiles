if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        echoti smkx
    }
    function zle-line-finish () {
        echoti rmkx
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi

setopt prompt_subst
autoload -U colors && colors

function calcula_ancho {
    temp=" ${USER} _ ${HOST} _  _"
    dir_actual=$PWD

    if [[ "$dir_actual[0,${#HOME}]" == "$HOME" ]]
    then
        dir_actual="~$dir_actual[$((${#HOME}+1)),-1]"
    fi

    let restante=${COLUMNS}-${#temp}
    longitud_dir=${#dir_actual}
    if [[ "$longitud_dir" -gt "$restante" ]]
    then
        dir_actual="...${dir_actual:$(($longitud_dir-$restante+3))}"
    fi
}

function nivel_ranger {
if [ -z "$RANGER_LEVEL" ]
then
    string_nivel=""
else
    string_nivel=" ranger │"
fi

}

reload () {
    exec "${SHELL}" "$@"
}

case $TERM in
    termite|*xterm*|rxvt|rxvt-unicode|rxvt-256color|rxvt-unicode-256color|(dt|k|E)term)
        separador1=
        separador2=
        separador3=
        precmd () {
            print -Pn "\e]0;%n@%M: %1~ \a"
            calcula_ancho
        }
        preexec () {
            print -Pn "\e]0;%n@%M %1~ ($1)\a"
        }
        ;;
    screen|screen-256color)
        separador1=
        separador2=
        separador3=
        precmd () {
            print -Pn "\e]83;title \"$1\"\a"
            print -Pn "\e]0;TMUX - %n@%M %1~\a"
            calcula_ancho
        }
        preexec () {
            print -Pn "\e]83;title \"$1\"\a"
            print -Pn "\e]0;TMUX - %n@%M %# %1~ ($1)\a"
        }
        ;;
    *)
        separador1=▒
        separador2=│
        separador3=▒
        precmd () {
            calcula_ancho
        }
        ;;
esac

over_ssh() {
    if [ -n "${SSH_CLIENT}" ]; then
        return 0
    else
        return 1
    fi
}

if over_ssh; then
    prompt_is_ssh="%{%K{green}%B%F{black}%} SSH %{%b%K{cyan}%F{green}%}"
else
    prompt_is_ssh="%{%b%K{cyan}%F{green}%}"
fi


PROMPT='%{%B%K{blue}%15F%} %n %{%b%K{green}%F{blue}%}$separador1%{%B%15F%} %m %{%b%K{red}%F{green}%}$separador1%{%B%15F%} $dir_actual %{%b%k%F{red}%}$separador1
$prompt_is_ssh$separador1$nivel_ranger$separador1$separador1%{%K{red}%B%F{black}%} %#%(0?,, %{%b%K{red}%15F%}$separador2 %{%B%F{black}%}%?) %{%b%k%F{red}%}$separador1%{%b%k$reset_color%} '

RPROMPT='%{%F{red}%}$separador3%{%B%K{red}%F{black}%} %* %{%b%F{red}%}$separador1%{$reset_color%}'

