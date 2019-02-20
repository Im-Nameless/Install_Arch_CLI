#!/bin/bash
	GNUGPL="\
#    this script is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    this script is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this script.  If not, see <https://www.gnu.org/licenses/>.
"

# GNU G.P.L
	whiptail --msgbox "$GNUGPL" --title "GNU General Public License" 18 78

# Target drive
	LSBLK="$(lsblk)"
	TARGET_DRIVE=$(whiptail --inputbox "/dev/sd* (replace the * with the drive letter no number) $LSBLK" 15 60 /dev/ --title "target drive" 3>&1 1>&2 2>&3)

# File System
	FILESYSTEM=$(whiptail --menu "select=[ENTER]" 12 50 5 --title "file systems" 3>&1 1>&2 2>&3 "ext4" "Recommended and is nearly indestructible." "btrfs" "Use only if you need certain features.")

# Bootloader ID
	BOOTLOADER_ID=$(whiptail --inputbox "done=[ENTER], write the bootloader ID." 8 60 Arch --title "bootloader id" 3>&1 1>&2 2>&3)

# Hostname
	HOSTNAME=$(whiptail --inputbox "done=[ENTER], write the hostname (PC name)." 8 60 archlinux --title "hostname" 3>&1 1>&2 2>&3)

# Username
	USERNAME=$(whiptail --inputbox "done=[ENTER], write your username." 8 60 noname --title "username" 3>&1 1>&2 2>&3)

# User Password
	PWD=$(whiptail --passwordbox "done=[ENTER], enter the password for user." 8 60 --title "password for user" 3>&1 1>&2 2>&3)
	PWD2=$(whiptail --passwordbox "done=[ENTER], re-enter the password for user." 8 60 --title "password for user" 3>&1 1>&2 2>&3)
	if [ "$PWD" != "$PWD2" ]; then
		whiptail --msgbox "Passowrds did not match, please try again. (2 tries left)" --title "failed password" 8 60
		PWD=$(whiptail --passwordbox "done=[ENTER], write the password for user." 8 60 --title "password for user" 3>&1 1>&2 2>&3)
		PWD2=$(whiptail --passwordbox "done=[ENTER], write the password for user." 8 60 --title "password for user" 3>&1 1>&2 2>&3)
		if [ "$PWD" != "$PWD2" ]; then
			whiptail --msgbox "Passowrds did not match, please try again. (last try)" --title "failed password" 8 60
			PWD=$(whiptail --passwordbox "done=[ENTER], write the password for user." 8 60 --title "password for user" 3>&1 1>&2 2>&3)
			PWD2=$(whiptail --passwordbox "done=[ENTER], write the password for user." 8 60 --title "password for user" 3>&1 1>&2 2>&3)
			if [ "$PWD" != "$PWD2" ]; then
				exit
			fi
		fi
	fi

# User Password
	ROOT_PWD=$(whiptail --passwordbox "done=[ENTER], enter the password for root." 8 60 --title "password for root" 3>&1 1>&2 2>&3)
	ROOT_PWD2=$(whiptail --passwordbox "done=[ENTER], re-enter the password for root." 8 60 --title "password for root" 3>&1 1>&2 2>&3)
	if [ "$ROOT_PWD" != "$ROOT_PWD2" ]; then
		whiptail --msgbox "Passowrds did not match, please try again. (2 tries left)" --title "failed password" 8 60
		ROOT_PWD=$(whiptail --passwordbox "done=[ENTER], write the password for root." 8 60 --title "password for root" 3>&1 1>&2 2>&3)
		ROOT_PWD2=$(whiptail --passwordbox "done=[ENTER], write the password for root." 8 60 --title "password for root" 3>&1 1>&2 2>&3)
		if [ "$ROOT_PWD" != "$ROOT_PWD2" ]; then
			whiptail --msgbox "Passowrds did not match, please try again. (last try)" --title "failed password" 8 60
			ROOT_PWD=$(whiptail --passwordbox "done=[ENTER], write the password for root." 8 60 --title "password for root" 3>&1 1>&2 2>&3)
			ROOT_PWD2=$(whiptail --passwordbox "done=[ENTER], write the password for root." 8 60 --title "password for root" 3>&1 1>&2 2>&3)
			if [ "$ROOT_PWD" != "$ROOT_PWD2" ]; then
				exit
			fi
		fi
	fi

