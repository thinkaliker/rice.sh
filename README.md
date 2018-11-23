# rice.sh

rice it up

rice (n): Enhancements that may or may not be useful and usually flashy.

## Install

- `git clone https://github.com/thinkaliker/rice.sh.git`
- `cd rice.sh`
- `chmod +x ./rice.sh`

## Usage

- `./rice.sh`
- `rice-sh` (if aliases are installed)

## About

For the perfectionists. For the sysadmins. For the flashy. For the lazy.

`rice.sh` is a set of fully configurable, modular scripts that can (theoretically) be run in any configuration to help stand up a new system, add quality-of-life enhancements, or to make things look awesome.

Designed for Debian based distros - but if you know how to port to other systems, please make a pull request!

## Executor

All rice- scripts are run by `rice.sh`. By default, any existing files/configurations will be overwritten.

After installing the defaults, the script will prompt you to install additional scripts. Or, you can choose to skip the defaults and pick individual scripts to run.

You can update rice.sh by running `rice.sh -u` or `rice.sh --update`.

## Default scripts

These are the scripts that are run by default.

- [rice-update](/rice-update) - installs a quick update script
- [rice-vim](/rice-vim) - useful vim settings

## Additional scripts

- [rice-dev](/rice-dev) - installs build-essentials
- [rice.sh-tools](/rice.sh-tools) - adds rice-sh aliases

## Flags

Short Flag | Long Flag | Description
-----------|-----------|------------
-d         | --default | Runs only the default scripts.
-h         | --help    | Displays the help message.
-i         | --info    | Displays useful system information.
-u         | --update  | Runs 'git pull' on installed directory.
-v         | --version | Displays rice.sh version.

## Adding your own rice- scripts

You can easily add your own scripts by adding it into `rice.sh`. Configure your defaults by modifying the array at the top of the script (note that these will be overwritten if you use the update flag). [rice-example](/rice-example) is provided with some building blocks in order to maintain consistency. Maintain the folder naming convention of the folder having the same name as the script.

## TODO/Wishlist

- prompt to overwrite if files exists
  - should default to backup then copy
- more scripts
- more configuration files
- standalone script that auto clones this repository via `wget` (bootstrap.sh?)
- script validator
- extensibility to other distros
