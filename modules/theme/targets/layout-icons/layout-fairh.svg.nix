{
  config,
  lib,
  ...
}:
lib.mkIf config.fht.theme.targets.awesomewm.enable {
  home.xdg.configFile."theme/awesome/layout-icons/layout-fairh.svg".text = with config.fht.theme.colors.withHashtag; ''    <svg width="128" height="128" viewBox="0 0 128 128" fill="none" xmlns="http://www.w3.org/2000/svg">
    <g clip-path="url(#clip0_25_56)">
    <rect x="92" y="69" width="36" height="59" rx="8" fill="${white}"/>
    <rect y="69" width="36" height="59" rx="8" fill="${white}"/>
    <rect x="92" width="36" height="59" rx="8" fill="${accent}"/>
    <rect width="36" height="59" rx="8" fill="${accent}"/>
    <rect x="46" y="69" width="36" height="59" rx="8" fill="${accent}"/>
    <rect x="46" width="36" height="59" rx="8" fill="${white}"/>
    </g>
    <defs>
    <clipPath id="clip0_25_56">
    <rect width="128" height="128" fill="white"/>
    </clipPath>
    </defs>
    </svg>'';
}