# Interface
	INTERFACE=$(whiptail --menu "select=[ENTER]" 18 80 10 --title "interface" 3>&1 1>&2 2>&3 "nodeorwm" "Comes with nothing and is nothing." "budgie" "Modern design, focuses on simplicity and elegance." "cinnamon" "Strives to provide a traditional user experience." "gnome" "An attractive and intuitive desktop." "kde" "Modern and familiar working environment." "lxde" "Strives to be less CPU and RAM intensive." "lxqt" "Lightweight, modular, blazing-fast and user-friendly." "mate" " Intuitive and attractive desktop using traditional metaphors." "xfce" "Traditional UNIX philosophy of modularity and re-usability." "i3wm" "Primarily targeted at developers and advanced users" "sway" "Drop-in replacement of i3/i3-gaps for Wayland")

# Display manager
	DISPLAYMANAGER=$(whiptail --menu "select=[ENTER]" 12 50 5 --title "display manager" 3>&1 1>&2 2>&3 "nodm" "Comes with nothing and is nothing." "gdm" "Recommended for Budgie & Gnome." "lightdm" "Recommended for XFCE." "lxdm" "Recommended for LXDE." "sddm" "Recommended for KDE & LXQT." "ly" "TUI based")

# BlackArch
	BLACKARCH=$(whiptail --menu "select=[ENTER], default=(false)" 8 60 2 --title "BlackArch" 3>&1 1>&2 2>&3 "false" "Do not install BlackArch tools" "true" "Install BlackArch tools")

# Custom packages
	CUSTOM_PACKAGES=$(whiptail --separate-output --checklist "select=[space], done=[enter]" 30 50 22 --title "custom packages" 3>&1 1>&2 2>&3 "firefox" "Web Browser" ON "atom" "IDE" ON "weechat" "IRC client" ON "libreoffice" "Office suite" ON "tor" "proxy" ON "deluge" "torrent manager" ON "gimp" "image manipulator" ON "audacity" "audio editor" ON "blender" "3d editor" ON "darktable" "photo editor" ON "inkscape" "vector editor" ON "krita" "drawing editor" ON "steam" "Game client" OFF "playonlinux" "wine manager" OFF "lutris" "wine manager" OFF)

# Other custom packages
	OTHER_CUSTOM_PACKAGES=$(whiptail --inputbox "done=[ENTER]" 8 60 --title "other custom packages" 3>&1 1>&2 2>&3)

# Custom packages
	AUR_CUSTOM_PACKAGES=$(whiptail --separate-output --checklist "select=[space], done=[enter]" 30 50 22 --title "custom packages" 3>&1 1>&2 2>&3 "discord" "discord" ON "spotify" "spotify" OFF "polybar" "polybar" ON)

# Other custom packages
	AUR_OTHER_CUSTOM_PACKAGES=$(whiptail --inputbox "done=[ENTER]" 8 60 --title "other custom packages" 3>&1 1>&2 2>&3)

# Nvme drive
	NVME=$(whiptail --menu "select=[ENTER], default=(false)" 8 60 2 --title "nvme" 3>&1 1>&2 2>&3 "false" "I don't have an Nvme SSD." "true" "I have an Nvme SSD.")

# Encrypt drive
	ENCRYPT_DRIVE=$(whiptail --menu "select=[ENTER], default=(false)" 8 60 2 --title "drive encryption" 3>&1 1>&2 2>&3 "false" "I don't want to encrypt my drive." "true" "I want to encrypt my drive.")

# Timezone
	TIMEZONE=""
	CHOOSING_TIMEZONE=true
    while [ $CHOOSING_TIMEZONE ]; do
        if [ -d "/usr/share/zoneinfo"$(if [ -n $TIMEZONE ]; then echo "/$TIMEZONE/"; fi) ]; then
             TMP_TIMEZONE=$(whiptail --noitem --title "timezone" --menu "select/continue=[enter]" 30 40 22 $(for ZONE in $(find /usr/share/zoneinfo/$(if [ -n "$TIMEZONE" ]; then echo "$TIMEZONE/"; fi) -maxdepth 1 \
             $([ -z "$TIMEZONE" ] && echo "-type d") -not -name right -not -name posix -not -name Etc -not -wholename "/usr/share/zoneinfo/$TIMEZONE/" -not -wholename "/usr/share/zoneinfo/$TIMEZONE" 2>/dev/null | sed "s#/usr/share/zoneinfo/$TIMEZONE##" | sed "s#/##"); do
                 echo "$ZONE $ZONE"
             done) 3>&1 1>&2 2>&3)
             if [ -z $TIMEZONE ]; then
                 TIMEZONE="$TMP_TIMEZONE"
             else
                 TIMEZONE=$TIMEZONE/$TMP_TIMEZONE
             fi
        else
            CHOOSING_TIMEZONE=false
            break
        fi
     done

