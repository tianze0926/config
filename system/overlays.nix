{ inputs, outputs, ... }: {
  nixpkgs.overlays = [
    outputs.overlays.stable-packages
    inputs.nur.overlay
  ];

}
