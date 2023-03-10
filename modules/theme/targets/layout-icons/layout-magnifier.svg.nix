{
config,
lib,
...
}:
lib.mkIf config.fht.theme.targets.awesomewm.enable {
  home.xdg.configFile."theme/awesome/layout-icons/layout-magnifier.svg".text = with config.fht.theme.colors.withHashtag; ''
    <svg width="128" height="128" viewBox="0 0 128 128" fill="none" xmlns="http://www.w3.org/2000/svg">
    <g clip-path="url(#clip0_25_81)">
    <rect x="28" y="28" width="72" height="72" rx="8" fill="${accent}"/>
    <path d="M0 0H18V47C18 51.4183 14.4183 55 10 55H0V0Z" fill="${white}"/>
    <path d="M0 0H55V10C55 14.4183 51.4183 18 47 18H0V0Z" fill="${white}"/>
    <path d="M0 128L0 110H47C51.4183 110 55 113.582 55 118V128H0Z" fill="${white}"/>
    <path d="M0 128L0 73H10C14.4183 73 18 76.5817 18 81L18 128H0Z" fill="${white}"/>
    <path d="M128 128V110H81C76.5817 110 73 113.582 73 118V128H128Z" fill="${white}"/>
    <path d="M128 128V73H118C113.582 73 110 76.5817 110 81V128H128Z" fill="${white}"/>
    <path d="M128 0V18L81 18C76.5817 18 73 14.4183 73 10V0L128 0Z" fill="${white}"/>
    <path d="M128 0V55H118C113.582 55 110 51.4183 110 47V0L128 0Z" fill="${white}"/>
    </g>
    <defs>
    <clipPath id="clip0_25_81">
    <rect width="128" height="128" fill="white"/>
    </clipPath>
    </defs>
    </svg>'';
}
