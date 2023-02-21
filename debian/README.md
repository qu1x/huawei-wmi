# huawei-wmi

Sets group write privileges and reinstates battery charge-thresholds.

## Debian Package

Tested on Debian Bullseye.

### Repository

```sh
echo "deb https://deb.qu1x.dev bullseye main" | sudo tee /etc/apt/sources.list.d/qu1x.list
sudo apt-key adv --keyserver hkps://keys.openpgp.org --recv-keys E7928B9BE4A91FA8
sudo apt update
sudo apt install huawei-wmi
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
