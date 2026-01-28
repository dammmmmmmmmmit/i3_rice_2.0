#!/bin/bash

# =========================================
# i3 OLED Themes Setup Script v2.0
# =========================================
# Installs BOTH themes with universal switcher
# Optimized for Pop!_OS with NVIDIA drivers
# =========================================

set -e  # Exit on any error

echo "🎨 i3 OLED Themes Setup Script v2.0"
echo "===================================="
echo "📍 Pop!_OS + NVIDIA Edition"
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_success() { echo -e "${GREEN}✅ $1${NC}"; }
print_error() { echo -e "${RED}❌ $1${NC}"; }
print_warning() { echo -e "${YELLOW}⚠️  $1${NC}"; }
print_info() { echo -e "${BLUE}ℹ️  $1${NC}"; }

check_success() {
    if [ $? -eq 0 ]; then
        print_success "$1"
    else
        print_error "$1 (continuing anyway...)"
    fi
}

# --- 1. System Updates ---
echo "📦 Step 1/12: Updating system..."
sudo apt update && sudo apt upgrade -y || {
    print_warning "Update had issues, but continuing..."
}
check_success "System update"
echo ""

# --- 2. Firmware Updates ---
echo "🔧 Step 2/12: Checking firmware..."
sudo fwupdmgr get-devices 2>/dev/null || print_info "fwupdmgr not available"
sudo fwupdmgr update 2>/dev/null || print_info "No firmware updates needed"
echo ""

# --- 3. NVIDIA Drivers Check ---
echo "🖥️  Step 3/12: Verifying NVIDIA drivers..."
if command -v nvidia-smi &> /dev/null; then
    nvidia-smi > /dev/null 2>&1 && print_success "NVIDIA drivers working" || print_warning "NVIDIA drivers need attention"
else
    print_warning "NVIDIA drivers not detected"
fi
echo ""

# --- 4. Install Essential Tools ---
echo "🛠️  Step 4/12: Installing essential tools..."
sudo apt install -y build-essential git curl wget unzip python3-pip 2>/dev/null
check_success "Essential tools"
echo ""

# --- 5. Install Timeshift ---
echo "💾 Step 5/12: Installing Timeshift..."
sudo apt install -y timeshift 2>/dev/null || print_warning "Timeshift install failed"
echo ""

# --- 6. Power Management ---
echo "⚡ Step 6/12: Setting power profile..."
if command -v system76-power &> /dev/null; then
    system76-power profile balanced 2>/dev/null && print_success "Power profile: balanced" || true
else
    print_info "Not a System76 laptop, skipping"
fi
echo ""

# --- 7. Install Zsh ---
echo "🐚 Step 7/12: Installing Zsh..."
sudo apt install -y zsh
check_success "Zsh"
print_info "To set Zsh as default: chsh -s \$(which zsh)"
echo ""

# --- 8. Install i3 and Dependencies ---
echo "🪟 Step 8/12: Installing i3 ecosystem..."
print_info "This may take a few minutes..."

# Core i3
sudo apt install -y i3-wm i3status i3lock i3blocks 2>/dev/null
check_success "i3 window manager"

# Terminal
sudo apt install -y alacritty 2>/dev/null
check_success "Alacritty terminal"

# Polybar (with fallback)
sudo apt install -y polybar 2>/dev/null || {
    print_warning "Polybar not in repos, installing dependencies for manual build..."
    sudo apt install -y cmake cmake-data pkg-config python3-sphinx libcairo2-dev \
        libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev \
        python3-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev 2>/dev/null || true
}

# Other tools
sudo apt install -y rofi picom feh nitrogen lxappearance 2>/dev/null
check_success "Additional i3 tools"
echo ""

# --- 9. Install Extra Utilities ---
echo "🎁 Step 9/12: Installing bonus tools..."
sudo apt install -y htop neofetch ranger thunar 2>/dev/null
check_success "Bonus utilities"
echo ""

# --- 10. Install JetBrainsMono Nerd Font ---
echo "🔤 Step 10/12: Installing JetBrainsMono Nerd Font..."
FONT_DIR="$HOME/.local/share/fonts"
mkdir -p "$FONT_DIR"

