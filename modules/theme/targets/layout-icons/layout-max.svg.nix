{
  config,
  lib,
  ...
}:
lib.mkIf config.fht.theme.targets.awesomewm.enable {
  home.xdg.configFile."theme/awesome/layout-icons/layout-max.svg".text = with config.fht.theme.colors.withHashtag; ''
    <svg width="128" height="128" viewBox="0 0 128 128" fill="none" xmlns="http://www.w3.org/2000/svg">
    <g clip-path="url(#clip0_25_94)">
    <rect width="128" height="128" fill="${white}"/>
    <path d="M61.1288 12.9602C62.7001 11.3401 65.2999 11.3401 66.8712 12.9602L75.6055 21.965C78.0662 24.502 76.2685 28.75 72.7342 28.75H55.2658C51.7315 28.75 49.9338 24.502 52.3945 21.965L61.1288 12.9602Z" fill="${accent}"/>
    <path d="M61.1288 115.04C62.7001 116.66 65.2999 116.66 66.8712 115.04L75.6055 106.035C78.0662 103.498 76.2685 99.25 72.7342 99.25H55.2658C51.7315 99.25 49.9338 103.498 52.3945 106.035L61.1288 115.04Z" fill="${accent}"/>
    <path d="M12.9602 61.1288C11.3401 62.7001 11.3401 65.2999 12.9602 66.8712L21.965 75.6055C24.502 78.0662 28.75 76.2685 28.75 72.7342L28.75 55.2658C28.75 51.7315 24.502 49.9338 21.965 52.3945L12.9602 61.1288Z" fill="${accent}"/>
    <path d="M115.04 61.1288C116.66 62.7001 116.66 65.2999 115.04 66.8712L106.035 75.6055C103.498 78.0662 99.25 76.2685 99.25 72.7342V55.2658C99.25 51.7315 103.498 49.9338 106.035 52.3945L115.04 61.1288Z" fill="${accent}"/>
    </g>
    <defs>
    <clipPath id="clip0_25_94">
    <rect width="128" height="128" fill="white"/>
    </clipPath>
    </defs>
    </svg>'';
}
