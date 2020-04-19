{ config, pkgs, ...}:

{

  # Replace ssh-agent by gpg-agent
  # To make it taking care about the ssh key(s), do not forget to add it/them
  # by `ssh-add`

  programs = {
    ssh.startAgent = false;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  environment.systemPackages = [
    pkgs.pinentry
  ];

  security.pam.enableSSHAgentAuth = true;

}
