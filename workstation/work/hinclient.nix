{ pkgs, config, ... }:

let

   acc = config.accounts."bluecare/hin-id";

in

{
  services.hinclient = {
    enable = false;
    identities = acc.username;
    passphrase = acc.password;
    keystore = /home/christian/.accounts/bluecare/hin + "/${acc.username}.hin";
    httpProxyPort = 5016;
    clientapiPort = 5017;
    smtpProxyPort = 5018;
    pop3ProxyPort = 5019;
    imapProxyPort = 5020;
  };
}
