# huawei-wmi

Sets group write privileges and reinstates battery charge-thresholds.

## Debian Package

Tested on Debian Buster.

### Repository

```sh
echo "deb http://deb.qu1x.org buster main" | sudo tee /etc/apt/sources.list.d/qu1x.list
sudo apt-key adv --keyserver hkp://pool.sks-keyservers.net --recv-keys 4503D1AB
sudo apt update
sudo apt install huawei-wmi
```

### Build

Requirements:

  * `build-essential`
  * `devscripts`
  * `debhelper`

Build package: `make`

Install package: `sudo make install`

Remove package: `sudo make remove`

Reconfigure installed package: `sudo make reconfigure`

Clean package directory: `make clean`

Clean all: `make distclean`

Translate templates: `make translate`
