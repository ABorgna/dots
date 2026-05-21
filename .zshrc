
# Aliases, reuse the ones from bash_alias
source ~/.bash_alias

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# LLVM 14
export LLVM_SYS_140_PREFIX=/opt/homebrew/opt/llvm@14
export PATH="/opt/homebrew/opt/llvm@14/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/llvm@14/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm@14/include"
# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/aborgna/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions
