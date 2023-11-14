{ inputs, outputs, ... }: {
  nixpkgs.overlays = [
    (final: _prev: {
      stable = import inputs.nixpkgs-stable {
        system = final.system;
        config.allowUnfree = false;
      };
    })
    inputs.nur.overlay
    (final: prev: {
      myRepo = inputs.myRepo.packages."${prev.system}";
    })
  ];

}
