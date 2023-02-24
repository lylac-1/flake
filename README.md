checkout https://tea.lylac.dev/lylac/flake :)
# :snowflake: nixos w/flakes + home-manager & agenix
my NixOS systems configurations

![image](https://user-images.githubusercontent.com/102007132/220453204-9848276c-bf31-4081-8b62-ea11c950765a.png)

## if you're here to reference
:warning: **dont blindly copy, I dont know what im doing after all**

this is public to keep record, share what I find to be neat.. and ask for help online lol


## just a note
`nix flake update`

`nixos-rebuild switch --flake .#${hostname} --use-remote-sudo`

`git commit -a -m "example"`

`git push -u origin main`

### installing to a new system 
`nixos-install --flake .#hostname`

#### huh?
users are per host to avoid splitting everything up too much to acomodate for how different the systems use cases are, this may change once my laptop is added as desktop and laptop may share plenty

as are programs for a similar organizational reason :thumbsup:


