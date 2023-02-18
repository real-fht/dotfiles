{
  config,
  lib,
  ...
}:
lib.mkIf config.fht.theme.targets.awesomewm.enable {
  home.xdg.configFile."theme/awesome/layout-icons/layout-cornerse.svg".text = with config.fht.theme.colors.withHashtag; ''    <svg width="128" height="128" viewBox="0 0 128 128" fill="none" xmlns="http://www.w3.org/2000/svg">
    <g clip-path="url(#clip0_24_28)">
    <rect width="91" height="91" rx="8" transform="matrix(1 0 0 -1 37 128)" fill="${accent}"/>
    <rect width="27" height="91" rx="8" transform="matrix(1 0 0 -1 0 128)" fill="${white}"/>
    <rect width="91" height="27" rx="8" transform="matrix(1 0 0 -1 37 27)" fill="${white}"/>
    <rect width="27" height="27" rx="8" transform="matrix(1 0 0 -1 0 27)" fill="${accent}"/>
    </g>
    <defs>
    <clipPath id="clip0_24_28">
    <rect width="128" height="128" fill="white"/>
    </clipPath>
    </defs>
    </svg>'';
}
