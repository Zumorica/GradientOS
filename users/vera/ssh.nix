{ ... }:

{

  programs.ssh.enable = true;

  home.file.".ssh/id_ed25519.pub".text = 
''
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOH4ZOMQX/C9x2s4D7mvP7ip1ll+Nhar+tCJiTpy1DuY vera@miracle-crusher
'';

}