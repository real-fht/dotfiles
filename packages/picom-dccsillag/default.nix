{
  picom,
  fetchFromGitHub,
  ...
}:
picom.overrideAttrs (oldAttrs: rec {
  pname = "picom-dccsillag";
  version = "9";
  # Pinning unstable to allow usage with flakes and limit rebuilds.
  src = builtins.fetchGit {
    url = "https://github.com/dccsillag/picom";
    rev = "51b21355696add83f39ccdb8dd82ff5009ba0ae5";
    ref = "implement-window-animations";
  };

  meta = {
    description = "A fork of picom featuring smooth animations.";
    homepage = "https://github.com/dccsillag/picom";
  };
})
