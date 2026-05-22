{
  stdenv,
  acpica-tools,
  cpio
}:

stdenv.mkDerivation {
  name = "custom-dsdt";
  src = ./.; # dsdt.dsl is stored here

  phases = [ "unpackPhase" "installPhase" ];

  nativeBuildInputs = [
    acpica-tools
    cpio
  ];

  installPhase = ''
    mkdir -p $out/
    mkdir -p kernel/firmware/acpi

    iasl -p ./dsdt -sa $src/dsdt.dsl

    cp dsdt.aml kernel/firmware/acpi/DSDT.aml
    find kernel | cpio -H newc --create > $out/dsdt.cpio
  '';
}