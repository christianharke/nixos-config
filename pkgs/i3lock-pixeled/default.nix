{ stdenv, pkgs, i3lock, imagemagick, scrot, playerctl, fetchFromGitLab }:

stdenv.mkDerivation rec {
  pname = "i3lock-pixeled";
  version = "1.2.1";

  src = fetchFromGitLab {
    owner = "christianharke";
    repo = "i3lock-pixeled";
    rev = "take-new-screenshot-each-time";
    sha256 = "1z342m2a68acy4pk4kqc3fv1spkd0fc40rq39rc6vdpqx2rcm846";
  };

  propagatedBuildInputs = [
    i3lock
    imagemagick
    scrot
    playerctl
  ];

  makeFlags = [
    "PREFIX=$(out)/bin"
  ];

  patchPhase = ''
    substituteInPlace i3lock-pixeled \
       --replace i3lock    "${i3lock}/bin/i3lock" \
       --replace convert   "${imagemagick}/bin/convert" \
       --replace scrot     "${scrot}/bin/scrot" \
       --replace playerctl "${playerctl}/bin/playerctl"
  '';

  meta = with pkgs.lib; {
    description = "Simple i3lock helper which pixels a screenshot by scaling it down and up to get a pixeled version of the screen when the lock is active.";
    homepage = "https://gitlab.com/Ma27/i3lock-pixeled";
    license = licenses.mit;
    platforms = platforms.linux;
    maintainers = with maintainers; [ ma27 ];
  };
}
