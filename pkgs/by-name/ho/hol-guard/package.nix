{
  lib,
  fetchurl,
  python3Packages,
}:

python3Packages.buildPythonApplication (finalAttrs: {
  pname = "hol-guard";
  version = "3.0.181";
  pyproject = true;

  src = fetchurl {
    url = "https://pypi.org/packages/source/h/hol-guard/hol_guard-${finalAttrs.version}.tar.gz";
    hash = "sha256-8n0PW0Nc/+5/qdU3eCG1ZBHg8/RfgbNe9pvT/6RgpPQ=";
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
