# rice.sh
rice it up

## Usage

- `git clone http://github.com/thinkaliker/rice.sh.git` 
- `cd rice.sh`
- `chmod +x ./rice.sh`
- `./rice.sh` 

## About
For the perfectionists. For the sysadmins. For the flashy. For the lazy.

`rice.sh` is a set of fully configurable, modular scripts that can (theoretically) be run in any configuration to help stand up a new system, add quality-of-life enhancements, or to make things look awesome.

Designed for Ubuntu based distros - but if you know how to port to other systems, please make a pull request!

## Executor
All rice- scripts are run by `rice.sh`. By default, any existing files/configurations will be overwritten.

After installing the defaults, the script will prompt you to install additional scripts.

## Default scripts
These are the scripts that are run by default.

- [rice-update](/rice-update) 
- [rice-vim](/rice-vim)

## Additional scripts

- [rice-dev](/rice-dev)

## Adding your own rice- scripts
You can easily add your own scripts by adding it into `rice.sh`. Follow the existing array pattern, and don't forget to increment the loader for loop. [rice-example](/rice-example) is provided with some building blocks in order to maintain consistency. Maintain the folder naming convention of the folder having the same name as the script.

## TODO/Wishlist
- prompt to select certain packages to install by default (or a command-line argument)
- prompt to overwrite if files exists
- more scripts
- more configuration files
- standalone script that auto clones this repository via `wget`
    - maybe a script that provides that as a script to you later for easy updating a la `update-rice`
    - should revert repo using `git checkout -- *` to prevent colliding with chmod-ed files
- script validator
- extensibility to other distros
