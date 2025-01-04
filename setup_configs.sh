#!/bin/bash

# Kodên rengan
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # Bê reng

# Fonksiyon: Bernameya sazkirî kontrol bike
check_installed() {
    if pacman -Qi "$1" &> /dev/null; then
        echo -e "${GREEN}✓ $1 jixwe sazkirî ye${NC}"
        return 0
    else
        echo -e "${RED}✗ $1 ne sazkirî ye${NC}"
        return 1
    fi
}

# Fonksiyon: Bernameyê saz bike
install_package() {
    echo -e "${YELLOW}$1 tê sazkirin...${NC}"
    sudo pacman -S --noconfirm "$1"
}

echo "Bernameyên pêwîst tên kontrolkirin..."

# Kontrola Zsh û sazkirin
if ! check_installed "zsh"; then
    install_package "zsh"
fi

# Kontrola Alacritty û sazkirin
if ! check_installed "alacritty"; then
    install_package "alacritty"
fi

# Kontrola Neovim û sazkirin
if ! check_installed "neovim"; then
    install_package "neovim"
fi

# Kontrola Neovide û sazkirin
if ! check_installed "neovide"; then
    install_package "neovide"
fi

# Sazkirina NvChad
NVCHAD_DIR="$HOME/.config/nvim"
if [ ! -d "$NVCHAD_DIR" ]; then
    echo -e "${YELLOW}NvChad tê sazkirin...${NC}"
    # Pêşî pelrêça nvim a heyî backup bike (heke hebe)
    [ -d "$NVCHAD_DIR" ] && mv "$NVCHAD_DIR" "$NVCHAD_DIR.backup"
    git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
    echo -e "${GREEN}NvChad hat sazkirin${NC}"
fi

echo -e "${YELLOW}Pelên mîheng tên barkirin...${NC}"

# Pelrêça script bigire
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SOURCE_DIR="$SCRIPT_DIR/all_configs"
CONFIG_DIR="$HOME/.config"

# Pelrêçên pêwîst çêke
mkdir -p "$CONFIG_DIR/alacritty"
mkdir -p "$CONFIG_DIR/nvim"

# Mîhenga Alacritty
if [ -f "$SOURCE_DIR/alacritty.toml" ]; then
    cp "$SOURCE_DIR/alacritty.toml" "$CONFIG_DIR/alacritty/alacritty.toml"
    echo -e "${GREEN}Pela mîhenga Alacritty hat kopîkirin${NC}"
else
    echo -e "${RED}Çewtî: alacritty.toml nehat dîtin${NC}"
fi

# Mîhenga Zsh
if [ -f "$SOURCE_DIR/.zshrc" ]; then
    cp "$SOURCE_DIR/.zshrc" "$HOME/.zshrc"
    echo -e "${GREEN}Pela mîhenga Zsh hat kopîkirin${NC}"
    source "$HOME/.zshrc" 2>/dev/null || echo -e "${YELLOW}Ji bo sepandina mîhenga nû ya zsh, terminal ji nû ve veke${NC}"
else
    echo -e "${RED}Çewtî: .zshrc nehat dîtin${NC}"
fi

# Mîhenga Nvim
if [ -d "$SOURCE_DIR/nvim" ]; then
    # Heke pelrêça nvim a armanc hebe, jê bibe
    [ -d "$CONFIG_DIR/nvim" ] && rm -rf "$CONFIG_DIR/nvim"
    # Pelrêça Nvim kopî bike
    cp -r "$SOURCE_DIR/nvim" "$CONFIG_DIR/nvim"
    echo -e "${GREEN}Pelrêça Nvim hat kopîkirin${NC}"
else
    echo -e "${RED}Çewtî: pelrêça nvim nehat dîtin${NC}"
fi

echo -e "${GREEN}Pêvajo qediya!${NC}"

# Zsh bike qabika standard
if [ "$SHELL" != "/usr/bin/zsh" ]; then
    echo -e "${YELLOW}Zsh wek qabika standard tê mîhengkirin...${NC}"
    chsh -s /usr/bin/zsh
    echo -e "${GREEN}Zsh bû qabika standard${NC}"
    echo -e "${YELLOW}Ji bo ku guhertin bibim çalak, ji kerema xwe komputera xwe ji nû ve veke${NC}"
fi 