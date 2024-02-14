rec {
  f = mk: (x: builtins.mapAttrs (
    k: v: if (builtins.typeOf v) == "set" then f mk v else mk v
  ) x);
}.f