if [ ! -f "$FONT_DIR/JetBrainsMonoNerdFont-Regular.ttf" ]; then
    cd /tmp
    wget -q --show-progress https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip || {
        print_error "Font download failed"
        cd - > /dev/null
    }
    if [ -f JetBrainsMono.zip ]; then
        unzip -o -q JetBrainsMono.zip -d "$FONT_DIR/"
        fc-cache -fv > /dev/null 2>&1
        rm JetBrainsMono.zip
        print_success "Font installed"
    fi
    cd - > /dev/null
else
    print_info "Font already installed"
fi
echo ""

# --- 11. Create Config Directories ---
echo "📁 Step 11/12: Setting up config structure..."
mkdir -p ~/.config/alacritty
mkdir -p ~/.config/i3
mkdir -p ~/.config/polybar
mkdir -p ~/.config/rofi
mkdir -p ~/.config/i3-themes/gruvbox-golden
mkdir -p ~/.config/i3-themes/white-rainbow
mkdir -p ~/.config/i3/wallpapers
mkdir -p ~/.local/bin
print_success "Config directories created"
echo ""

# --- 12. Install BOTH Themes ---
echo "🎨 Step 12/12: Installing BOTH themes..."

# Check if we're in the repo directory
if [ ! -d "gruvbox-golden" ] && [ ! -d "white_rain" ] && [ ! -d "white-rainbow" ]; then
    print_error "Theme folders not found! Make sure you're running this from the repo directory."
    exit 1
fi

# Detect white theme folder name
WHITE_THEME_DIR="white-rainbow"
if [ -d "white_rain" ]; then
    WHITE_THEME_DIR="white_rain"
fi

# Copy Gruvbox Golden to themes folder
if [ -d "gruvbox-golden" ]; then
    print_info "Installing Gruvbox Golden..."
    cp gruvbox-golden/alacritty.toml ~/.config/i3-themes/gruvbox-golden/ 2>/dev/null || print_error "Gruvbox alacritty.toml not found"
    cp gruvbox-golden/i3-config ~/.config/i3-themes/gruvbox-golden/ 2>/dev/null || print_error "Gruvbox i3-config not found"
    cp gruvbox-golden/config.ini ~/.config/i3-themes/gruvbox-golden/ 2>/dev/null || print_error "Gruvbox config.ini not found"
    cp gruvbox-golden/rofi-config.rasi ~/.config/i3-themes/gruvbox-golden/ 2>/dev/null || print_error "Gruvbox rofi-config.rasi not found"
    print_success "Gruvbox Golden installed"
else
    print_warning "gruvbox-golden folder not found"
fi

# Copy White Rainbow to themes folder
if [ -d "$WHITE_THEME_DIR" ]; then
    print_info "Installing White Rainbow..."
    cp "$WHITE_THEME_DIR"/alacritty.toml ~/.config/i3-themes/white-rainbow/ 2>/dev/null || print_error "White alacritty.toml not found"
    cp "$WHITE_THEME_DIR"/i3-config ~/.config/i3-themes/white-rainbow/ 2>/dev/null || print_error "White i3-config not found"
    cp "$WHITE_THEME_DIR"/config.ini ~/.config/i3-themes/white-rainbow/ 2>/dev/null || print_error "White config.ini not found"
    cp "$WHITE_THEME_DIR"/rofi-config.rasi ~/.config/i3-themes/white-rainbow/ 2>/dev/null || print_error "White rofi-config.rasi not found"
    print_success "White Rainbow installed"
else
    print_warning "$WHITE_THEME_DIR folder not found"
fi

# Set Gruvbox Golden as default
print_info "Setting Gruvbox Golden as default theme..."
cp ~/.config/i3-themes/gruvbox-golden/alacritty.toml ~/.config/alacritty/alacritty.toml 2>/dev/null
cp ~/.config/i3-themes/gruvbox-golden/i3-config ~/.config/i3/config 2>/dev/null
cp ~/.config/i3-themes/gruvbox-golden/config.ini ~/.config/polybar/config.ini 2>/dev/null
cp ~/.config/i3-themes/gruvbox-golden/rofi-config.rasi ~/.config/rofi/config.rasi 2>/dev/null
print_success "Default theme set to Gruvbox Golden"
echo ""

# --- 13. Create Theme Switcher Script ---
echo "🔄 Creating theme switcher command..."

cat > ~/.local/bin/switch-theme << 'SWITCHER_EOF'
#!/bin/bash

# Theme Switcher Script
# Usage: switch-theme [gruvbox|white]

