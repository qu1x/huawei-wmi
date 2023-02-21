# huawei-wmi

Sets group write privileges and reinstates battery charge-thresholds.

## Debian Package

Tested on Debian Bullseye.

### Repository

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

### Build

Requires `build-essential devscripts debhelper`.

  * Build package: `make`
  * Install package: `sudo make install`
  * Remove package: `sudo make remove`
  * Reconfigure installed package: `sudo make reconfigure`
  * Clean package directory: `make clean`
  * Clean all: `make distclean`
  * Translate templates: `make translate`
