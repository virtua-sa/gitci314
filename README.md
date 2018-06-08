# Gitci314 - Gitlab CI for Raspberry Pi 3+

This project is proudly offered to you by Virtua SA.

## Install

1. [Get a Raspberry Pi 3 Model B+](https://www.raspberrypi.org/products/) (but it should works with RPi 2B (64b) and 3B too)
2. [Flash](https://etcher.io/) a [Raspbian image](https://downloads.raspberrypi.org/raspbian_latest) on it
3. `curl -sSL https://raw.githubusercontent.com/virtua-sa/gitci314/master/install | bash`

*It takes up to 30 minutes to run Gitlab for the first time.
Also, first access to Gitlab may be very slow but it improves greatly after few requets.
So it might be a good idea to take a good cup of chocolate/coffee/tea while reading [what Virtua SA can do for you](https://www.virtua.ch/en/services/) or [looking for your next job opportunity](https://www.virtua.ch/en/carrieres/) during the process ;)*

***Warning:** SSH port of your Raspberry Pi will be changed from 22 to 2022 to allow Git over SSH.*

## Recommendations

* Because Gitlab consumes a lot of RAM, this setup uses a 4GiB swap file
  * In aim to increase the lifespan of your Raspberry Pi SD card, you should move this file to an USB drive with :
    `SWAPFILE=/dev/sdaX ./install`
* If you have an intensive use of Gitlab CI runners, you should move the Gitlab Multi Runner image to another Raspberry Pi
* In aim to have more space for your Git projects, move the shared folders to an external USB drive (see `docker-compose.yml` file)
* Of course, this setup *MUST NOT* be used for production purpose. It is mainly a proof of concept and should be used as is.

## HowTo

### Login to Gitlab for the first time

* Simply open the URL `http://<your_raspberrypi_ip>` in your favorite browser then set a new password for `root` account

### Register a new Gitlab Runner for CI

1. Grab the registration token of your Gitlab here: `http://<your_raspberrypi_ip>/admin/runners`
2. Run following command on your Raspberry Pi:
   ```sh
   docker-compose run runner register \
     --non-interactive \
     --executor "docker" \
     --url "http://gitlab/" \
     --registration-token "<your_registration_token>" \
     --description "Docker Runner" \
     --tag-list "docker,rpi" \
     --run-untagged \
     --locked="false"
   ```
3. Restart the runner: `docker-compose restart runner`

### Fix permission problems when upgrading Gitlab

* `docker-compose gitlab run update-permissions`

## Licence

This project is published under the terms of the Apache 2.0 licence.

This project uses ideas and some portions of code taken from [gitlabhq/omnibus-gitlab](https://gitlab.com/gitlab-org/omnibus-gitlab).