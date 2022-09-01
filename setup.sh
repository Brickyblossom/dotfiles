cd ..

echo "Updating apt"
sudo apt update
sudo apt install python3-pip

echo "Installing xinit..."
sudo apt install xinit -y

echo "Installing i3..."
sudo apt install i3 -y

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

