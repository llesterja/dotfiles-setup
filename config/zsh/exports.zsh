export EDITOR="cursor --wait"
export LANG="en_US.UTF-8"

export PATH="${DOTFILES:-$HOME/dotfiles}/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$(brew --prefix nvm)/nvm.sh" ] && source "$(brew --prefix nvm)/nvm.sh"

[[ -f "$DOTFILES/config/shell/dotnet-homebrew.sh" ]] && source "$DOTFILES/config/shell/dotnet-homebrew.sh"
