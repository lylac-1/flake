# :snowflake: nixos as a flakes w/home-manager & agenix
**my NixOS systems configurations** :beginner:

:warning: *I'm new here, I wouldn't expect any of this to work! blindly copying config is asking for a debuging nightmare!* :warning:

- :stars: garden
  - desktop system
  - will be updated often and is expected to regularly be broken, I'll point here alot when looking for help
  - most funkery will first be tried here
- :hibiscus: aurelia
  - main server host
  - runs all of https://aurelia.cafe
  - planned VPN and mail server setup soon :tm:
- :moon: lunar
  - laptop, dual boots win10
  - largely follows garden, tweaks made mostly to account for no 2nd display and some misc hardware ID differences such as wpctl and display names

## layout
```
flake
│   README.md ( you are here )
│   flake.nix
└───hosts
│   └───$Hostname
│       │   default.nix
│       │   hardware.nix
│       └───Users
│       │   │   $username.nix
│       *   *
└───modules
│   └───programs
│   └───services
└───secrets
    │   secrets.nix
    │   *key.age
    *    
```
## why *
- single btrfs part for simplicity ( intend to look into encryption soon for laptop )
- all programs/services in ./ level "modules" to encourage myself to minimize repeating config
- secrets managed with agenix for reproducable portability reliable on a single key.. ( should seperate out server secrets for theroetical security improvement )
- all custom module types included as if normal because i either 
  1. dont intend to ever try to upstream
  2. dont beleive is up to standard to upstream
- per user home manager setups as conditional importing minimizing rewriting code


![image](https://user-images.githubusercontent.com/102007132/220453204-9848276c-bf31-4081-8b62-ea11c950765a.png)

## notes
 **system update**
- `nix flake update`
- `nixos-rebuild switch --flake .#foo --use-remote-sudo`

**git update**
- `git commit -a -m "bar"`
- `git push` 

**partitioning**
- https://nixos.wiki/wiki/Btrfs
- `["rw" "compress=zstd:9" "thread_pool=16" "space_cache=v2" "noatime" "discard" "ssd" "subvol=foo"]`

## misc
**helpful resources**
- https://ayats.org/blog/channels-to-flakes



github users checkout https://tea.aurelia.cafe/lylac/flake :p 