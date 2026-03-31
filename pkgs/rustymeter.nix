{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "rustymeter";
  version = "v0.4.1";

  src = fetchFromGitHub {
    owner = "markusdd";
    repo = "rusty_meter";
    tag = finalAttrs.version;
    hash = "";
  };

  cargoHash = "";

  meta = {
    description = "OWON Multimeter UI";
    homepage = "https://github.com/markusdd/rusty_meter";
    license = lib.licenses.mit;
    maintainers = [ ];
  };
})
