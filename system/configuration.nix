{ pkgs, ... }:

let
  elegantTheme = pkgs.stdenv.mkDerivation {
    name = "elegant-grub2-forest-window-right-dark";
    src = pkgs.fetchFromGitHub {
      owner = "vinceliuice";
      repo = "Elegant-grub2-themes";
      rev = "92cdac334cf7bc5c1d68c2fbb266164653b4b502";
      hash = "sha256-fbZLWHxnLBrqBrS2MnM2G08HgEM2dmZvitiCERie0Cc=";
    };
    installPhase = ''
      mkdir -p $out
      cp common/terminus-*.pf2 $out/
      cp common/unifont-16.pf2 $out/
      cp backgrounds/backgrounds-forest/background-forest-window-right-dark.jpg $out/background.jpg
      cp config/theme-window-right-dark-1080p.txt $out/theme.txt
      cp assets/assets-other/other-1080p/select_e-forest-dark.png $out/select_e.png
      cp assets/assets-other/other-1080p/select_c-forest-dark.png $out/select_c.png
      cp assets/assets-other/other-1080p/select_w-forest-dark.png $out/select_w.png
      cp assets/assets-other/other-1080p/window-right-alt.png $out/info.png
      cp assets/assets-other/other-1080p/Default.png $out/logo.png
      cp -r assets/assets-icons-dark/icons-dark-1080p $out/icons
    '';
  };
in
{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
    configurationLimit = 5;
    useOSProber = true;
    theme = elegantTheme;
  };
  boot.supportedFilesystems = [ "ntfs" ];

  services.udisks2.enable = true;

  services.gvfs.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
        FastConnectable = true;
      };
      Policy = {
        AutoEnable = true;
      };
    };
  };

  networking.hostName = "ricky-laptop";
  networking.networkmanager.enable = true;
  networking.nameservers = [ "1.1.1.1" "1.0.0.1" ];

  virtualisation.docker.enable = true;

  time.timeZone = "Europe/Lisbon";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_PT.UTF-8";
    LC_IDENTIFICATION = "pt_PT.UTF-8";
    LC_MEASUREMENT = "pt_PT.UTF-8";
    LC_MONETARY = "pt_PT.UTF-8";
    LC_NAME = "pt_PT.UTF-8";
    LC_NUMERIC = "pt_PT.UTF-8";
    LC_PAPER = "pt_PT.UTF-8";
    LC_TELEPHONE = "pt_PT.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.xserver.enable = true;
  services.resolved.enable = true;

  services.xserver.xkb = {
    layout = "us";
    options = "caps:escape";
  };

  services.displayManager.gdm.enable = false;
  services.desktopManager.gnome.enable = true;

  services.displayManager.sddm = {
    enable = true;
    package = pkgs.kdePackages.sddm;
    autoNumlock = true;
  };

  programs.silentSDDM = {
    enable = true;
    theme = "catppuccin-mocha";
  };

  services.tailscale.enable = true;

  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.ricky = {
    isNormalUser = true;
    shell = pkgs.fish;
    description = "ricky";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };

  programs.firefox.enable = true;

  programs.hyprland.enable = true;

  programs.fish.enable = true;

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  fonts.packages = [ pkgs.nerd-fonts.fira-code ];

  fonts.fontconfig.enable = true;
  environment.systemPackages = with pkgs; [
    kdePackages.qtdeclarative
    kdePackages.qtsvg
    kdePackages.qtmultimedia
    ntfs3g
  ];
  system.stateVersion = "25.11";
}

