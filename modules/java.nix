{ config, pkgs, ... }:

let

  java = pkgs.jdk;
  java8 = pkgs.jdk8;
  java11 = pkgs.jdk11;
  
in

{
  environment = {
    systemPackages = [
      java
      java8
      java11
    ];

    variables = {
      JAVA_HOME = "${java}/lib/openjdk";
      JAVA8_HOME = "${java8}/lib/openjdk";
      JAVA11_HOME = "${java11}/lib/openjdk";
      JDK_HOME = "${java}/lib/openjdk";
      JDK8_HOME = "${java8}/lib/openjdk";
      JDK11_HOME = "${java11}/lib/openjdk";
    };
  };
}
