# Installation Guide

## Needed

### Linux

cargo is the package manager for rust and you can install just with it if you want  
but i recommend just using your distros package manager

```sh
# install rustup/cargo (NOT REQUIRED)
curl https://sh.rustup.rs -sSf | sh
```

#### Git

```sh
# Ubuntu/Debian
sudo apt update && sudo apt install git

# Fedora
sudo dnf install git

# Arch Linux
sudo pacman -S git
```

#### Nerd Fonts

(JetBrains Mono example)

```sh
# Arch Linux
sudo pacman -S ttf-jetbrains-mono-nerd

# Install script
cd $HOME/Downloads
git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git
./install.sh JetBrainsMono
```

#### Just

```sh
# Ubuntu/Debian (post Debian 13 & Ubuntu 24.04)
apt install just

# Ubuntu/Debian (pre Debian 13 & Ubuntu 24.04)
wget -qO - 'https://proget.makedeb.org/debian-feeds/prebuilt-mpr.pub' | gpg --dearmor | sudo tee /usr/share/keyrings/prebuilt-mpr-archive-keyring.gpg 1> /dev/null
echo "deb [arch=all,$(dpkg --print-architecture) signed-by=/usr/share/keyrings/prebuilt-mpr-archive-keyring.gpg] https://proget.makedeb.org prebuilt-mpr $(lsb_release -cs)" | sudo tee /etc/apt/sources.list.d/prebuilt-mpr.list
sudo apt update
apt install just

# Fedora
dnf install just

# Arch Linux
sudo pacman -S just

# Using cargo
cargo install just
```

#### jq

```sh
# Ubuntu/Debian
sudo apt install jq

# Fedora
sudo dnf install jq

# Arch Linux
sudo pacman -S jq
```

### Windows

package managers  
(you only need one, and from my perspective its mostly preference)  
(cargo is more of an outlier since just is in rust)

- Winget (installed by default)
- Scoop [install](https://scoop.sh/#/)
- Chocolatey (i dont know how to install it seems complicated)

```powershell
# install rustup/cargo (NOT REQUIRED)

# Using winget
winget install --id=Rustlang.Rustup  -e

# Using Scoop
scoop bucket add main
scoop install main/rustup
```

#### Git

```powershell
# Using Winget
winget install --id Git.Git -e --source winget

# Using Scoop
scoop bucket add main
scoop install main/git


1. Download Git from [git-scm.com](https://git-scm.com/download/win)
2. Run the installer and follow the setup wizard
3. Choose "Git from the command line and also from 3rd-party software"
```

#### Nerd Fonts

(JetBrains Mono example)

```powershell
# Using Winget
winget install --id=DEVCOM.JetBrainsMonoNerdFont  -e

# Using Scoop
scoop bucket add nerd-fonts
scoop install Hack-NF

# using Chocolatey
choco install nerd-fonts-jetbrainsmono
```

#### Just

```powershell
# Using Winget
winget install --id=Casey.Just  -e

# Using Scoop
scoop bucket add main
scoop install just

# using Chocolatey
choco install just

# using Cargo
cargo install just
```

#### jq

```powershell
# Using Winget
winget install --id=jqlang.jq  -e

# Using Scoop
scoop bucket add main
scoop install jq

# Or using Chocolatey
choco install jq
```
