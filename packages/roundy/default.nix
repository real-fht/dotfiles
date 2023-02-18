{iosevka, ...} @ pkgs:
iosevka.override {
  set = "Roundy";
  privateBuildPlan = ''
    [buildPlans.iosevka-Roundy]
    family = "Roundy"
    spacing = "normal"
    serifs = "sans"
    no-cv-ss = false
    export-glyph-names = true

    [buildPlans.iosevka-Roundy.variants]
    inherits = "ss12"

    [buildPlans.iosevka-Roundy.variants.design]
    capital-d = "standard-serifless"
    capital-g = "toothless-rounded-serifless-hooked"
    capital-r = "standing"
    zero = "slashed"
    six = "closed-contour"
    nine = "closed-contour"
    asterisk = "penta-low"
    paren = "normal"
  '';
}
