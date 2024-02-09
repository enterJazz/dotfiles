{ pkgs, ... }:
{
 home = {
    packages = with pkgs;
    [
      rg
    ];
  };

}
