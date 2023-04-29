{ lib, ... }:

{

  programs.mosh.enable = true;
  
  programs.ssh = {
    startAgent = true;
    hostKeyAlgorithms = [ "ssh-ed25519" ];

    extraConfig = ''
Host * 
  IdentityFile /etc/ssh/ssh_host_ed25519_key
  IdentityFile ~/.ssh/id_ed25519
'';
  };

  # Enable the OpenSSH daemon.
  services.openssh = {
    
    enable = true;
    openFirewall = true;
    
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "yes";
    };

    knownHosts = {
      "github.com" = {
        publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl";
      };
    };

    hostKeys = [
      {
        path = "/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
    ];

  };

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOH4ZOMQX/C9x2s4D7mvP7ip1ll+Nhar+tCJiTpy1DuY vera@miracle-crusher"
  ];

}