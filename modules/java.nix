{ config, pkgs, ... }:

let

  v = import ../nixversions.nix {};
  java8 = v.pkgsUnstable.pkgs.openjdk8;
  java11 = pkgs.openjdk11;
  
in

{
  environment = {
    systemPackages = [
      java8
      java11
    ];

    variables = {
      JAVA_HOME = "${java8}/lib/openjdk";
      JAVA8_HOME = "${java8}/lib/openjdk";
      JAVA11_HOME = "${java11}/lib/openjdk";
      JDK_HOME = "${java8}/lib/openjdk";
      JDK8_HOME = "${java8}/lib/openjdk";
      JDK11_HOME = "${java11}/lib/openjdk";
    };
  };
}
