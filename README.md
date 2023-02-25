# huawei-wmi

Sets group write privileges and reinstates battery charge-thresholds.

Also reinstates keyboard backlight timeout and power mode unlock if supported.

As the Huawei WMI controller can forget above settings after power cycling or hibernation, this
repository provides udev rules and systemd units to reinstate them. Still a surprising but expected
behavior is that after re-plugging the power supply or a short power outage while the MateBook is
powered off, there is nothing running which can reinstate the charge-thresholds and it will charge
to 100 %. Therefore, it is recommended to unplug the power supply after powering it off. Further
information is provided by the [Linux on MateBook] guide.

The settings to be reinstated are stored in `/etc/default/huawei-wmi/` and the current settings of
the kernel driver interface are mapped in `/sys/devices/platform/huawei-wmi/`. The udev rule will
fire the static one-shot `huawei-wmi-privilege` service as soon as the kernel driver interface has
been populated. It will set group write privileges for the members of the system group `huawei-wmi`
and initialize non-existing settings in former directory with the current settings of latter
directory. Afterwards, it will fire the non-static one-shot `huawei-wmi-reinstate` service which
reinstates the settings by copying the files from former to latter directory. Latter service is
refired when waking up from hibernation. Only non-static services can be enabled or disabled.

This repository relies on the mainlined [kernel driver] and is supported by the cross-platform
[MateBook applet] as well as the native [Gnome extension].

[kernel driver]: https://github.com/aymanbagabas/Huawei-WMI
[MateBook applet]: https://github.com/nekr0z/matebook-applet
[Gnome extension]: https://github.com/egormanga/gnome-extension-huawei-wmi
[Linux on MateBook]: https://github.com/nekr0z/linux-on-huawei-matebook-13-2019

This repository can be installed via [Makefile](#Makefile) or distribution [packages](#Packages). It
will ask for a list of desktop users separated by space which will gain mandatory group write
privileges to the kernel driver interface. For the changes to take effect, the listed users have to
be logged out after installation. This is reliably achieved by power cycling the MateBook.

## Makefile

  * [Generic](generic)

## Packages

  * [Debian](debian)
  * [Arch Linux] published on [AUR] by [Egor Vorontsov]

[Arch Linux]: https://github.com/egormanga/aur-huawei-wmi
[AUR]: https://aur.archlinux.org/packages/huawei-wmi
[Egor Vorontsov]: https://github.com/egormanga

## License

Licensed under [Fair].

[Fair]: https://opensource.org/licenses/Fair

## Contribution

Unless you explicitly state otherwise, any contribution intentionally submitted for inclusion in the
works by you shall be licensed as above, without any additional terms or conditions.
