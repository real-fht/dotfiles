{
  config,
  lib,
  ...
}:
lib.mkIf config.fht.theme.targets.awesomewm.enable {
  home.xdg.configFile."theme/awesome/layout-icons/layout-floating.svg".text = with config.fht.theme.colors.withHashtag; ''
    <svg width="128" height="128" viewBox="0 0 128 128" fill="none" xmlns="http://www.w3.org/2000/svg">
    <g clip-path="url(#clip0_27_130)">
    <rect x="37" y="64" width="91" height="64" rx="8" fill="${white}"/>
    <path d="M37 72C37 67.5817 40.5817 64 45 64H110V85C110 89.4183 106.418 93 102 93H37V72Z" fill="#1F1F28"/>
    <rect width="100" height="82" rx="8" fill="${accent}"/>
    </g>
    <defs>
    <clipPath id="clip0_27_130">
    <rect width="128" height="128" fill="white"/>
    </clipPath>
    </defs>
    </svg>'';
}
