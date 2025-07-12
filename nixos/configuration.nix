# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  # nix flake
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
   
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  #boot.loader.efi.canTouchEfiVariables = true;
 # boot.loader.grub.enable = true;
 # boot.loader.grub.devices = [ "nodev" ];
 # boot.loader.grub.efiSupport = true;
 # boot.loader.grub.useOSProber = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Jakarta";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.alfath = {
    isNormalUser = true;
    description = "alfath";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # tambah buat gtop biar bisa masang ektensi 
  environment.variables = {
	GI_TYPELIB_PATH = "/run/current-system/sw/lib/girepository-1.0";
  };
  
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  	#gnome extension
  	gnome-software
  	libgtop
  	plasma5Packages.kdeconnect-kde
  	lm_sensors #lm-sensors-3.6.0
  	
  	#messaging
  	#beeper #beeper-4.0.661
	discord #discord-0.0.94
	
	#kebutuhan 
	flatpak #flatpak-1.16.1
	git #git-2.49.0
	
	#ricing
	gnome-tweaks #gnome-tweaks-46.1
	gradience #gradience-0.4.1
	
	#terminal use
	neofetch #neofetch-unstable-2021-12-10
	steam-run
	#librechat-0.7.8
	fish
	nh #nix helper
	
	gemini-cli

  	# teks editor
  	vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  	zed-editor #zed-editor-0.186.8
  	
  	#ide
  	#android-studio
  	
  #  wget
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  
  # List services that you want to enable:
  


  # Tambahkan ini di dalam blok konfigurasi utama
  #programs.nix-ld = {
  #  enable = true;
  #  libraries = with pkgs; [
      # Daftar library dasar yang biasanya diperlukan
  #    stdenv.cc.cc
  #    zlib
  #    openssl
  #    glib
  #    nss
  #    nspr
  #    gtk3
  #    libGL
  #  ];
  #};
  
  #nix.gc = {
  #  automatic = true;
  #  dates = "daily"; #"weekly", "monthly", dll
  #  options = "--delete-older-than 1d";
  #};
  
  #opsional: mengoptimalkan store untuk menghemat ruang
  # nix.settings.auto-optimise-store = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  
  services.flatpak.enable = true;
  programs.kdeconnect.enable = true;
  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 1716 ];
  networking.firewall.allowedUDPPorts = [ 1716 ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
