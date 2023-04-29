{ ... }:

{

  programs.ssh.enable = true;

  home.file.".ssh/id_ed25519.pub".text = 
''
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKvWBwM05NhjDy+TaXqwEXJws4wt3jmuoVWkdsmCSf75 neith
'';

}