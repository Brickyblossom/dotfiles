if [ "$USER" = "root" ]; then
	echo "Running as root. Will not sync"
	exit 1
fi

if [ ! -f /usr/bin/git ]; then
	sudo pacman -Sy --noconfirm install git curl
fi

install_firefox(){
	if [ ! -f /usr/bin/firefox ]; then
		echo "Installing firefox"
		sudo pacman -Syu --noconfirm firefox
	fi
}

install_kitty(){
	if [ ! -f "$HOME/.local/bin/kitty" ]; then
		echo "Installing kitty terminal emulator"
		curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
		ln -s "$HOME/.local/kitty.app/bin/kitty" "$HOME/.local/bin/"
		# sudo ln -s "$HOME/.local/kitty.app/bin/kitty" "/usr/bin/"
		# sudo ln -sf "$HOME/.local/kitty.app/bin/kitty" "/usr/bin/i3-sensible-terminal"
	fi
	return 0
}

install_zsh_omz_p10k(){
	if [ ! -f /usr/bin/zsh ]; then
		echo "No zsh executable found, downloading zsh"
		sudo pacman -Sy --noconfirm zsh
		cp $HOME/dotfiles/.zshrc $HOME/.zshrc
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
		sudo pacman -Sy --noconfirm picom
	fi
}

install_rofi(){
	if [ ! -f /usr/bin/rofi ]; then
		echo "Installing rofi"
		sudo pacman -Sy --noconfirm rofi
	fi
	mkdir -p ~/.local/bin
	if [ ! -f ~/.local/bin/rofi-power-menu ]; then
		git clone https://github.com/jluttine/rofi-power-menu
		cp ~/dotfiles/rofi-power-menu/rofi-power-menu ~/.local/bin
		rm -R ~/dotfiles/rofi-power-menu
	fi
}

install_feh(){
	if [ ! -f /usr/bin/feh ]; then
		echo "Installing feh image/background tool"
		sudo pacman -Sy --noconfirm feh
	fi
}

install_nitrogen(){
	if [ ! -f /usr/bin/nitrogen ]; then
		echo "Installing nitrogen image/background tool"
		sudo pacman -Sy --noconfirm nitrogen
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

install_font(){
	wget -L https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/FantasqueSansMono/Regular/complete/Fantasque%20Sans%20Mono%20Regular%20Nerd%20Font%20Complete.ttf -O $HOME/dotfiles/fantasque_sans_mono.ttf
	sudo cp $HOME/dotfiles/fantasque_sans_mono.ttf /usr/share/fonts
	sudo fc-cache
	sudo pacman -Syu --noconfirm noto-fonts
}

copy_config(){
	mkdir -p $HOME/.config/polybar
	mkdir -p $HOME/.config/neofetch
	cp $HOME/dotfiles/config.ini $HOME/.config/polybar/config.ini
	cp $HOME/dotfiles/launch.sh $HOME/.config/polybar/launch.sh
	chmod +x $HOME/.config/polybar/launch.sh

	cp $HOME/dotfiles/mpd -r $HOME/.config/
	cp $HOME/dotfiles/.xinitrc $HOME/.xinitrc

	if [ -d  $HOME/.i3 ]; then
		cp $HOME/dotfiles/picom.conf $HOME/picom.conf
		cp $HOME/dotfiles/config $HOME/.i3/config
	else
		cp $HOME/dotfiles/picom.conf $HOME/picom.conf
		cp $HOME/dotfiles/config $HOME/.config/i3/config
	fi
	cp $HOME/dotfiles/.profile $HOME/.profile
	cp $HOME/dotfiles/config.conf $HOME/.config/neofetch/config.conf
}

install_font

install_kitty

install_neofetch

install_zsh_omz_p10k

install_picom

install_rofi

install_feh

install_nitrogen

install_polybar

install_music

install_firefox

copy_config

unset -f install_font install_kitty install_neofetch install_zsh_omz_p10k install_picom install_rofi  install_feh install_nitrogen  install_polybar install_music install_firefox copy_config

exit 0
