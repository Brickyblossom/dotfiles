if [ "$USER" = "root" ]; then
	echo "Running as root. Will not sync"
	exit 1
fi

if [ ! -f /usr/bin/git ]; then
	sudo pacman -Sy --noconfirm install git curl
fi

install_kitty(){
	if [ ! -f "$HOME/.local/bin/kitty" ]; then
		echo "Installing kitty terminal emulator"
		curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
		ln -s "$HOME/.local/kitty.app/bin/kitty" "$HOME/.local/bin/"
		# sudo ln -sf "$HOME/.local/kitty.app/bin/kitty" "/usr/bin/i3-sensible-terminal"
	fi
	return 0
}

install_zsh_omz_p10k(){
	if [ ! -f /usr/bin/zsh ]; then
		echo "No zsh executable found, downloading zsh"
		sudo pacman -Sy --noconfirm install zsh
		echo "zsh is installed"
	fi

	if [ ! -d "$HOME/.oh-my-zsh" ]; then
		echo "Installing zsh"
		sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	fi

	if [ -d "$HOME/.oh-my-zsh" ]; then
		# Only runs the following command if user has omz pre-installed, or accepted to install omz earlier
		echo "Installing oh-my-zsh"
		local ZSH_CUSTOM_DIR="$HOME/.oh-my-zsh/custom"
		git clone https://github.com/agkozak/zsh-z "$ZSH_CUSTOM_DIR/plugins/zsh-z"
		git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git "$ZSH_CUSTOM_DIR/plugins/fast-syntax-highlighting"
		git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM_DIR/plugins/zsh-autosuggestions"
		git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM_DIR/themes/powerlevel10k"
		cp "$HOME/dotfiles/.zshrc" "$HOME/"
		unset ZSH_CUSTOM_DIR
	fi
	return 0
}

install_neofetch(){
	if [ ! -f /usr/bin/neofetch ]; then
		echo "Installing neofetch"
		sudo pacman -Sy --noconfirm neofetch
	fi
}

install_picom(){
	if [ ! -f /usr/bin/picom ]; then
		echo "Installing picom compositor"
		sudo pacman -Sy --noconfirm neofetch
	fi
}

install_feh(){
	if [ ! -f /usr/bin/feh ]; then
		echo "Installing feh image/background tool"
		sudo pacman -Sy --noconfirm feh
	fi
}

install_polybar(){
	if [ ! -f /usr/bin/polybar ]; then
		echo "Installing polybar"
		sudo pacman -Sy --noconfirm polybar
	fi
}

install_music(){

	if [ ! -f /usr/bin/mpd ]; then
		sudo pacman -Sy --noconfirm mpd
	fi
	
	if [ ! -f /usr/bin/ncmpcpp ]; then
		sudo pacman -Sy --noconfirm ncmpcpp
	fi
}

copy_config(){
	cp $HOME/dotfiles/config.ini $HOME/.config/polybar/config.ini
	cp $HOME/dotfiles/launch.sh $HOME/.config/polybar/launch.sh
	chmod +x $HOME/.config/polybar/launch.sh

	cp $HOME/dotfiles/.xinitrc $HOME/.xinitrc
	cp $HOME/dotfiles/compton.conf $HOME/.i3/compton.conf
	cp $HOME/dotfiles/config $HOME/.i3/config
}

install_kitty

install_neofetch

install_zsh_omz_p10k

install_picom

install_feh

install_polybar

install_music

copy_config

unset -f install_kitty install_neofetch install_zsh_omz_p10k install_picom install_feh install_polybar install_music copy_config

exit 0