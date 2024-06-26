# This is a flake that similates FHS environment,
# which can be used in development, such as python venv.
# Note that the nixpkgs version is set to match system flake's nixpkgs.

{ pkgs, inputs, ... }: let
  fhsGen = fishConfig: pkgs.writeText "fhs-flake.nix" ''
    {
      description = "A FHS development environment";

      inputs.nixpkgs.url = "github:nixos/nixpkgs/${inputs.nixpkgs.rev}";

      outputs = { self, nixpkgs }: let
        system = "x86_64-linux";
        pkgs = import nixpkgs { inherit system; };
      in {
        devShell."''${system}" = (pkgs.buildFHSEnv {
          name = "devenv-python";
          targetPkgs = pkgs: with pkgs; [
            libz # numpy
          ];
          runScript = "fish --init-command 'source ${fishConfig}'";
        }).env;
      };
    }
  '';
in {
  hm = [({ config, lib, ... }: let
    flake_dir = "${config.home.homeDirectory}/.cache/fhs-flake";
    flake = "${flake_dir}/flake.nix";
    fhs = fhsGen (pkgs.writeText "fhs-config.fish" config.fhsFishConfig);
  in {
    options.fhsFishConfig = with lib; mkOption {
      type = types.lines;
      default = "";
    };
    config.programs.fish.enable = true;
    # The reason of copying flake.nix from store instead of symlink is that:
    # nix would throw an error treating it as a symlink attack.
    # https://github.com/NixOS/nix/blob/4a1c3762df03fd20518f7aef25ee1027ac235032/src/libexpr/flake/flake.cc#L212
    config.programs.fish.functions.fhs = ''
      mkdir -p ${flake_dir}
      if [ \( ! -e ${flake} \) -o \( "$(cat ${fhs})" != "$(cat ${flake})" \) ]
        cp -f ${fhs} ${flake}
      end
      nix develop path:${flake_dir}
    '';
  })];
}
