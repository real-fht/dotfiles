{
  config,
  lib,
  ...
}:
lib.mkIf config.fht.theme.targets.awesomewm.enable {
  home.xdg.configFile."theme/awesome/layout-icons/layout-tilebottom.svg".text = with config.fht.theme.colors.withHashtag; ''
    <svg width="128" height="128" viewBox="0 0 128 128" fill="none" xmlns="http://www.w3.org/2000/svg">
    <g clip-path="url(#clip0_1_10)">
    <rect y="59" width="59" height="128" rx="8" transform="rotate(-90 0 59)" fill="${accent}"/>
    <rect x="46" y="128" width="59" height="36" rx="8" transform="rotate(-90 46 128)" fill="${white}"/>
    <rect x="92" y="128" width="59" height="36" rx="8" transform="rotate(-90 92 128)" fill="${white}"/>
    <path d="M8 128C3.58172 128 0 124.418 0 120L0 77C0 72.5817 3.58172 69 8 69H28C32.4183 69 36 72.5817 36 77V120C36 124.418 32.4183 128 28 128H8Z" fill="${white}"/>
    </g>
    <defs>
    <clipPath id="clip0_1_10">
    <rect width="128" height="128" fill="white"/>
    </clipPath>
    </defs>
    </svg>'';
}
