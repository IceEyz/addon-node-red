# Home Assistant Add-on: Node-RED-Minimal

[![License][license-shield]](LICENSE.md)

![Supports aarch64 Architecture][aarch64-shield]
![Supports amd64 Architecture][amd64-shield]
![Supports armhf Architecture][armhf-shield]
![Supports armv7 Architecture][armv7-shield]
![Supports i386 Architecture][i386-shield]

Flow-based programming for the Internet of Things.

![Node-RED in the Home Assistant Frontend](images/screenshot.png)

## About

Node-RED is a programming tool for wiring together hardware devices,
APIs and online services in new and interesting ways.

It provides a browser-based editor that makes it easy to wire together flows
using the wide range of nodes in the palette that can be deployed to its
runtime in a single click.

## This is not the official community addon
This add-on is actually a **minimized version** of the [official community addon](https://addons.community/#node-red).
It can only be managed through ingress, does not support serial devices and
is unable to expose HTTP nodes on your network.

If you require such functionality, please use the above mentioned official addon.

## Installation

The installation of this add-on is pretty straightforward and not different in
comparison to installing any other Home Assistant add-on.

**Warning**: The docker image isn't prebuild (yet), which means you currently need
decent hardware and/or patience to have your local Home Assistant build the image.

**Warning**: By default this addon uses the same configuration location as the
official community Node-Red addon. You can use this addon as a replacement,
but should not run both simultaneously without configuring separate configuration
paths.

1. Add this repository to your Supervisor Add-On store.
1. Search for the "Node-RED-Minimal" add-on in the Home Assistant add-on store and
   install it.
1. Set a `credential_secret`, which is used to encrypt sensitive data.
   This is just a "password", which you should save in a secondary location.
1. Start the "Node-RED-Minimal" add-on.
1. Check the logs of "Node-RED-Minimal" to see if everything went well.
1. Click on the "OPEN WEB UI" button to jump into Node-RED.
1. The add-on works straight out the box! No need to configure a server!

**Note**: The add-on is **pre-configured** out of the box! There is no need
to add/change/update the server connection settings!

Please read the rest of this document further instructions.

## Configuration

**Note**: _Remember to restart the add-on when the configuration is changed._

Example add-on configuration:

```yaml
log_level: info
credential_secret: KJHhfdhiFRENCKfsdfdsDHFHDJS
system_packages:
  - ffmpeg
npm_packages:
  - node-red-admin
init_commands:
  - echo 'This is a test'
  - echo 'So is this...'
```

**Note**: _This is just an example, don't copy and paste it! Create your own!_

### Option: `log_level`

The `log_level` option controls the level of log output by the addon and can
be changed to be more or less verbose, which might be useful when you are
dealing with an unknown issue. Possible values are:

- `trace`: Show every detail, like all called internal functions.
- `debug`: Shows detailed debug information.
- `info`: Normal (usually) interesting events.
- `warning`: Exceptional occurrences that are not errors.
- `error`:  Runtime errors that do not require immediate action.
- `fatal`: Something went terribly wrong. Add-on becomes unusable.

Please note that each level automatically includes log messages from a
more severe level, e.g., `debug` also shows `info` messages. By default,
the `log_level` is set to `info`, which is the recommended setting unless
you are troubleshooting.

### Option: `credential_secret`

Credentials are encrypted by Node-RED in storage, using a secret key.
This option allows you to specify your secret key. This can be anything
you like, it is just like a password. Be sure to store it somewhere safe.
You might need it in the future! (e.g., When restoring a backup).

**Note**: _Once you set this property, do not change it - doing so will prevent
Node-RED from being able to decrypt your existing credentials and they will be
lost._

**Note**: _This option support secrets, e.g., `!secret red_secret`._

### Option: `dark_mode`

When set to `true`, the Midnight Node-RED theme by [Mauricio Bonani][bonanitech]
will be enabled. For more information and a glance at how it looks,
see the GitHub repository of this theme:

<https://github.com/node-red-contrib-themes/midnight-red>

### Option: `system_packages`

Allows you to specify additional [Alpine packages][alpine-packages] to be
installed to your Node-RED setup (e.g., `g++`. `make`, `ffmpeg`).

**Note**: _Adding many packages will result in a longer start-up time
for the add-on._

### Option: `npm_packages`

Allows you to specify additional [NPM packages][npm-packages] or
[Node-RED nodes][node-red-nodes] to be installed to your Node-RED setup
(e.g., `node-red-dashboard`, `node-red-contrib-ccu`).

**Note**: _Adding many packages will result in a longer start-up time
for the add-on._

### Option: `init_commands`

Customize your Node-RED environment even more with the `init_commands` option.
Add one or more shell commands to the list, and they will be executed every
single time this add-on starts.

## Configuration folder

The addon will store most of its configuration in the `config/node-red` folder,
including the `flows.json`. Please ensure this is included in your backup. It is
also important to note that this will not be removed on uninstalling the addon.

## Time zone configuration

The addon will use the configured time zone of the underlying operating system.
If this is incorrect (for example with the Home Assistant Operating System it
will be UTC), this can be configured in the `/config/node-red/settings.js` file.

To do so, open the file with a text editor and add the following above the
`module.exports = {` line.

`process.env.TZ = "America/Toronto";`

The time zone will need to reflect your environment.

Save the file and restart the Node-RED add-on.

## Known issues and limitations

- Since this minimzed add-on only supports ingress, and Node-Red Dashboard
  currently does not support accessing the dashboard via Ingress, you cannot
  install and use Node-RED Dashboard.

- HTTP nodes and static HTTP content cannot be made available on your network.
  Please use the official Node Red addon if you wish to do so.

- The docker image isn't prebuild (yet), which means you currently need
  decent hardware and/or patience to have your local Home Assistant build the image.

- If the following error is seen after an update `WARNING (MainThread)
  [hassio.api.proxy] Unauthorized WebSocket access!` please validate the
  configuration of the Home Assistant server setup in Node-RED. This can be
  found by double-clicking any Home Assistant node and selecting the pencil icon
  by the server name. The checkbox that states `I use the Home Assistant Add-On`
  should be checked.

## Support

Got questions?

You have several options to get them answered:

- The [Home Assistant Discord chat server][discord-ha] for general Home
  Assistant discussions and questions.
- The Home Assistant [Community Forum][forum].
- Join the [Reddit subreddit][reddit] in [/r/homeassistant][reddit]

You could also [open an issue here][issue] GitHub.

## Contributing

Feel free to suggest improvements or fork to your liking.

I would also suggest you to read the official [contribution guidelines](CONTRIBUTING.md).

## Authors & contributors

The original work was done by [Franck Nijhof][frenck].

For a full list of all authors and contributors,
check [the contributor's page][contributors].

## License

MIT License

Copyright (c) 2018-2020 Franck Nijhof

Copyright (c) 2020 IceEyz

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[alpine-packages]: https://pkgs.alpinelinux.org/packages
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
[armhf-shield]: https://img.shields.io/badge/armhf-yes-green.svg
[armv7-shield]: https://img.shields.io/badge/armv7-yes-green.svg
[bonanitech]: https://github.com/bonanitech
[commits]: https://github.com/IceEyz/addon-node-red/commits/master
[contributors]: https://github.com/IceEyz/addon-node-red/graphs/contributors
[discord-ha]: https://discord.gg/c5DvZ4e
[discord-shield]: https://img.shields.io/discord/478094546522079232.svg
[discord]: https://discord.me/hassioaddons
[forum-shield]: https://img.shields.io/badge/community-forum-brightgreen.svg
[forum]: https://community.home-assistant.io/
[frenck]: https://github.com/frenck
[home-assistant]: https://home-assistant.io
[i386-shield]: https://img.shields.io/badge/i386-yes-green.svg
[issue]: https://github.com/IceEyz/addon-node-red-minimal/issues
[license-shield]: https://img.shields.io/github/license/hassio-addons/addon-node-red.svg
[node-red-nodes]: https://flows.nodered.org/?type=node&num_pages=1
[npm-packages]: https://www.npmjs.com
[reddit]: https://reddit.com/r/homeassistant