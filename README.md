<div align="center">

# KDE Wallpaper Effects

[![AUR version](https://img.shields.io/aur/version/plasma6-applets-wallpaper-effects?style=for-the-badge&logo=archlinux&labelColor=2d333b&color=1f425f)](https://aur.archlinux.org/packages/plasma6-applets-wallpaper-effects)
[![Dynamic JSON Badge](https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fraw.githubusercontent.com%2Fluisbocanegra%2Fplasma-wallpaper-effects%2Fmain%2Fpackage%2Fmetadata.json&query=KPlugin.Version&style=for-the-badge&color=1f425f&labelColor=2d333b&logo=kde&label=KDE%20Store)](https://store.kde.org/p/21309670)
[![Liberapay](https://img.shields.io/liberapay/patrons/luisbocanegra?style=for-the-badge&logo=liberapay&logoColor=%23F6C814&labelColor=%232D333B&label=supporters)](https://liberapay.com/luisbocanegra/)

Plasma Widget to enable Active Blur and other effects for the Plasma Desktop

![icon](screenshots/icon.png)

</div>

Inspired by the [Zren/inactiveblur](https://github.com/Zren/plasma-wallpapers/tree/master/inactiveblur) ([bouteillerAlan/blurredwallpaper](https://github.com/bouteillerAlan/blurredwallpaper) for plasma 6) but packed into a widget so it can be applied to other Wallpaper Plugins.

## Demo

[![Demo](https://img.shields.io/badge/watch%20on%20youtube-demo?style=for-the-badge&logo=youtube&logoColor=white&labelColor=%23c30000&color=%23222222
)](https://youtu.be/fdTAewwZLVs)

<details>
    <summary>Screenshots</summary>

![tooltip](screenshots/settings.png)

</details>

## Features

- [x] Blur wallpaper
- Conditions
  - Maximized or full-screen window
  - Active window
  - Window is present
  - Always
  - Never
- Radius
- [ ] Disable effects on
  - [ ] Overview
  - [ ] Grid
  - [ ] Show desktop
- [ ] Color filter
- [ ] Rounded corners??
- [ ] You tell me

## Installing

~~Install the plugin from the KDE Store [Plasma 6 version](https://store.kde.org/p/21309670)~~ TODO

~~1. **Right click on the Desktop** > **Edit Mode** > **Add Widgets** > **Get New Widgets** > **Download new...**~~
~~2. **Search** for "**Wallpaper Effects**", install and add it to your Desktop.~~

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

### Arch Linux

~~[aur/plasma6-applets-wallpaper-effects](https://aur.archlinux.org/packages/plasma6-applets-wallpaper-effects) use your preferred AUR helper e.g:~~ TODO

## How to use

1. Put the widget on any of your Desktops
2. Go to the widget settings to change the effects and behavior
3. Widget can set to only show in **Desktop Edit Mode** (right click > Hide widget or from the widget settings)

### Restore the original desktop appearance

Changes to the Desktop are not permanent and can be removed by disabling them from **Widget Settings** > **General tab** > **Enabled** checkbox or removing the widget from the Desktop.

## How it works

Similar to [plasma-panel-colorizer](https://github.com/luisbocanegra/plasma-panel-colorizer), this widget works by injecting/managing effects of the existing wallpaper. Replicating the famous Active Blur for all Wallpaper Plugins without having to modify each Plugin source code.

## Support the development

If you like the project you can:

[!["Buy Me A Coffee"](https://img.shields.io/badge/Buy%20me%20a%20coffe-supporter?logo=buymeacoffee&logoColor=%23282828&labelColor=%23FF803F&color=%23FF803F)](https://www.buymeacoffee.com/luisbocanegra) [![Liberapay](https://img.shields.io/badge/Become%20a%20supporter-supporter?logo=liberapay&logoColor=%23282828&labelColor=%23F6C814&color=%23F6C814)](https://liberapay.com/luisbocanegra/)

## Acknowledgements

- [Zren/inactiveblur](https://github.com/Zren/plasma-wallpapers/tree/master/inactiveblur) [bouteillerAlan/blurredwallpaper](https://github.com/bouteillerAlan/blurredwallpaper)

- [Search the actual gridLayout of the panel from Plasma panel spacer](https://invent.kde.org/plasma/plasma-workspace/-/blob/Plasma/5.27/applets/panelspacer/package/contents/ui/main.qml?ref_type=heads#L37) code that inspired this project.

- [Google LLC. / Pictogrammers](https://pictogrammers.com/library/mdi/) for the icons.
