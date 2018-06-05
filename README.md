# Gitci314 - Gitlab CI for Raspberry Pi 3+

This project is proudly offered to you by Virtua SA.

## Install

1. [Get a Raspberry Pi 3 Model B+](https://www.raspberrypi.org/products/) (but it should works with RPi 2B (64b) and 3B too)
2. [Flash](https://etcher.io/) a [Raspbian image](https://downloads.raspberrypi.org/raspbian_latest) on it
3. `curl -sSL https://raw.githubusercontent.com/virtua-sa/gitci314/master/install.sh | bash`

*Warning: SSH port of your Raspberry Pi will be changed from 22 to 2022 to allow Git over SSH.*

## Licence

This project is published under the terms of the Apache 2.0 licence.

This project uses ideas and some portions of code taken from [gitlabhq/omnibus-gitlab](https://gitlab.com/gitlab-org/omnibus-gitlab).