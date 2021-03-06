{
  description = ''Bencode serialization/deserialization library'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs."bencode-master".dir   = "master";
  inputs."bencode-master".owner = "nim-nix-pkgs";
  inputs."bencode-master".ref   = "master";
  inputs."bencode-master".repo  = "bencode";
  inputs."bencode-master".type  = "github";
  inputs."bencode-master".inputs.nixpkgs.follows = "nixpkgs";
  inputs."bencode-master".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@inputs:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib"];
  in lib.mkProjectOutput {
    inherit self nixpkgs;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
    refs = builtins.removeAttrs inputs args;
  };
}