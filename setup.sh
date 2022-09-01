cd ..

echo "Updating apt"
apt update

echo "Installing xinit..."
apt install xinit -y

echo "Installing i3..."
apt install i3 -y

echo "Creating config directory..."
mkdir .config/polybar

echo "Installing Polybar..."
apt install polybar -y

cd My-Desktop

echo "Copying Polybar config..."
cp config.ini .config/polybar/config.ini
cp launch.sh .config/polybar/launch.sh

chmod +x .config/polybar/launch.sh

cp config ../.config/i3/config

cd ..

echo "Downloading Polybar themes..."
git clone --depth=1 https://github.com/adi1090x/polybar-themes.git

cd polybar-themes

chmod +x setup.sh

echo "Setting up Polybar theme..."
sh setup.sh

cd ../My-Desktop

echo "Installing zsh..."
apt install zsh -y

echo "Installing ohmyzsh..."
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Downloading powerlevel10k..."
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

echo "Copying .zshrc config and installing powerlevel10k..."
cp .zshrc ../.zshrc

echo "Launching zsh and starting powerlevel10k config"
zsh


echo "Starting X session..."
startx
