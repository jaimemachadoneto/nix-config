#############################################################
#
#  Ghost - Main Desktop
#  NixOS running on Ryzen 5 3600X, Radeon RX 5700 XT, 64GB RAM
#
###############################################################

{ inputs
, flake
, lib
, config
, pkgs
, ...
}:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  imports = lib.flatten [
    #
    # ========== Hardware ==========
    #
    self.nixosModules.default
    self.nixosModules.gui
    ./hardware-configuration.nix

    #
    # ========== Disk Layout ==========
    #

    #
    # ========== Misc Inputs ==========
    #
    ../../common/core
    # (map lib.custom.relativeToRoot [
    #   #
    #   # ========== Required Configs ==========
    #   #
    #   "configurations/common/core"

    #   #
    #   # ========== Optional Configs ==========
    #   #

    # ])
    #
    # ========== Ghost Specific ==========
    #

  ];

  #
  # ========== Host Specification ==========
  #

  # hostSpec = {
  #   hostName = "jaime-note";
  #   useYubikey = lib.mkForce false;
  #   # hdr = lib.mkForce true;
  # };

  # set custom autologin options. see greetd.nix for details
  #  autoLogin.enable = true;
  #  autoLogin.username = config.hostSpec.username;
  #
  #  services.gnome.gnome-keyring.enable = true;

  networking = {
    networkmanager.enable = true;
    enableIPv6 = false;
  };

  #FIXME(clamav): something not working. disabled to reduce log spam


  boot.loader = {
    systemd-boot = {
      enable = true;
      # When using plymouth, initrd can expand by a lot each time, so limit how many we keep around
      configurationLimit = lib.mkDefault 10;
    };
    efi.canTouchEfiVariables = true;
    timeout = 3;
  };

  boot.initrd = {
    systemd.enable = true;
  };

  #TODO(stylix): move this stuff to separate file but define theme itself per host
  # host-wide styling

  #hyprland border override example
  #  wayland.windowManager.hyprland.settings.general."col.active_border" = lib.mkForce "rgb(${config.stylix.base16Scheme.base0E});

  # https://wiki.nixos.org/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.11";
}


# # See /modules/nixos/* for actual settings
# # This file is just *top-level* configuration.
# { flake, ... }:

# let
#   inherit (flake) inputs;
#   inherit (inputs) self;
# in
# {
#   imports = [
#     self.nixosModules.default
#     self.nixosModules.gui
#     ./configuration.nix
#   ];
#   # hostSpec = {
#   #   hostname = "jaime-note";
#   #   domain = "local";
#   # };
#   # Enable home-manager for "runner" user
#   home-manager.users."jaime" = {
#     imports = [ (self + /configurations/home/jaime2.nix) ];
#   };
# }
