# Changelog

## [0.6.1](https://github.com/luisbocanegra/plasma-wallpaper-effects/compare/v0.6.0...v0.6.1) (2025-06-20)


### Bug Fixes

* check empty callback in DBusFallBack ([723416a](https://github.com/luisbocanegra/plasma-wallpaper-effects/commit/723416a104e855abacc49ecf0acbc14a8dec0726))

## [0.6.0](https://github.com/luisbocanegra/plasma-wallpaper-effects/compare/v0.5.0...v0.6.0) (2025-06-15)


### Features

* show running desktop effects in settings window ([8966ad1](https://github.com/luisbocanegra/plasma-wallpaper-effects/commit/8966ad125f62b47ad256cf41a8583b6cdf544492))


### Bug Fixes

* make gdbus fallback actually work ([b7bd3f2](https://github.com/luisbocanegra/plasma-wallpaper-effects/commit/b7bd3f22b6cb0968eca9ecf77aed1519f5e951be))

## [0.5.0](https://github.com/luisbocanegra/plasma-wallpaper-effects/compare/v0.4.3...v0.5.0) (2025-06-12)


### Features

* add enable and configure actions to wallpaper right-click menu ([aee119c](https://github.com/luisbocanegra/plasma-wallpaper-effects/commit/aee119c8769d95705f9fb3954e520160b44584a0))
* allow disabling grain change animation & disable by default ([5e7181f](https://github.com/luisbocanegra/plasma-wallpaper-effects/commit/5e7181f4e1da4897c961440555f2b51bfb214a11))
* different fade in/out animation duration ([d253324](https://github.com/luisbocanegra/plasma-wallpaper-effects/commit/d25332498260991ac2dd1be49c5fd4a0bc65e9b9))
* enable and hide actions to widget right-click menu ([e1f7a30](https://github.com/luisbocanegra/plasma-wallpaper-effects/commit/e1f7a30355d4f6aabd0b3015e1aec1f134834d69))
* major configuration and desktop effects refactoring ([7cfb23d](https://github.com/luisbocanegra/plasma-wallpaper-effects/commit/7cfb23d2308af238cf38ae9faf96e0d55e8285b2))


### Bug Fixes

* effects stop working after switching layout (Desktop/Folder View) ([bcfb8c4](https://github.com/luisbocanegra/plasma-wallpaper-effects/commit/bcfb8c49acb67593d3d977b7c09a678f920c06d4))

## [0.4.3](https://github.com/luisbocanegra/plasma-wallpaper-effects/compare/v0.4.2...v0.4.3) (2025-03-21)


### Bug Fixes

* grain effect visible patterns/lines/stripes ([95a8900](https://github.com/luisbocanegra/plasma-wallpaper-effects/commit/95a89006b2f7896269c27192d42cfe95221bf58c))

## [0.4.2](https://github.com/luisbocanegra/plasma-wallpaper-effects/compare/v0.4.1...v0.4.2) (2025-03-15)


### Bug Fixes

* add missing setting xml entries ([e78993e](https://github.com/luisbocanegra/plasma-wallpaper-effects/commit/e78993ecbdb84a4078f070ff4ef59ee6a8cb9cce))

## [0.4.1](https://github.com/luisbocanegra/plasma-wallpaper-effects/compare/v0.4.0...v0.4.1) (2025-03-09)


### Bug Fixes

* high GPU usage when pixelate and grain shaders are not visible ([0f29fbb](https://github.com/luisbocanegra/plasma-wallpaper-effects/commit/0f29fbb924f98f05d3d3830f38fd0bf0c93431fe))

## [0.4.0](https://github.com/luisbocanegra/plasma-wallpaper-effects/compare/v0.3.0...v0.4.0) (2025-03-08)


### Features

* add project urls, version and Desktop Effects note ([126d2fd](https://github.com/luisbocanegra/plasma-wallpaper-effects/commit/126d2fd48bb33ba9b712411a671de5f7e9e571f6))
* grain effect ([4dc5c46](https://github.com/luisbocanegra/plasma-wallpaper-effects/commit/4dc5c46a92e70092dd3fa332f4ed0b9126f52e2e))
* pixelate effect ([625d947](https://github.com/luisbocanegra/plasma-wallpaper-effects/commit/625d947b8f1b2c69857746c29635445501944684))


### Bug Fixes

* settings crash due to binding on buttons with custom colors ([574f9c2](https://github.com/luisbocanegra/plasma-wallpaper-effects/commit/574f9c2c23360efe57ded3a8444c847b4845ebd9))

## [0.3.0](https://github.com/luisbocanegra/plasma-wallpaper-effects/compare/v0.2.2...v0.3.0) (2024-09-08)


### Features

* draw shadow behind rounded corners effect ([702eb0d](https://github.com/luisbocanegra/plasma-wallpaper-effects/commit/702eb0dc39b23c4f16a3042692cadb30041ce2c6))

## v0.2.2 2024-07-30 Effects optimizations and switch to gdbus

### Improvements

- Effects optimizations
  - Fix 2x GPU usage when effects are disabled (visible = false)
  - Only check active effects when the feature is being used
  - Increase blurMax instead of calculating blur
  - Remove some redundant Items
- Added option to change effects animation duration
- Port from qdbus to gdbus command

## v0.2.1 2024-05-31 Desktop effects detection

### Improvements

- Toggle effects based on active Desktop Effects (overview, grid, peek at desktop...)
- Translation support
- Spanish translation

## v0.1.1 2024-05-14 Bugfix Release

### Fixes

- Fixed widget crashing after disabling/re-enabling the screen it was on, causing effects to stop working

## v0.1.0 2024-04-10 Initial Release
