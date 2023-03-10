{
  config,
  lib,
  ...
}:
lib.mkIf config.fht.theme.targets.awesomewm.enable {
  home.xdg.configFile."theme/awesome/layout-icons/layout-fairv.svg".text = with config.fht.theme.colors.withHashtag; ''    <svg width="128" height="128" viewBox="0 0 128 128" fill="none" xmlns="http://www.w3.org/2000/svg">
    <g clip-path="url(#clip0_1_2)">
    <rect width="59" height="36" rx="8" fill="${white}"/>
    <rect x="69" width="59" height="36" rx="8" fill="${accent}"/>
    <rect y="92" width="59" height="36" rx="8" fill="${white}"/>
    <rect x="69" y="92" width="59" height="36" rx="8" fill="${white}"/>
    <rect y="46" width="59" height="36" rx="8" fill="${accent}"/>
    <rect x="69" y="46" width="59" height="36" rx="8" fill="${white}"/>
    </g>
    <defs>
    <clipPath id="clip0_1_2">
    <rect width="128" height="128" fill="white"/>
    </clipPath>
    </defs>
    </svg>'';
}
