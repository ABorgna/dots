export PATH="$HOME/bin:/usr/local/bin:/Users/agustinborgna/.local/bin:$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin:$PATH"

# Alias definitions, in common with bash config
if [ -f ~/.bash_aliases ]; then
  source ~/.bash_aliases
fi

#setopt PROMPT_SUBST
#PROMPT="${PWD/#$HOME/~} >"

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
