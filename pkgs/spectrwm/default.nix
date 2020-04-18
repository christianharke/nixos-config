{ stdenv
, fetchgit
, coreutils
, pkg-config
, xorg
, xcb-util-cursor
}:

stdenv.mkDerivation rec {
  name = "spectrwm-${version}";
  version = "3.3.0";

  src = fetchgit {
    rev = "SPECTRWM_3_3_0";
    url = "https://github.com/conformal/spectrwm";
    sha256 = "1dzivf587sk79y3jz6xxmxlccma6plqq101yib6g9pq3prsxp8g9";
  };


  buildInputs = [
    pkg-config
    xcb-util-cursor
    xorg.libX11
    xorg.libxcb
    xorg.libXrandr
    xorg.libXcursor
    xorg.libXft
    xorg.libXt
    xorg.xcbutil
    xorg.xcbutilkeysyms
    xorg.xcbutilwm
  ];

  postUnpack = ''
    export sourceRoot=$sourceRoot/linux
  '';
  makeFlags="PREFIX=${placeholder "out"}";
  installPhase = "make install $makeFlags";

  meta = with stdenv.lib; {
    description = "A tiling window manager";
    homepage    = "https://github.com/conformal/spectrwm";
    maintainers = with maintainers; [ jb55 ];
    license     = licenses.isc;
    platforms   = platforms.all;

    longDescription = ''
      spectrwm is a small dynamic tiling window manager for X11. It
      tries to stay out of the way so that valuable screen real estate
      can be used for much more important stuff. It has sane defaults
      and does not require one to learn a language to do any
      configuration. It was written by hackers for hackers and it
      strives to be small, compact and fast.
    '';
  };

}
