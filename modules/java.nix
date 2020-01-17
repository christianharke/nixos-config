{ config, pkgs, ... }:

let

  v = import ../nixversions.nix config;
  
in

{
  environment = {
    systemPackages = [
      v.pkgs1903.openjdk8
    ];

    variables = {
      JAVA_HOME = "${v.pkgs1903.openjdk8}/lib/openjdk";
      JDK_HOME = "${v.pkgs1903.openjdk8}/lib/openjdk";
    };
  };

}