# Locale
	LOCALE=$(eval 'whiptail --radiolist "select=[space], continue=[enter]. default=en_US.UTF-8 UTF-8" 40 60 30 --title "locale" 3>&1 1>&2 2>&3' "$(perl -lne 'BEGIN{$\=" "} next unless /^#?[a-z]\S+\s\S+\s*$/; s/^#//; s/\s+$//; print "\"$_\" locale OFF" ' /etc/locale.gen)")

# Keymap
	KEYMAP=$(
		KEYMAPS=$(find /usr/share/kbd -name '*.map.gz' -type f -printf '%f\n' | cut -d. -f1 | sort)
		eval "whiptail --radiolist 'select=[space], continue=[enter]. default=us' 40 60 30 --title 'keymap' 3>&1 1>&2 2>&3 $(printf '"%s" keymap OFF ' $KEYMAPS)"
	)

# DE/WM's
	if [ "$INTERFACE" == "budgie" ]; then
		DE="budgie-desktop budgie-extras baobab cheese eog epiphany evince file-roller gedit gnome-backgrounds gnome-calculator gnome-calendar gnome-characters gnome-clocks gnome-color-manager gnome-contacts gnome-control-center gnome-dictionary gnome-disk-utility gnome-documents gnome-font-viewer gnome-getting-started-docs gnome-keyring gnome-logs gnome-maps gnome-menus gnome-music gnome-photos gnome-remote-desktop gnome-screenshot gnome-session gnome-settings-daemon gnome-shell gnome-shell-extensions gnome-system-monitor gnome-terminal gnome-themes-extra gnome-todo gnome-user-docs gnome-user-share gnome-video-effects grilo-plugins gvfs gvfs-afc gvfs-goa gvfs-google gvfs-gphoto2 gvfs-mtp gvfs-nfs gvfs-smb mousetweaks mutter nautilus networkmanager orca rygel sushi totem tracker tracker-miners vino xdg-user-dirs-gtk yelp gnome-boxes gnome-software simple-scan"
	elif [ "$INTERFACE" == "cinnamon" ]; then
		DE="cinnamon"
	elif [ "$INTERFACE" == "gnome" ]; then
		DE="baobab cheese eog epiphany evince file-roller gedit gnome-backgrounds gnome-calculator gnome-calendar gnome-characters gnome-clocks gnome-color-manager gnome-contacts gnome-control-center gnome-dictionary gnome-disk-utility gnome-documents gnome-font-viewer gnome-getting-started-docs gnome-keyring gnome-logs gnome-maps gnome-menus gnome-music gnome-photos gnome-remote-desktop gnome-screenshot gnome-session gnome-settings-daemon gnome-shell gnome-shell-extensions gnome-system-monitor gnome-terminal gnome-themes-extra gnome-todo gnome-user-docs gnome-user-share gnome-video-effects grilo-plugins gvfs gvfs-afc gvfs-goa gvfs-google gvfs-gphoto2 gvfs-mtp gvfs-nfs gvfs-smb mousetweaks mutter nautilus networkmanager orca rygel sushi totem tracker tracker-miners vino xdg-user-dirs-gtk yelp gnome-boxes gnome-software simple-scan accerciser brasero dconf-editor devhelp evolution five-or-more four-in-a-row gnome-builder gnome-chess gnome-devel-docs gnome-klotski gnome-mahjongg gnome-mines gnome-nettool gnome-nibbles gnome-robots gnome-sound-recorder gnome-sudoku gnome-taquin gnome-tetravex gnome-tweaks gnome-weather hitori iagno lightsoff nautilus-sendto polari quadrapassel swell-foop sysprof tali gedit-code-assistance gnome-code-assistance gnome-multi-writer gnome-recipes gnome-usage"
	elif [ "$INTERFACE" == "kde" ]; then
		DE="plasma-meta kde-applications-meta"
	elif [ "$INTERFACE" == "lxde" ]; then
		DE="gpicview lxappearance lxappearance-obconf lxde-common lxde-icon-theme lxhotkey lxinput lxlauncher lxmusic lxpanel lxrandr lxsession lxtask lxterminal openbox pcmanfm"
	elif [ "$INTERFACE" == "lxqt" ]; then
		DE="lximage-qt lxqt-about lxqt-admin lxqt-config lxqt-globalkeys lxqt-notificationd lxqt-openssh-askpass lxqt-panel lxqt-policykit lxqt-powermanagement lxqt-qtplugin lxqt-runner lxqt-session lxqt-sudo lxqt-themes obconf-qt openbox pcmanfm-qt qterminal"
	elif [ "$INTERFACE" == "mate" ]; then
		DE="caja marco mate-backgrounds mate-control-center mate-desktop mate-icon-theme mate-menus mate-notification-daemon mate-panel mate-polkit mate-session-manager mate-settings-daemon mate-themes mate-user-guide atril caja-image-converter caja-open-terminal caja-sendto caja-share caja-wallpaper caja-xattr-tags engrampa eom mate-applets mate-calc mate-icon-theme-faenza mate-media mate-netbook mate-power-manager mate-screensaver mate-sensors-applet mate-system-monitor mate-terminal mate-user-share mate-utils mozo pluma"
	elif [ "$INTERFACE" == "xfce" ]; then
		DE="exo garcon gtk-xfce-engine thunar thunar-volman tumbler xfce4-appfinder xfce4-panel xfce4-power-manager xfce4-session xfce4-settings xfce4-terminal xfconf xfdesktop xfwm4 xfwm4-themes mousepad orage thunar-archive-plugin thunar-media-tags-plugin xfburn xfce4-artwork xfce4-battery-plugin xfce4-clipman-plugin xfce4-cpufreq-plugin xfce4-cpugraph-plugin xfce4-datetime-plugin xfce4-dict xfce4-diskperf-plugin xfce4-eyes-plugin xfce4-fsguard-plugin xfce4-genmon-plugin xfce4-mailwatch-plugin xfce4-mount-plugin xfce4-mpc-plugin xfce4-netload-plugin xfce4-notes-plugin xfce4-notifyd xfce4-pulseaudio-plugin xfce4-screenshooter xfce4-sensors-plugin xfce4-smartbookmark-plugin xfce4-systemload-plugin xfce4-taskmanager xfce4-time-out-plugin xfce4-timer-plugin xfce4-verve-plugin xfce4-wavelan-plugin xfce4-weather-plugin xfce4-xkb-plugin parole ristretto xfce4-whiskermenu-plugin"
	elif [ "$INTERFACE" == "i3wm" ]; then
		DE="i3-gaps rofi rxvt-unicode ranger mc pcurses neofetch cmus calcurse bc scrot"
	elif [ "$INTERFACE" == "sway" ]; then
		DE="sway rofi rxvt-unicode ranger mc pcurses neofetch cmus calcurse bc scrot"
	elif [ "$INTERFACE" == "nodeorwm" ]; then
		DE=""
	fi

# DM's
	if [ "$DISPLAYMANAGER" == "gdm" ]; then
		DM="gdm"
	elif [ "$DISPLAYMANAGER" == "sddm" ]; then
		DM="sddm"
	elif [ "$DISPLAYMANAGER" == "lxdm" ]; then
		DM="lxdm"
	elif [ "$DISPLAYMANAGER" == "lightdm" ]; then
		DM="lightdm lightdm-gtk-greeter"
	elif [ "$DISPLAYMANAGER" == "ly" ]; then
		AUR_DM="ly-git"
	elif [ "$DISPLAYMANAGER" == "nodm" ]; then
		DM=""
	fi

# Nvidia (i)GPU
	if $(lspci | grep -i "VGA compatible controller: NVIDIA Corporation" > /dev/null 2>&1); then
		echo "nVIDIA (i)GPU found, drivers will be installed"
		NVIDIA="nvidia nvidia-utils nvidia-settings"
	else
		NVIDIA=""
	fi

# AMD (i)GPU
	if $(lspci | grep -i "VGA compatible controller: Advanced Micro Devices" > /dev/null 2>&1); then
		echo "AMD (i)GPU found, drivers will be installed"
		AMD="xf86-video-amdgpu vulkan-radeon libva-mesa-driver"
	else
		AMD=""
	fi

# Packages
	BASE="bash bzip2 coreutils cryptsetup device-mapper dhcpcd diffutils e2fsprogs file filesystem findutils gawk gcc-libs gettext glibc grep gzip inetutils iproute2 iputils jfsutils less licenses linux logrotate lvm2 man-db man-pages mdadm nano netctl pacman pciutils perl procps-ng psmisc reiserfsprogs s-nail sed shadow sysfsutils systemd-sysvcompat tar texinfo usbutils util-linux vi which xfsprogs"
	BASE_DEVEL="autoconf automake binutils bison fakeroot file findutils flex gawk gcc gettext grep groff gzip libtool m4 make pacman patch pkgconf sed sudo systemd texinfo util-linux which"
	PACKAGES="$BASE $BASE_DEVEL $DE $DM $COMPOSITOR $CUSTOM_PACKAGES $OTHER_CUSTOM_PACKAGES mesa xorg-server networkmanager grub efibootmgr go unzip p7zip unrar curl wget git pulseaudio vlc zsh openssh vim openvpn networkmanager-openvpn arandr udiskie"
	AUR_PACKAGES="$AUR_CUSTOM_PACKAGES $AUR_OTHER_CUSTOM_PACKAGES"

# unmounting drives
	echo "-==Unmounting Drives==-"
	if $NVME; then
		umount ${TARGET_DRIVE}p1 /mnt/boot
	else
		umount ${TARGET_DRIVE}1 /mnt/boot
	fi
	if $NVME; then
		umount ${TARGET_DRIVE}p2 /mnt/
	else
		umount ${TARGET_DRIVE}2 /mnt/
	fi

# installing arch
	echo "-==Starting Arch Installation==-"
	timedatectl set-ntp true

	echo "-==Checking If System Is Capeable Of EFI==-"
	if ls /sys/firmware/efi/efivars > /dev/null 2>&1; then
		EFI=true
	else
		EFI=false
	fi

	echo "-==Checking If $TARGET_DRIVE Is An SSD==-"
	if [ "$(cat /sys/block/$(echo $TARGET_DRIVE | cut -d'/' -f3)/queue/rotational)" = "0" ]; then
		SSD=true
		echo "-==$TARGET_DRIVE Is An SSD, Trim Will Be Enabled For Cryptsetup==-"
	fi

	echo "-==Formatting Drives/Partitions==-"
	sgdisk -og $TARGET_DRIVE
	if $EFI; then
		sgdisk -n 1:0:+512M -c 1:"EFI" -t 1:ef00 $TARGET_DRIVE
	fi
	SYSTEM_PARTITION=$(if $EFI; then echo 2; else echo 1; fi)
	sgdisk -n $SYSTEM_PARTITION:0:0 -c $SYSTEM_PARTITION:"System" -t $SYSTEM_PARTITION:8300 $TARGET_DRIVE

	if $NVME; then
		if $EFI; then
			mkfs.fat -F32 ${TARGET_DRIVE}p1
		fi
		if $ENCRYPT_DRIVE; then
			cryptsetup -y -v luksFormat --type luks2 ${TARGET_DRIVE}p$SYSTEM_PARTITION
			cryptsetup open $(if $SSD; then echo "--allow-discards"; fi) ${TARGET_DRIVE}p$SYSTEM_PARTITION cryptroot
			mkfs.$FILESYSTEM /dev/mapper/cryptroot
		else
			mkfs.$FILESYSTEM ${TARGET_DRIVE}p$SYSTEM_PARTITION
		fi
	else
		if $EFI; then
			mkfs.fat -F32 ${TARGET_DRIVE}1
		fi
		if $ENCRYPT_DRIVE; then
			cryptsetup -y -v luksFormat --type luks2 ${TARGET_DRIVE}2
			cryptsetup open $(if $SSD; then echo "--allow-discards"; fi) $TARGET_DRIVE$SYSTEM_PARTITION cryptroot
			mkfs.$FILESYSTEM /dev/mapper/cryptroot
		else
			mkfs.$FILESYSTEM $TARGET_DRIVE$SYSTEM_PARTITION
		fi
	fi

	sgdisk -p ${TARGET_DRIVE}

	echo "-==Mouting Formatted Drives==-"
	if $ENCRYPT_DRIVE; then
		mount /dev/mapper/cryptroot /mnt
	else
		if $NVME; then
				mount ${TARGET_DRIVE}p$SYSTEM_PARTITION /mnt/
		else
			mount $TARGET_DRIVE$SYSTEM_PARTITION /mnt/
		fi
	fi
	if $EFI; then
		mkdir /mnt/boot/
		if $NVME; then
			mount ${TARGET_DRIVE}p1 /mnt/boot
		else
			mount ${TARGET_DRIVE}1 /mnt/boot
		fi
	fi

# Install packages
	echo "-==Installing Base Packages==-"
	if [[ "$INTERFACE" == KDE && "$DISPLAYMANAGER" == "$sddm" ]]; then
  	pacstrap /mnt $PACKAGES sddm-kcm
	else
		pacstrap /mnt $PACKAGES
	fi

# Installing yay
	echo "-==Installing Yay==-"
	arch-chroot /mnt git clone https://aur.archlinux.org/yay.git
	arch-chroot /mnt cd yay/
	arch-chroot /mnt makepkg -si
	arch-chroot /mnt yay -S $AUR_DM $AUR_PACKAGES

# Installing blackarch
	if [ "$BLACKARCH" == "true" ]; then
		echo "-==Adding BlackArch Repository==-"
		arch-chroot /mnt curl -O https://blackarch.org/strap.sh
		arch-chroot /mnt chmod +x strap.sh
		arch-chroot /mnt ./strap.sh
		echo "-==Installing BlackArch tools==-"
		arch-chroot /mnt pacman -S blackarch
	fi

# Encrypt drive
	if $ENCRYPT_DRIVE; then
		echo "-==configuring mkinitcpio.conf and grub config for encryption==-"
		sed -i "s/^HOOKS=.*/HOOKS=(base udev autodetect keyboard keymap consolefont modconf block encrypt filesystems fsck)/" /mnt/etc/mkinitcpio.conf
		sed -ir "s/^GRUB_CMDLINE_LINUX_DEFAULT=\"([^\s\s]*)\"/GRUB_CMDLINE_LINUX_DEFAULT=\"\1 cryptdevice=UUID=device-UUID:cryptroot$(if $SSD; then echo ":allow-discards"; fi) root=\/dev\/mapper\/cryptroot\"/" /mnt/etc/default/grub
	fi

# Generate fstab
	echo "-==Generating FS Tab==-"
	genfstab -U /mnt >> /mnt/etc/fstab

# Configure timezone
	echo "-==Configuring Time Zone==-"
	arch-chroot /mnt ln -sf /usr/share/zoneinfo/$TIMEZONE /etc/localtime
	arch-chroot /mnt hwclock --systohc

# Configure locale
	echo "-==Configuring Locale==-"
	echo "$LOCALE" >> /mnt/etc/locale.gen
	arch-chroot /mnt locale-gen
	echo "LANG=$(echo $LOCALE | cut -d' ' -f1)" >> /mnt/etc/locale.conf
	echo "KEYMAP=$KEYMAP" >> /mnt/etc/vconsole.conf

# Add user
	echo "-==Adding Normal User==-"
	arch-chroot /mnt useradd -m -g users -G wheel -s /bin/bash $USERNAME
	echo "root:$ROOT_PWD" | chpasswd -R /mnt
	echo "$USERNAME:$PWD" | chpasswd -R /mnt
	arch-chroot /mnt echo "$USERNAME ALL=(ALL) ALL" > /etc/sudoers

# Set hostname
	echo "-==Setting Hostname==-"
	echo "$HOSTNAME" > /mnt/etc/hostname
	echo "127.0.0.1 localhost $HOSTNAME" >> /mnt/etc/hosts

# Install grub
	echo "-==Installing GRUB==-"
	arch-chroot /mnt mkinitcpio -p linux
	arch-chroot /mnt grub-install --recheck $(if $EFI; then echo "--target=x86_64-efi --efi-directory=/boot --bootloader-id=$BOOTLOADER_ID"; else echo "--target=i386-pc $TARGET_DRIVE"; fi)
	echo "-==Creating GRUB Configuration==-"
	arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg

# Enable services
	echo "-==Enabling Services==-"
	arch-chroot /mnt systemctl enable NetworkManager
	if [ "$DISPLAYMANAGER" != "nodm" ]; then
		arch-chroot /mnt systemctl enable $DISPLAYMANAGER
	fi
	arch-chroot /mnt systemctl enable ntpd
	arch-chroot /mnt systemctl enable tor

	echo "-==Arch Is Ready To Be Used==-"