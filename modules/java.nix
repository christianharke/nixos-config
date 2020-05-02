{ config, pkgs, ... }:

let

  java8 = pkgs.openjdk8;
  
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
