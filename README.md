# raspi-autoupdate #
This script is intended to automate package updates on raspbian. Probably it also works with most other debian-based distros.

It pushes information about changes it made to a pushbullet device.

# Prerequisites #
"jq" and "curl" have to be installed.

# Usage #
## configuration ##
Place your config in an extra file, e.g. "config" (which is the default).

Example:

    #!/bin/bash
    PUSHBULLET_TOKEN="4711"
    PUSHBULLET_DEVICE="42"
    NOTIFY_TITLE_PREFIX="`hostname` update"

As you might have noticed, the config file is also a bash script. So you can run every kind of scripting you want to, to fill the parameters.

- PUSHBULLET\_TOKEN
  - This is the pushbullet access token. Create yours at the pushbullet [account page](https://www.pushbullet.com/#settings/account).
- PUSHBULLET\_DEVICE
  - The iden of the pushbullet device you want to get notified. See below for instructions on how to obtain this. 
- NOTIFY\_TITLE\_PREFIX
  - Every message to your pushbullet device has a title. This is the prefix of the title.

## obtain pushbullet device iden ##
Simply run

    ./update.sh -l

to get a list of all your pushbullet devices including their idens.


## run updates ##
To run the script and perform the package updates run:

    ./update.sh -c <configfile>

If -c is ommited, "./config" is assumed to be the config file.

