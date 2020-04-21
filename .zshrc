export LC_ALL=en_GB.UTF-8  
export LANG=en_GB.UTF-8

# HISTORY
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=$HISTSIZE
HISTCONTROL=ignoredups:erasedups

export PATH="/usr/local/bin:$PATH"

# NVM
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# ASDF
. /usr/local/opt/asdf/asdf.sh

# Antibody
source <(antibody init)
antibody bundle < ~/.zsh_plugins.txt

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

export FZF_DEFAULT_COMMAND='rg --files'

eval `ssh-agent -s`

export PATH="$HOME/.cargo/bin:$PATH"

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/Library/Python/3.7/bin:$PATH"
export PATH="$HOME/dev/flutter/bin:$PATH"
# The following lines were added by compinstall
zstyle :compinstall filename '/Users/chrisdoc/.zshrc'

autoload -U +X bashcompinit && bashcompinit
autoload -U +X compinit && compinit

# End of lines added by compinstall
# fzf via Homebrew
if [ -e /usr/local/opt/fzf/shell/completion.zsh ]; then
    source /usr/local/opt/fzf/shell/key-bindings.zsh
    source /usr/local/opt/fzf/shell/completion.zsh
fi

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults;

# Add `killall` tab completion for common apps
complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter" killall;

eval "$(zoxide init zsh)"


export PATH="$HOME/go/bin:$PATH"

export FZF_DEFAULT_COMMAND='rg --files --hidden --follow'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"