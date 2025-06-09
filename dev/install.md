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
# Debian/Ubuntu
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
cd nerd-fonts  # <-- MISSING: need to cd into the cloned directory
./install.sh JetBrainsMono
```

#### Just

```sh
# Debian/Ubuntu (post Debian 13 & Ubuntu 24.04)
sudo apt install just  # <-- MISSING sudo

# Debian/Ubuntu (pre Debian 13 & Ubuntu 24.04)
wget -qO - 'https://proget.makedeb.org/debian-feeds/prebuilt-mpr.pub' | gpg --dearmor | sudo tee /usr/share/keyrings/prebuilt-mpr-archive-keyring.gpg 1> /dev/null
echo "deb [arch=all,$(dpkg --print-architecture) signed-by=/usr/share/keyrings/prebuilt-mpr-archive-keyring.gpg] https://proget.makedeb.org prebuilt-mpr $(lsb_release -cs)" | sudo tee /etc/apt/sources.list.d/prebuilt-mpr.list
sudo apt update
sudo apt install just  # <-- MISSING sudo

# Fedora
sudo dnf install just  # <-- MISSING sudo
# Arch Linux
sudo pacman -S just

# Using cargo
cargo install just
```

#### jq

```sh
# Debian/Ubuntu
sudo apt install jq

# Fedora
sudo dnf install jq

# Arch Linux
sudo pacman -S jq
```

#### docker & docker compose

```sh
# Debian
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo groupadd docker
sudo usermod -a -G docker $(whoami)
sudo systemctl enable --now docker

# Ubuntu
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo groupadd docker
sudo usermod -a -G docker $(whoami)
sudo systemctl enable --now docker

# Fedora
sudo dnf -y install dnf-plugins-core
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo  # <-- FIX: remove "-3"
sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo groupadd docker
sudo usermod -a -G docker $(whoami)
sudo systemctl enable --now docker

# Arch Linux
sudo pacman -S docker docker-compose
sudo groupadd docker
sudo usermod -a -G docker $(whoami)
sudo systemctl enable --now docker
```

### Windows

package managers  
(you only need one, and from my perspective its mostly preference)  
(cargo is more of an outlier since just is in rust)

- Winget (installed by default)
- Scoop [install](https://scoop.sh/#/)
- Chocolatey [install](https://chocolatey.org/install)

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

# Manual installation:
# 1. Download Git from [git-scm.com](https://git-scm.com/download/win)
# 2. Run the installer and follow the setup wizard
# 3. Choose "Git from the command line and also from 3rd-party software"
```

#### Nerd Fonts

(JetBrains Mono example)

```powershell
# Using Winget
winget install --id=DEVCOM.JetBrainsMonoNerdFont  -e

# Using Scoop
scoop bucket add nerd-fonts
scoop install JetBrainsMono-NF

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

#### docker & docker compose

I recommend the cli version but you can install docker desktop if you want.
If you're installing docker desktop you will still get docker cli.
Can't verify since I don't use Windows.

```powershell
# Using Winget (docker desktop)
winget install --id=Docker.DockerDesktop  -e
# Note: Docker Desktop includes Docker Compose

# Using Scoop (docker cli)
scoop bucket add main
scoop install main/docker
scoop install main/docker-compose
dockerd --register-service

# Using Chocolatey (docker cli)
choco install docker-cli
choco install docker-compose
# Note: You may need to start Docker daemon manually or install Docker Desktop

# Using Chocolatey (docker desktop)
choco install docker-desktop
# Note: Docker Desktop includes Docker Compose
```
