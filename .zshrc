# +--------------------------------------------------------------+
# | .zshrc - Daisuke_Aramaki                                     |
# | Last Modified: Thu June 25 2009 01.10 JST                    |
# | Based on hewbert's config                                    |
# +--------------------------------------------------------------+

# Language/Locale stuff
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'
export LC_CTYPE=C

#TimeZone
export TZ=Asia/Tokyo

# -----/ aliases /-----
alias rm='rm'    # Interactively
alias mv='mv'    # Interactively
alias cp='cp'    # Interactively

alias lsd='ls -dlf */'  # List directories
alias ll='ls -l'        # Detailed list
alias l='ls -laF'       # Detailed List
alias cd..='cd ..'      # Parent directory

# Set an alias for `ls`
case `uname` in
	FreeBSD)
		alias ls='ls -GF'
	;;
	NetBSD)
		alias ls='ls -F'
	;;
	OpenBSD)
		alias ls='ls -F'
	;;
	Linux)
		alias ls='ls --color=always -F'
	;;
esac

# ---------------------

# -----/ Some colors /-----
export red=$'%{\e[0;31m%}'
export RED=$'%{\e[1;31m%}'
export green=$'%{\e[0;32m%}'
export GREEN=$'%{\e[1;32m%}'
export blue=$'%{\e[0;34m%}'
export BLUE=$'%{\e[1;34m%}'
export purple=$'%{\e[0;35m%}'
export PURPLE=$'%{\e[1;35m}'
export cyan=$'%{\e[0;36m%}'
export CYAN=$'%{\e[1;36m}'
export WHITE=$'%{\e[1;37m}'
export white=$'%{\e[0;37m}'
export NC=$'%{\e[0m%}' 
export yellow=$'%{\e[0;33m%}'

# -----/ default pager /-----
#if [ -e `which most` ]; then
#	export PAGER="most"
#fi

	

# autoloads 
autoload -U compinit
compinit

autoload -U colors
colors

## color completion
zmodload -i zsh/complist

# -----/ default prompt /-----
PROMPT='${blue}%n${NC}@${green}%m${red} %~ ${yellow}%%${NC} '

# -----/ right prompt /-----
RPROMPT='${blue}<${NC}%T${blue}>${NC}'

# -----/ server prompts /-----
case `hostname` in
	banana*)
		PROMPT='${blue}%n${NC}@${purple}%m${red} %~ ${yellow}%%${NC} '
		
		case `whoami` in
			root)
				PROMPT='${yellow}%n${NC}@${purple}%m ${red}%~ ${yellow}%%${NC} '
			;;
		esac
	;;
esac

# ----------------------------



# history settings
HISTFILE=~/.zshhistory
HISTSIZE=3000
SAVEHIST=3000

# Other misc settings
LISTMAX=0

# Make home, insert, delete and end work on PCs basically 
# like in doskey. This may or may not work for you... the 
# \e is the ESC character. To set this up for your favourite 
# system, type cat > rubbish, press the keys of interest, 
# then enter here what you see. You should replace ^[ 
# (escape) with \e.

case $TERM in
	 *xterm*|(u)rxvt|(u|dt|k|E)term)
		bindkey '\e[1~' beginning-of-line
		bindkey '\e[3~' delete-char
		bindkey '\e[4~' end-of-line
		bindkey '\177' backward-delete-char
		bindkey '\e[2~' overwrite-mode
																		                          
		bindkey "\e[7~" beginning-of-line
		bindkey "\e[H" beginning-of-line
		#bindkey "\e[2~" transpose-words
		bindkey "\e[8~" end-of-line
		bindkey "\e[F" end-of-line
	;;

esac

# ---------------------------------------------------------------------------------------------------

# Auto-rehashing.  Try command completion, if fails, rehash
function compctl_rehash { rehash; reply=() }
compctl -C -c + -K compctl_rehash + -c

# --------/ Completion stuff /--------

# ls settings (this is used for completion stuff)
export LS_COLORS='no=00:fi=00:di=01;33:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jpg=01;35:*.png=01;35:*.gif=01;35:*.bmp=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.png=01;35:*.mpg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:';

zstyle ':completion:*:scp:*' group-order \
	users files all-files hosts-domain hosts-host hosts-ipaddr

zstyle ':completion:*:(ssh|scp):*:hosts-host' ignored-patterns \
        '*.*' loopback localhost
zstyle ':completion:*:(ssh|scp):*:hosts-domain' ignored-patterns \
        '<->.<->.<->.<->' '^*.*' '*@*'
zstyle ':completion:*:(ssh|scp):*:hosts-ipaddr' ignored-patterns \
        '^<->.<->.<->.<->' '127.0.0.<->'
#zstyle ':completion:*:(ssh|scp):*:users' ignored-patterns \
#        adm bin daemon halt lp named shutdown sync
zstyle -e ':completion:*:(ssh|scp):*' hosts 'reply=(
        ${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) \
                        /dev/null)"}%%[# ]*}//,/ }
        )'



