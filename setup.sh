dir = $(cd -P -- "$(dirname -- "$0")" && pwd -P)

cd ..

echo "Updating apt"
sudo apt update
sudo apt install python3-pip

echo "Installing xinit..."
sudo apt install xinit -y

echo "Building i3-gaps..."
sudo apt install libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev autoconf xutils-dev libtool libxcb-shape0-dev 
cd /tmp
git clone https://www.github.com/Airblader/i3 i3-gaps
cd i3-gaps
git checkout gaps && git pull
autoreconf --force --install
rm -rf build
mkdir build
cd build
../configure --prefix=/usr --sysconfdir=/etc
make
sudo make install

cd dir

echo "Creating config directory..."
mkdir .config/polybar

echo "Installing Polybar..."
sudo apt install polybar -y
sudo apt install rofi -y
pip install pywal

cd My-Desktop

echo "Copying Polybar config..."
cp config.ini ../.config/polybar/config.ini
cp launch.sh ../.config/polybar/launch.sh

chmod +x .config/polybar/launch.sh

cp config ../.config/i3/config

cd ..

echo "Downloading Polybar themes..."
git clone --depth=1 https://github.com/adi1090x/polybar-themes.git

cd polybar-themes

chmod +x setup.sh

echo "Setting up Polybar theme..."
./setup.sh

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

cd ..
echo "Installing dark mode on URxvt..."
touch .Xdefaults

echo "Wiping .Xdefaults..."
echo "" > .Xdefaults
echo "URxvt*background: black\n" >> .Xdefaults
echo "URxvt*foreground: white\n" >> .Xdefaults
echo "URxvt*font: xft:Ubuntu Mono:size=12:antialias=true" >> .Xdefaults
echo "URxvt*boldfont: xft:Ubuntu Mono:bold:size=12:antialias=true" >> .Xdefaults

echo "Starting X session..."
startx

echo "Launching zsh and starting powerlevel10k config"
exec zsh

