<div align="center">

# KDE Wallpaper Effects

[![AUR version](https://img.shields.io/aur/version/plasma6-applets-wallpaper-effects?logo=archlinux&labelColor=2d333b&color=1f425f)](https://aur.archlinux.org/packages/plasma6-applets-wallpaper-effects)
[![Store version](https://img.shields.io/badge/dynamic/xml?url=https%3A%2F%2Fapi.opendesktop.org%2Focs%2Fv1%2Fcontent%2Fdata%2F2145723&query=%2Focs%2Fdata%2Fcontent%2Fversion%2Ftext()&color=1f425f&labelColor=2d333b&logo=kde&label=KDE%20Store)](https://store.kde.org/p/2145723)
[![Store downloads](https://img.shields.io/badge/dynamic/xml?url=https%3A%2F%2Fapi.opendesktop.org%2Focs%2Fv1%2Fcontent%2Fdata%2F2145723&query=%2Focs%2Fdata%2Fcontent%2Fdownloads%2Ftext()&logo=kde&label=Downloads&labelColor=2d333b)](https://store.kde.org/p/2145723)

Plasma Widget to enable Active Blur and other effects for all Wallpaper Plugins

![icon](screenshots/icon.png)

</div>

Inspired by the [Zren/inactiveblur](https://github.com/Zren/plasma-wallpapers/tree/master/inactiveblur) ([bouteillerAlan/blurredwallpaper](https://github.com/bouteillerAlan/blurredwallpaper) for plasma 6) but packed into a widget to work with any Wallpaper Plugin.

## Demo

[![Demo](https://img.shields.io/badge/watch%20on%20youtube-demo?logo=youtube&logoColor=white&labelColor=%23c30000&color=%23222222
)](https://www.youtube.com/watch?v=fdTAewwZLVs) (outdated)

<details>
    <summary>Screenshots</summary>

![tooltip](screenshots/settings.png)

</details>

## Features

### Blur

- Radius

### Rounded corners

- Radius
- Background color
- Margins (top, bottom, left, right)
- Shadow

### Color effects

- Colorization
- Brightness
- Contrast
- Saturation

### Toggle effects on

- Maximized or full-screen window
- Active window
- Window is present
- Always
- Never
- Desktop Effects (overview, windowaperture...)

### Pixelate (shader)

- Pixel size

### Grain filter (shader)

- Animate
- Grain size
- Grain amount

- [ ] You tell me

## Installing

### Arch Linux

[aur/plasma6-applets-wallpaper-effects](https://aur.archlinux.org/packages/plasma6-applets-wallpaper-effects) use your preferred AUR helper (e.g `yay -S plasma6-applets-wallpaper-effects`)

### KDE Store

Install the plugin from the KDE Store [Plasma 6 version](https://store.kde.org/p/2145723)

1. **Right click on the Desktop** > **Edit Mode** > **Add Widgets** > **Get New Widgets** > **Download new...**
2. **Search** for "**Wallpaper Effects**", install and add it to your Desktop.

### Manually

  1. Install these dependencies or their equivalents for your distribution

      ```txt
      cmake extra-cmake-modules libplasma plasma5support
      ```

  2. Run

      ```sh
      git clone https://github.com/luisbocanegra/plasma-wallpaper-effects
      cd plasma-wallpaper-effects
      ./install.sh
      ```

## How to use

1. Put the widget on any of your Desktops
2. Go to the widget settings to change the effects and behavior
3. Widget can set to only show in **Desktop Edit Mode** (right click > Hide widget or from the widget settings)

### Restore the original desktop appearance

Changes to the Desktop are not permanent and can be removed by disabling them from **Widget Settings** > **General tab** > **Enabled** checkbox or removing the widget from the Desktop.

### How to find Desktop Effects

To get the currently active effects run the following in a terminal and trigger the effect that you want to know the name of:

```sh
while sleep 1; do gdbus call --session --dest org.kde.KWin.Effect.WindowView1 --object-path /Effects --method org.freedesktop.DBus.Properties.Get org.kde.kwin.Effects activeEffects; done
```

## Translations

Instructions to translate the project are available [here](https://github.com/luisbocanegra/plasma-wallpaper-effects/blob/main/package/translate/ReadMe.md)

## How does it work

Similar to [plasma-panel-colorizer](https://github.com/luisbocanegra/plasma-panel-colorizer), this widget works by injecting/managing effects of the existing wallpaper. Replicating the famous Active Blur for all Wallpaper Plugins without having to modify each Plugin source code.

## Support the development

If you like the project you can:

[!["Buy Me A Coffee"](https://img.shields.io/badge/Buy%20me%20a%20coffe-supporter?logo=buymeacoffee&logoColor=%23282828&labelColor=%23FF803F&color=%23FF803F)](https://www.buymeacoffee.com/luisbocanegra) [![Liberapay](https://img.shields.io/badge/Become%20a%20supporter-supporter?logo=liberapay&logoColor=%23282828&labelColor=%23F6C814&color=%23F6C814)](https://liberapay.com/luisbocanegra/)

## Acknowledgements

- [Zren/inactiveblur](https://github.com/Zren/plasma-wallpapers/tree/master/inactiveblur) [bouteillerAlan/blurredwallpaper](https://github.com/bouteillerAlan/blurredwallpaper)

- [Search the actual gridLayout of the panel from Plasma panel spacer](https://invent.kde.org/plasma/plasma-workspace/-/blob/Plasma/5.27/applets/panelspacer/package/contents/ui/main.qml?ref_type=heads#L37) code that inspired this project.

- [Google LLC. / Pictogrammers](https://pictogrammers.com/library/mdi/) for the icons.

## Screenshots

Configuration

![tooltip](screenshots/settings.png)

Effects demo

![tooltip](screenshots/desktop.png)
