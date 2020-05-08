{ pkgs, config, ... }:

let

   acc = config.accounts."bluecare/hin-id";

in

{
  services.hinclient = {
    enable = true;
    identities = acc.username;
    passphrase = acc.password;
    keystore = /home/christian/.accounts/bluecare/hin/chrihar1.hin;
    httpProxyPort = 5016;
    clientapiPort = 5017;
    smtpProxyPort = 5018;
    pop3ProxyPort = 5019;
    imapProxyPort = 5020;
  };
}
