
{ config, pkgs, ... }: 

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Helsinki";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fi_FI.UTF-8";
    LC_IDENTIFICATION = "fi_FI.UTF-8";
    LC_MEASUREMENT = "fi_FI.UTF-8";
    LC_MONETARY = "fi_FI.UTF-8";
    LC_NAME = "fi_FI.UTF-8";
    LC_NUMERIC = "fi_FI.UTF-8";
    LC_PAPER = "fi_FI.UTF-8";
    LC_TELEPHONE = "fi_FI.UTF-8";
    LC_TIME = "fi_FI.UTF-8";
  };

  # X Server / Configure keymap in X11
  services.xserver = {
    layout = "fi";
    xkbVariant = "";
    enable = true;
    windowManager.i3.enable = true;     #i3wm
  };

  virtualisation.virtualbox.guest.enable = true;
  virtualisation.virtualbox.guest.draganddrop = true;
  virtualisation.virtualbox.guest.clipboard = true;

  # Configure console keymap
  console.keyMap = "fi";

  # Define user account
  users.users.eetu = {
    isNormalUser = true;
    description = "Eetu";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };
  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Packages to include
  environment.systemPackages = with pkgs; [

    # System utilities
    networkmanagerapplet
    alacritty             # terminal emulator
    kitty                 # terminal emulator
    vim                   # text editor
    vscode                # text editor gui
    tmux                  # terminal multiplexer
    htop                  # process manager 
    btop                  # process manager
    xfce.thunar           # file manager
    git                   # git
    nitrogen              # wallpaper setter
    feh                   # light image viewer / wallpaper setter
    unzip                 # .zip etc
    
    # Apps etc..
    firefox         # browser
    brave           # browser
    github-desktop  # Github GUI

    # Dev
    nodejs_20       # nodejs
    
    # Funzone
    cmatrix         
    cbonsai         
    neofetch        
  ];

  fonts.fonts = with pkgs; [
    nerdfonts
  ];
  
  #----=[ Fonts ]=----#
  fonts = {
    enableDefaultFonts = true;

    fontconfig = {
      defaultFonts = {
        serif = [ "Hack" ];
        sansSerif = [ "Hack" "Ubuntu" ];
        monospace = [ "Hack" ];
      };
    };
  };

  # Keyring for storing secrets (i3 requires this for Github GUI etc.)
  services.gnome.gnome-keyring.enable = true;
  
  # Insecure packages
  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1w"
  ];

  # Setting aliases
  environment.shellAliases = {
    l = "ls -alh";
    ll = "ls -l";
    ls = "ls --color=tty";

    nixrb = "sudo nixos-rebuild switch";
    nixrbh = "sudo nixos-rebuild switch -I nixos-config=/home/eetu/linux-configs/nixos/configuration.nix";
    nixconf = "sudo vim /etc/nixos/configuration.nix";
    nixcpconf = "sudo cp /home/eetu/linux-configs/nixos/configuration.nix /etc/nixos/";
    
    m = "cmatrix";
    b = "cbonsai";
  };

  system.stateVersion = "24.05"; 

}
