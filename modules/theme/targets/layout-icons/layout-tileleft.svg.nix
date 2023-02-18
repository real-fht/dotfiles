{
  config,
  lib,
  ...
}:
lib.mkIf config.fht.theme.targets.awesomewm.enable {
  home.xdg.configFile."theme/awesome/layout-icons/layout-tileleft.svg".text = with config.fht.theme.colors.withHashtag; ''
    <svg width="128" height="128" viewBox="0 0 128 128" fill="none" xmlns="http://www.w3.org/2000/svg">
    <g clip-path="url(#clip0_25_115)">
    <rect width="59" height="128" rx="8" transform="matrix(-1 0 0 1 128 0)" fill="${accent}"/>
    <rect width="59" height="36" rx="8" transform="matrix(-1 0 0 1 59 0)" fill="${white}"/>
    <rect width="59" height="36" rx="8" transform="matrix(-1 0 0 1 59 46)" fill="${white}"/>
    <rect width="59" height="36" rx="8" transform="matrix(-1 0 0 1 59 92)" fill="${white}"/>
    </g>
    <defs>
    <clipPath id="clip0_25_115">
    <rect width="128" height="128" fill="white"/>
    </clipPath>
    </defs>
    </svg>'';
}
