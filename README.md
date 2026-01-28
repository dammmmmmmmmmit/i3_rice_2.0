# 🎨 i3 OLED Themes - Universal Switcher Edition

**Two beautiful themes** with **one-command switching** for Pop!_OS + NVIDIA

---

## 🚀 Super Quick Install

```bash
# 1. Clone repo
git clone https://github.com/dammmmmmmmmmit/i3_rice_2.0.git
cd i3_rice_2.0

# 2. Run setup
chmod +x setup_system.sh
./setup_system.sh

# 3. Reboot
sudo reboot

# 4. At login, select i3 from gear icon ⚙️
```

**That's it!** Both themes are installed and ready to switch!

---

## 🎨 Your Two Themes

### 🟡 Gruvbox Golden (Default)
- **Vibe:** Warm, professional, classic
- **Colors:** Golden yellow (#d79921) on OLED black
- **Perfect for:** Long coding sessions, professional work

### ⚪ White Phosphor + Rainbow
- **Vibe:** Retro terminal, vibrant accents
- **Colors:** White (#e0e0e0) with rainbow highlights
- **Perfect for:** Maximum readability, colorful syntax

---

## 🔄 Switch Themes Instantly

**Simple command switches EVERYTHING** (i3, Alacritty, Polybar, Rofi):

```bash
# Switch to Gruvbox Golden
switch-theme gruvbox

# Switch to White Rainbow
switch-theme white
```

That's it! Everything updates automatically! 🎉

---

## ✨ What the Script Installs

✅ **BOTH themes** (stored safely in `~/.config/i3-themes/`)  
✅ **i3 window manager** (tiling WM)  
✅ **Alacritty** (terminal)  
✅ **Polybar** (status bar)  
✅ **Rofi** (app launcher)  
✅ **Picom** (compositor)  
✅ **JetBrainsMono Nerd Font** (beautiful monospace font)  
✅ **Theme switcher command** (`switch-theme`)  
✅ **Bonus tools** (htop, neofetch, ranger, thunar)  
✅ **Error handling** (won't break if something fails)  

---

## 📋 Can the Script Fail?

**Possible issues & solutions:**

| Issue | Likelihood | Solution |
|-------|-----------|----------|
| Network timeout | Low | Re-run script, it'll skip what's done |
| Polybar not in repos | Medium | Script installs build dependencies |
| Font download fails | Low | Manually download & extract to `~/.local/share/fonts/` |
| Power management error | Low | Only affects System76 laptops, skips otherwise |
| Permission denied | Very Low | Make sure to run with `./setup_system.sh` (not `sudo`) |

**The script is designed to continue even if individual steps fail!**

---

## 🎯 Essential i3 Keybindings

| Keys | Action |
|------|--------|
| `Mod+Enter` | Open terminal (Alacritty) |
| `Mod+D` | App launcher (Rofi) |
| `Mod+Q` | Close window |
| `Mod+Arrow Keys` | Navigate windows |
| `Mod+Shift+Arrow` | Move windows |
| `Mod+Shift+E` | Exit i3 |
| `Mod+Shift+R` | Reload i3 config |

*Mod = Windows key*

---

## 🖼️ Add a Wallpaper

```bash
# Copy your wallpaper
cp /path/to/your/image.jpg ~/.config/i3/wallpaper.jpg

# Reload i3
i3-msg reload
```

---

## 🔧 File Locations

```
~/.config/
├── alacritty/
│   └── alacritty.toml         # Current theme (auto-switched)
├── i3/
│   ├── config                 # Current theme (auto-switched)
│   └── wallpaper.jpg         # Your wallpaper
├── polybar/
│   └── config.ini             # Current theme (auto-switched)
├── rofi/
│   └── config.rasi            # Current theme (auto-switched)
└── i3-themes/                 # Theme storage (don't edit)
    ├── gruvbox-golden/
    │   ├── alacritty.toml
    │   ├── i3-config
    │   ├── config.ini
    │   └── rofi-config.rasi
    └── white-rainbow/
        ├── alacritty.toml
        ├── i3-config
        ├── config.ini
        └── rofi-config.rasi
```

**To customize:** Edit files in `~/.config/` (not in `i3-themes/`)

---

## 🛠️ Manual Theme Switch (if command doesn't work)

### Gruvbox Golden:
```bash
cp ~/.config/i3-themes/gruvbox-golden/* ~/.config/alacritty/ ~/.config/i3/ ~/.config/polybar/ ~/.config/rofi/
i3-msg reload
```

### White Rainbow:
```bash
cp ~/.config/i3-themes/white-rainbow/* ~/.config/alacritty/ ~/.config/i3/ ~/.config/polybar/ ~/.config/rofi/
i3-msg reload
```

---

## 🆘 Troubleshooting

**Polybar not showing:**
```bash
killall polybar
polybar main &
```

**Font not loading:**
```bash
fc-cache -fv
i3-msg reload
```

**Theme switch not working:**
```bash
# Make sure switcher is executable
chmod +x ~/.local/bin/switch-theme

# Add to PATH manually
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

**Can't find i3 at login:**
```bash
sudo apt install i3-wm i3status
# Log out, click gear icon, select i3
```

---

## 💡 Pro Tips

1. **Take a Timeshift backup** before major changes
2. **Learn i3 keybindings** - makes you super productive
3. **Customize polybar modules** in `~/.config/polybar/config.ini`
4. **Add more workspaces** in i3 config
5. **Change Alacritty font size** in alacritty.toml

---

## 🌟 Why This Setup Rocks

✅ **OLED Optimized** - True black (#000000) for perfect OLED displays  
✅ **NVIDIA Ready** - Works with Pop!_OS NVIDIA edition out of the box  
✅ **Two themes, zero hassle** - Switch instantly with one command  
✅ **Everything included** - No hunting for configs  
✅ **Error proof** - Script continues even if parts fail  
✅ **Universal switching** - One command updates ALL apps  

---

## 📸 Screenshots

*(Add your screenshots here after installation!)*

---

## 🤝 Contributing

Found a bug? Have improvements? Open an issue or PR!

---

## 📝 License

MIT License - Use freely!

---

**Made with 💛 for OLED displays and tiling window manager enthusiasts**

Enjoy your beautiful, customizable i3 setup! 🎉