THEME_DIR="$HOME/.config/i3-themes"

if [ "$1" == "gruvbox" ]; then
    echo "🟡 Switching to Gruvbox Golden..."
    cp "$THEME_DIR/gruvbox-golden/alacritty.toml" ~/.config/alacritty/alacritty.toml
    cp "$THEME_DIR/gruvbox-golden/i3-config" ~/.config/i3/config
    cp "$THEME_DIR/gruvbox-golden/config.ini" ~/.config/polybar/config.ini
    cp "$THEME_DIR/gruvbox-golden/rofi-config.rasi" ~/.config/rofi/config.rasi
    echo "✅ Switched to Gruvbox Golden!"
    echo "♻️  Reloading i3..."
    i3-msg reload 2>/dev/null
    killall polybar 2>/dev/null
    sleep 1
    polybar main &
    echo "🎉 Theme changed! Open a new terminal to see Alacritty changes."
    
elif [ "$1" == "white" ]; then
    echo "⚪ Switching to White Phosphor + Rainbow..."
    cp "$THEME_DIR/white-rainbow/alacritty.toml" ~/.config/alacritty/alacritty.toml
    cp "$THEME_DIR/white-rainbow/i3-config" ~/.config/i3/config
    cp "$THEME_DIR/white-rainbow/config.ini" ~/.config/polybar/config.ini
    cp "$THEME_DIR/white-rainbow/rofi-config.rasi" ~/.config/rofi/config.rasi
    echo "✅ Switched to White Phosphor + Rainbow!"
    echo "♻️  Reloading i3..."
    i3-msg reload 2>/dev/null
    killall polybar 2>/dev/null
    sleep 1
    polybar main &
    echo "🎉 Theme changed! Open a new terminal to see Alacritty changes."
    
else
    echo "🎨 Theme Switcher"
    echo "================"
    echo ""
    echo "Usage: switch-theme [gruvbox|white]"
    echo ""
    echo "Available themes:"
    echo "  🟡 gruvbox  - Gruvbox Golden (warm, professional)"
    echo "  ⚪ white    - White Phosphor + Rainbow (retro, vibrant)"
    echo ""
    echo "Example: switch-theme gruvbox"
fi
SWITCHER_EOF

chmod +x ~/.local/bin/switch-theme

# Add to PATH if not already there
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc 2>/dev/null || true
fi

print_success "Theme switcher created: 'switch-theme'"
echo ""

# --- 14. Optional: Install Oh My Zsh ---
echo "📦 Optional: Oh My Zsh"
read -p "Install Oh My Zsh? (y/n): " install_omz
if [[ $install_omz == "y" || $install_omz == "Y" ]]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended || {
        print_warning "Oh My Zsh installation failed"
    }
fi
echo ""

# --- COMPLETION ---
echo ""
echo "╔════════════════════════════════════════╗"
echo "║   ✅ Installation Complete! 🎉         ║"
echo "╚════════════════════════════════════════╝"
echo ""
print_success "Both themes are installed!"
echo ""
echo "📋 Next Steps:"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "1️⃣  Reboot your system:"
echo "   ${BLUE}sudo reboot${NC}"
echo ""
echo "2️⃣  At login screen:"
echo "   • Click the ${YELLOW}⚙️ gear icon${NC}"
echo "   • Select ${GREEN}'i3'${NC}"
echo "   • Log in"
echo ""
echo "3️⃣  Switch themes anytime:"
echo "   ${GREEN}switch-theme gruvbox${NC}   → Gruvbox Golden"
echo "   ${GREEN}switch-theme white${NC}     → White Rainbow"
echo ""
echo "4️⃣  Essential keybindings:"
echo "   ${YELLOW}Mod+Enter${NC}       → Open terminal"
echo "   ${YELLOW}Mod+D${NC}           → App launcher (Rofi)"
echo "   ${YELLOW}Mod+Q${NC}           → Close window"
echo "   ${YELLOW}Mod+Arrows${NC}      → Navigate windows"
echo "   ${YELLOW}Mod+Shift+E${NC}     → Exit i3"
echo ""
echo "   ${BLUE}(Mod = Windows key)${NC}"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
print_info "Current theme: Gruvbox Golden 🟡"
print_info "Wallpaper: Add wallpaper.jpg to ~/.config/i3/"
echo ""
echo "🎊 Enjoy your OLED-optimized i3 setup!"
echo ""