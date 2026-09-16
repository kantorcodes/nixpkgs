{
  appimageTools,
  fetchurl,
  lib,
}:
let
  pname = "hol-guard-desktop";
  version = "3.0.86";

  src = fetchurl {
    url = "https://github.com/hashgraph-online/hol-guard-desktop/releases/download/desktop-v${version}/HOL-Guard-Desktop-${version}-x86_64.AppImage";
    hash = "sha256-qvNXCwTdsrOESB26Dq5OaFp+rzMUmr0FKaMNxXeFMu8=";
  };
in
appimageTools.wrapType2 {
  inherit pname version src;

  meta = {
    description = "Desktop app for HOL Guard, an open-source antivirus for AI agents";
    homepage = "https://hol.org/guard";
    license = lib.licenses.asl20;
    maintainers = [ ];
    platforms = [ "x86_64-linux" ];
    mainProgram = "hol-guard-desktop";
  };
}