# Expansion options
zstyle ':completion:*' completer _complete _prefix
zstyle ':completion::prefix-1:*' completer _complete
zstyle ':completion:incremental:*' completer _complete _correct
zstyle ':completion:predict:*' completer _complete

# Completion caching
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path ~/.zsh/cache/$HOST

# Expand partial paths
zstyle ':completion:*' expand 'yes'
zstyle ':completion:*' squeeze-slashes 'yes'

# Include non-hidden directories in globbed file completions
# for certain commands

zstyle ':completion::complete:*' '\'

#  tag-order 'globbed-files directories' all-files 
zstyle ':completion::complete:*:tar:directories' file-patterns '*~.*(-/)'

# Don't complete backup files as executables
zstyle ':completion:*:complete:-command-::commands' ignored-patterns '*\~'

# Separate matches into groups
zstyle ':completion:*:matches' group 'yes'

# Describe each match group.
zstyle ':completion:*:descriptions' format "%B---- %d%b"

# Messages/warnings format
zstyle ':completion:*:messages' format '%B%U---- %d%u%b' 
zstyle ':completion:*:warnings' format '%B%U---- no match for: %d%u%b'
 
# Describe options in full
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'

# }}}
# {{{ Simulate my old dabbrev-expand 3.0.5 patch 

zstyle ':completion:*:history-words' stop verbose
zstyle ':completion:*:history-words' remove-all-dups yes
zstyle ':completion:*:history-words' list false

zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

compctl -g "*.tar *.tgz *.tz *.tar.Z *.tar.bz2 *.tZ *.tar.gz" \
	+ -g "*(-/) .*(-/)" tar

compctl -H 0 '' -k hosts telnet ftp ssh host nslookup rup rusers
compctl -g "*(-/) .*(-/)" cd rmdir


## display fancy terminal title
case $TERM in
	*xterm*|(u)rxvt|(u|dt|k|E)term)
	## display user@host and full dir in *term title
	precmd () {
		print -Pn  "\033]0;%n@%m: %~ (%l)\007"
		#print -Pn "\033]0;%n@%m%#  %~ %l  %w :: %T\a" ## or use this
		}
	## display user@host and name of current process in *term title
	preexec () {
		print -Pn "\033]0;%n@%m <$1> %~ (%l)\007"
		#print -Pn "\033]0;%n@%m%#  <$1>  %~ %l  %w :: %T\a" ## or use this
		}
	;;
esac

# zsh Options

setopt                       \
     NO_all_export           \
        always_last_prompt   \
     NO_always_to_end        \
        append_history       \
     NO_auto_cd              \
        auto_list            \
        auto_menu            \
     NO_auto_name_dirs       \
        auto_param_keys      \
        auto_param_slash     \
        auto_pushd           \
        auto_remove_slash    \
     NO_auto_resume          \
        bad_pattern          \
        bang_hist            \
     NO_beep                 \
        brace_ccl            \
        correct_all          \
     NO_bsd_echo             \
        cdable_vars          \
     NO_chase_links          \
     NO_clobber              \
        complete_aliases     \
        complete_in_word     \
     correct                 \
     NO_correct_all          \
        csh_junkie_history   \
     NO_csh_junkie_loops     \
     NO_csh_junkie_quotes    \
     NO_csh_null_glob        \
        equals               \
        extended_glob        \
        extended_history     \
        function_argzero     \
        glob                 \
     NO_glob_assign          \
        glob_complete        \
     NO_glob_dots            \
        glob_subst           \
        hash_cmds            \
        hash_dirs            \
        hash_list_all        \
        hist_allow_clobber   \
        hist_beep            \
        hist_ignore_dups     \
        hist_ignore_space    \
     NO_hist_no_store        \
        hist_verify          \
     NO_hup                  \
     NO_ignore_braces        \
     NO_ignore_eof           \
        interactive_comments \
	inc_append_history   \
     NO_list_ambiguous       \
     NO_list_beep            \
        list_types           \
        long_list_jobs       \
        magic_equal_subst    \
     NO_mail_warning         \
     NO_mark_dirs            \
     NO_menu_complete        \
        multios              \
        nomatch              \
        notify               \
     NO_null_glob            \
        numeric_glob_sort    \
     NO_overstrike           \
        path_dirs            \
        posix_builtins       \
     NO_print_exit_value     \
     NO_prompt_cr            \
        prompt_subst         \
        pushd_ignore_dups    \
     NO_pushd_minus          \
        pushd_silent         \
        pushd_to_home        \
        rc_expand_param      \
     NO_rc_quotes            \
     NO_rm_star_silent       \
     NO_sh_file_expansion    \
        sh_option_letters    \
        short_loops          \
     NO_sh_word_split        \
     NO_single_line_zle      \
     NO_sun_keyboard_hack    \
        unset                \
     NO_verbose              \
        zle


