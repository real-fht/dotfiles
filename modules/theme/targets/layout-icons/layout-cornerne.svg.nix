{
  config,
  lib,
  ...
}:
lib.mkIf config.fht.theme.targets.awesomewm.enable {
  home.xdg.configFile."theme/awesome/layout-icons/layout-cornerne.svg".text = with config.fht.theme.colors.withHashtag; ''
    <svg width="128" height="128" viewBox="0 0 128 128" fill="none" xmlns="http://www.w3.org/2000/svg">
    <g clip-path="url(#clip0_24_2)">
    <rect x="37" width="91" height="91" rx="8" fill="${accent}"/>
    <rect width="27" height="91" rx="8" fill="${white}"/>
    <rect x="37" y="101" width="91" height="27" rx="8" fill="${accent}"/>
    <rect y="101" width="27" height="27" rx="8" fill="${white}"/>
    </g>
    <defs>
    <clipPath id="clip0_24_2">
    <rect width="128" height="128" fill="white"/>
    </clipPath>
    </defs>
    </svg>'';
}
