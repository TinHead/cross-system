let
  #revision = "d5f237872975e6fb6f76eef1368b5634ffcd266f";
  revision = "d2c76997f94d8a30979aef161515e24a3e69fe19";
in
import (builtins.fetchTarball {
  url = "https://github.com/NixOS/nixpkgs/archive/${revision}.tar.gz";
#  sha256 = "0fsjwhqgxyd2v86glr2560gr3zx9mb6fhllydmrxi5i04c549vsr";
 sha256 = "1sl0k0r6rbxd0v6p2rfysj7jmryzwjxicn35x4j7zj62x0k977m8";
})
