{
  config,
  lib,
  ...
}:
lib.mkIf config.fht.theme.targets.awesomewm.enable {
  home.xdg.configFile."theme/awesome/layout-icons/layout-dwindle.svg".text = with config.fht.theme.colors.withHashtag; ''    <svg width="128" height="128" viewBox="0 0 128 128" fill="none" xmlns="http://www.w3.org/2000/svg">
    <g clip-path="url(#clip0_25_38)">
    <rect width="59" height="128" rx="8" fill="${accent}"/>
    <rect x="69" width="59" height="59" rx="8" fill="${white}"/>
    <rect x="69" y="69" width="26" height="59" rx="8" fill="${white}"/>
    <rect x="102" y="69" width="26" height="26" rx="8" fill="${white}"/>
    <rect x="102" y="102" width="26" height="26" rx="8" fill="${accent}"/>
    </g>
    <defs>
    <clipPath id="clip0_25_38">
    <rect width="128" height="128" fill="white"/>
    </clipPath>
    </defs>
    </svg>'';
}
