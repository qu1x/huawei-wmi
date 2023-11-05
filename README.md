# huawei-wmi

Sets group write privileges and reinstates battery charge-thresholds.

Also reinstates keyboard backlight timeout and power mode unlock if supported.

## Why?

As the Huawei WMI controller is known to forget above settings after hibernation, a few reboots, or
several hours of being powered off, this repository provides a udev rule and two systemd units to
reinstate them as required. A surprising but expected behavior is that while the MateBook is powered
off, there is nothing running which can reinstate the charge-thresholds and hence it still might
charge to 100 %. Therefore, it is recommended to unplug the power supply when powered off. Further
peculiarities are documented in the [Linux on MateBook] guide.

## How?

The settings to be reinstated are stored in `/etc/default/huawei-wmi/` and the current settings of
the [kernel driver] interface are mapped in `/sys/devices/platform/huawei-wmi/`. The udev rule fires
the static one-shot `huawei-wmi-privilege` service as soon as the [kernel driver] interface has been
populated. It sets group write privileges for the members of the system group `huawei-wmi` and
initializes non-existent settings in former directory with the current settings of latter directory.
Afterwards, it fires the non-static one-shot `huawei-wmi-reinstate` service which reinstates the
settings by copying the files from former to latter directory. Latter service is refired when waking
up from hibernation. Only non-static services can be enabled or disabled.

## Installation

The services rely on the mainlined [kernel driver]. They are supported by the cross-platform
[MateBook applet] as well as the native [Gnome extension] and can be installed via Makefile or
distribution packages. The installer will ask for a list of desktop users separated by space which
will gain mandatory group write privileges to the [kernel driver] interface. For the changes to take
effect, the listed users have to be logged out. This is reliably achieved by rebooting the MateBook.

[Linux on MateBook]: https://github.com/nekr0z/linux-on-huawei-matebook-13-2019
[kernel driver]: https://github.com/aymanbagabas/Huawei-WMI
[MateBook applet]: https://github.com/nekr0z/matebook-applet
[Gnome extension]: https://github.com/egormanga/gnome-extension-huawei-wmi

### Makefile

  * [Generic]

### Packages

  * [Debian]
  * [Arch Linux] maintained by [Ben Woodward]

[Generic]: generic
[Debian]: debian
[Arch Linux]: https://aur.archlinux.org/packages/huawei-wmi
[Ben Woodward]: https://github.com/Sacro

## Troubleshooting

Ensure your desktop user is a member of the system group `huawei-wmi`:

```sh
$ groups | xargs -n 1 | grep huawei-wmi
huawei-wmi
```

Ensure your desktop user has write privileges for default and current settings:

```sh
$ echo 40 70 | tee {/etc/default,/sys/devices/platform}/huawei-wmi/charge_control_thresholds
40 70
```

Ensure the charge capacity lies between above charge-thresholds or choose them accordingly:

```sh
$ cat /sys/class/power_supply/BAT?/capacity
60 # for example
```

Ensure the battery is not charging:

```sh
$ cat /sys/class/power_supply/BAT?/status
Not charging
```

Note that above and especially the Gnome/KDE charge status might be delayed by a few minutes.

### Smart Charge

Newer models starting from 2020 feature a smart-charge mode which ignores any charge-thresholds if
enabled. It might get enabled by updating the BIOS, starting PC Manager on Windows, or setting one
of the thresholds to zero.

Disable smart-charge mode which would otherwise ignore charge-thresholds:

```sh
$ echo 0x462848011503 | tee /sys/kernel/debug/huawei-wmi/arg
0x462848011503
$ cat /sys/kernel/debug/huawei-wmi/call
# ...
$ cat /sys/kernel/debug/huawei-wmi/call # yes, twice
# ...
```

This basically enables home mode and hence sets charge-thresholds to `"40 70"`.

## License

Licensed under [Fair].

[Fair]: https://opensource.org/licenses/Fair

## Contribution

Unless you explicitly state otherwise, any contribution intentionally submitted for inclusion in the
works by you shall be licensed as above, without any additional terms or conditions.
