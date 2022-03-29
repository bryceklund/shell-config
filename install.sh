# 1. Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# 2. Install plugins
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# 3. Copy theme to the oh-my-zsh theme directory
cp solus.zsh-theme $ZSH_CUSTOM/themes/

# 3. Copy over .zshrc
cp zsh/.zshrc ~/

# 4. Set zsh as the default shell
chsh -s $(which zsh)

# 5. Source .zshrc
. ~/.zshrc
