{
  lib,
  fetchurl,
  python3Packages,
  versionCheckHook,
}:

python3Packages.buildPythonApplication (finalAttrs: {
  pname = "hol-guard";
  version = "3.0.189";
  pyproject = true;

  src = fetchurl {
    url = "https://pypi.org/packages/source/h/hol-guard/hol_guard-${finalAttrs.version}.tar.gz";
    hash = "sha256-XlKxbWpA6eAfVMENfg6M+pdsLmxT0U13RPh9u+MF8Iw=";
  };

  postPatch = ''
    substituteInPlace pyproject.toml \
      --replace-fail 'hatchling<1.31' 'hatchling'
  '';

  build-system = with python3Packages; [
    hatchling
  ];

  dependencies = with python3Packages; [
    cryptography
    idna
    jsonschema
    keyring
    mcp
    packaging
    publicsuffixlist
    pyyaml
    regex
    requests
    rich
  ];

  # Upstream pins these data/compatibility dependencies exactly. Nixpkgs
  # carries newer compatible releases.
  pythonRelaxDeps = [
    "idna"
    "publicsuffixlist"
  ];

  nativeCheckInputs = with python3Packages; [
    pythonRuntimeDepsCheckHook
    versionCheckHook
  ];

  pythonImportsCheck = [ "codex_plugin_scanner" ];
  versionCheckProgramArg = "--version";

  meta = {
    description = "Open-source antivirus and runtime protection for AI agents";
    homepage = "https://hol.org/guard";
    license = lib.licenses.asl20;
    mainProgram = "hol-guard";
    platforms = lib.platforms.unix;
  };
})
