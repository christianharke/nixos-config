{ config, pkgs, ...}:

{

  services.printing = {
    enable = true;
    drivers = [ pkgs.hplipWithPlugin ];
  };

  hardware = {
    printers.ensurePrinters = [{
      name = "pr-hp-chr";
      location = "Home Office";
      description = "HP Officejet Pro 8600 Plus";
      deviceUri = "socket://pr-hp-chr";
      model = "drv:///hp/hpcups.drv/hp-officejet_pro_8600.ppd";
      ppdOptions = {
        "PageSize" = "A4";
        "Duplex" = "DuplexNoTumble";
        "InputSlot" = "Tray2";
        "ColorModel" = "RGB";
        "MediaType" = "Plain";
        "OutputMode" = "Normal";
        "OptionDuplex" = "True";
      };
    }];

    sane = {
      enable = true;
      extraBackends = [ pkgs.hplipWithPlugin ];
    };
  };

  environment.systemPackages = [
    pkgs.unpaper
  ];

}
