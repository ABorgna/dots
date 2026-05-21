if status is-interactive
    # Commands to run in interactive sessions can go here
end


# Add gnu coreutils to PATH
fish_add_path /opt/homebrew/opt/coreutils/libexec/gnubin
fish_add_path /Users/aborgna/.local/bin

fish_add_path ~/bin

source ~/.bash_alias

# Use LLVM14 installed by homebrew
set -x LLVM_SYS_140_PREFIX (brew --prefix llvm@14)
set -x LLVM_SYS_211_PREFIX (brew --prefix llvm@21)

set all_repos quantinuum/hugr quantinuum/tket2 quantinuum/guppylang unitaryfoundation/jeff
function all_prs
    clear
    for repo in $all_repos
        gh pr status -R $repo
    end
end

function loadenv
    for line in (cat .env | grep -v '^#' | grep -v '^$')
        set -xg (echo $line | cut -d '=' -f 1) (echo $line | cut -d '=' -f 2-)
    end
end

