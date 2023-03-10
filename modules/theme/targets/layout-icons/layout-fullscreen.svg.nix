{
  config,
  lib,
  ...
}:
lib.mkIf config.fht.theme.targets.awesomewm.enable {
  home.xdg.configFile."theme/awesome/layout-icons/layout-fullscreen.svg".text = with config.fht.theme.colors.withHashtag; ''    <svg width="128" height="128" viewBox="0 0 128 128" fill="none" xmlns="http://www.w3.org/2000/svg">
    <g clip-path="url(#clip0_25_66)">
    <rect x="5" y="5" width="118" height="118" stroke="${white}" stroke-width="10"/>
    <path d="M58.3431 15.6569C61.4673 12.5327 66.5327 12.5327 69.6569 15.6569L112.343 58.3431C115.467 61.4673 115.467 66.5327 112.343 69.6569L69.6569 112.343C66.5327 115.467 61.4673 115.467 58.3431 112.343L15.6569 69.6569C12.5327 66.5327 12.5327 61.4673 15.6569 58.3431L58.3431 15.6569Z" fill="${accent}"/>
    </g>
    <defs>
    <clipPath id="clip0_25_66">
    <rect width="128" height="128" fill="white"/>
    </clipPath>
    </defs>
    </svg>'';
}
