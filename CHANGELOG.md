# Changelog

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
