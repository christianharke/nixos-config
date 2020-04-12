{ config, pkgs, ... }:

let

  unstable = import <nixos-unstable> {};
  java8 = unstable.openjdk8;
  
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
