{ config, pkgs, ... }:

let

  v = import ../nixversions.nix {};
  java8 = v.pkgsUnstable.pkgs.openjdk8;
  
in

{
  environment = {
    systemPackages = [
      java8
    ];

    variables = {
      JAVA_HOME = "${java8}/lib/openjdk";
      JDK_HOME = "${java8}/lib/openjdk";
    };
  };

}
