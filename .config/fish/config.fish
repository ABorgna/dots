if status is-interactive
    # Commands to run in interactive sessions can go here
end


# Add gnu coreutils to PATH
fish_add_path /opt/homebrew/opt/coreutils/libexec/gnubin

source ~/.bash_alias

# Use LLVM14 installed by homebrew
set -x LLVM_SYS_140_PREFIX (brew --prefix llvm@14)