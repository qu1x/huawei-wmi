# huawei-wmi

For a general description, see the repository [README.md](..).

## Debian Package

This package has been tested on Debian Bullseye and can be installed via repository or manual build.

### Install via Repository

```sh
export repo='https://deb.qu1x.dev bullseye main'
export keys=/usr/share/keyrings/qu1x-dev-archive-keyring.gpg
export list=/etc/apt/sources.list.d/qu1x-dev.list

printf "# Qu1x Deb\ndeb [signed-by=$keys] $repo\ndeb-src [signed-by=$keys] $repo\n" | sudo tee $list
sudo curl -o $keys https://qu1x.dev/file/keyring.gpg

sudo apt update
sudo apt install huawei-wmi
```

Optionally, remove old keys imported via deprecated `apt-key`:

```sh
sudo apt-key del CCF5E9B44503D1AB
```

### Install via Manual Build

Manually building the package requires `build-essential devscripts debhelper`.

  * Build package: `make`
  * Install package: `sudo make install`
  * Remove package: `sudo make remove`
  * Reconfigure users of installed package: `sudo make reconfigure`
  * Clean package directory: `make clean`
  * Clean all: `make distclean`
  * Translate templates: `make translate`
