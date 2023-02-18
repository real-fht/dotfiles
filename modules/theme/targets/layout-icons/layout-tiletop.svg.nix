{
  config,
  lib,
  ...
}:
lib.mkIf config.fht.theme.targets.awesomewm.enable {
  home.xdg.configFile."theme/awesome/layout-icons/layout-tiletop.svg".text = with config.fht.theme.colors.withHashtag; ''
    <svg width="128" height="128" viewBox="0 0 128 128" fill="none" xmlns="http://www.w3.org/2000/svg">
    <g clip-path="url(#clip0_25_125)">
    <rect width="59" height="128" rx="8" transform="matrix(0 1 1 0 0 69)" fill="${accent}"/>
    <rect width="59" height="36" rx="8" transform="matrix(0 1 1 0 46 0)" fill="${white}"/>
    <rect width="59" height="36" rx="8" transform="matrix(0 1 1 0 92 0)" fill="${white}"/>
    <path d="M8 0C3.58172 0 0 3.58172 0 8L0 51C0 55.4183 3.58172 59 8 59H28C32.4183 59 36 55.4183 36 51V8C36 3.58172 32.4183 0 28 0L8 0Z" fill="${white}"/>
    </g>
    <defs>
    <clipPath id="clip0_25_125">
    <rect width="128" height="128" fill="white"/>
    </clipPath>
    </defs>
    </svg>'';
}
