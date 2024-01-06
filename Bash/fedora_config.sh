#!/bin/bash




### DNF Config ###
echo -e "\n# Additions #\nfastestmirror=True\nmax_parallel_downloads=10\ndefaultyes=True" \
    | sudo tee -a /etc/dnf/dnf.conf



### First-time Configuration ###

# RPM Fusion
# Site : https://rpmfusion.org/Configuration
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# AppStream Metadata
sudo dnf groupupdate core 

# Multimedia
# Site : https://rpmfusion.org/Howto/Multimedia
sudo dnf swap ffmpeg-free ffmpeg --allowerasing
sudo dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
sudo dnf groupupdate sound-and-video

# Nvidia Drivers
# Site : https://rpmfusion.org/Howto/NVIDIA
sudo dnf update -y # and reboot if you are not on the latest kernel
sudo dnf install akmod-nvidia # rhel/centos users can use kmod-nvidia instead
sudo dnf install xorg-x11-drv-nvidia-cuda #optional for cuda/nvdec/nvenc support
modinfo -F version nvidia


### Virtualization ###
sudo dnf group install --with-optional virtualization
sudo systemctl start libvirtd
sudo systemctl enable libvirtd

### Applications and Themes ###

sudo /usr/bin/dnf update && sudo /usr/bin/dnf upgrade -y

sudo /usr/bin/dnf install vim git kitty vlc \
    papirus-icon-theme sassc gtk-murrine-engine gnome-tweaks -y


mkdir -p $HOME/Themes
mkdir -p $HOME/.themes

cd $HOME/Themes
/usr/bin/git clone --depth 1 https://github.com/vinceliuice/Graphite-gtk-theme.git
cd ./Graphite-gtk-theme

chmod +x ./install.sh
./install.sh --dest $HOME/.themes --name graphite-dark --color dark --libadwaita \
    --tweaks black rimless normal float


