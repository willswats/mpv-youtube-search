{ lib, stdenvNoCC, fetchFromGitHub }:

stdenvNoCC.mkDerivation rec {
  pname = "mpv-youtube-search";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "willswats";
    repo = "mpv-youtube-search";
    rev = "v${version}";
    sha256 = "sha256-LD3uhE0uELlOZlSbWe2+sqozqOmfRY4m75Cxu3LgUaw=";
  };

  dontBuild = true;

  installPhase = ''
    runHook preInstall
    install -D -t $out/share/mpv/scripts youtube-search.lua
    runHook postInstall
  '';

  passthru.scriptName = "youtube-search.lua";

  meta = with lib; {
    description = "This mpv script uses the mpv console input to search YouTube or YouTube Music and add the results to the mpv playlist.";
    homepage = "https://github.com/willswats/mpv-youtube-search";
    license = licenses.mit;
    platforms = platforms.all;
  };
}
