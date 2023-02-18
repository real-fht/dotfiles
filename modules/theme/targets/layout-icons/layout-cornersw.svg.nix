{
  config,
  lib,
  ...
}:
lib.mkIf config.fht.theme.targets.awesomewm.enable {
  home.xdg.configFile."theme/awesome/layout-icons/layout-cornersw.svg".text = with config.fht.theme.colors.withHashtag; ''    <svg width="128" height="128" viewBox="0 0 128 128" fill="none" xmlns="http://www.w3.org/2000/svg">
    <g clip-path="url(#clip0_24_33)">
    <rect x="91" y="128" width="91" height="91" rx="8" transform="rotate(180 91 128)" fill="${accent}"/>
    <rect x="128" y="128" width="27" height="91" rx="8" transform="rotate(180 128 128)" fill="${white}"/>
    <rect x="91" y="27" width="91" height="27" rx="8" transform="rotate(180 91 27)" fill="${white}"/>
    <rect x="128" y="27" width="27" height="27" rx="8" transform="rotate(180 128 27)" fill="${accent}"/>
    </g>
    <defs>
    <clipPath id="clip0_24_33">
    <rect width="128" height="128" fill="white"/>
    </clipPath>
    </defs>
    </svg>'';
}
