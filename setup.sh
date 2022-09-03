cd ..

echo "Updating apt"
sudo apt update
sudo apt install python3-pip -y

echo "Installing xinit..."
sudo apt install xinit -y

echo "Building i3-gaps..."
sudo apt install libxcb-xrm-dev libxcb-shape0-dev libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev autoconf xutils-dev libtool automake -y

mkdir temp
cd temp
git clone https://www.github.com/Airblader/i3 i3-gaps
cd i3-gaps
git checkout gaps && git pull
sudo apt install meson asciidoc -y

echo "Installing i3-gaps..."
meson -Ddocs=true -Dmans=true ../temp
meson compile -C ../temp
sudo meson install -C ../temp

cd ../..
sudo rm -r temp

echo "Creating config directory..."
mkdir .config/polybar

echo "Installing Polybar..."
sudo apt install polybar -y
sudo apt install rofi -y
sudo pip install pywal

cd ../My-Desktop

echo "Installing zsh..."
sudo apt install zsh -y

echo "Installing ohmyzsh..."
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

cd ..
echo "Downloading powerlevel10k..."
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

cd My-Desktop
echo "Copying .zshrc config and installing powerlevel10k..."
cp .zshrc ../.zshrc

echo "Setting up xstart on login..."
cp .zprofile ../.zprofile

echo "Installing Ubuntu font..."
sudo apt install fonts-ubuntu

echo "Copying .Xdefaults..."
cp .Xdefaults ../.Xdefaults

echo "Copying Polybar and i3 config..."
cp config.ini ../.config/polybar/config.ini
cp launch.sh ../.config/polybar/launch.sh
chmod +x ../.config/polybar/launch.sh

cp config ../.config/i3/config
cp .xinitrc ../.xinitrc
cp compton.conf ../.config/i3/compton.conf

cd ..

echo "Downloading Polybar themes..."
git clone --depth=1 https://github.com/adi1090x/polybar-themes.git

cd polybar-themes

chmod +x setup.sh

echo "Setting up Polybar theme..."
./setup.sh

echo "Installing rxvt-unicode..."
sudo apt install rxvt-unicode -y

sudo apt purge gnome-terminal -y

echo "Starting X session..."
startx

echo "Launching zsh and starting powerlevel10k config"
exec zsh

