# Home Assistant Community Add-on: Emoncms

[Emoncms][0] is a powerful open-source web-app for processing, logging and visualising energy, temperature and other environmental data.

This addon packages the installation allowing you to run it easily along side your existing Home Assistant installation.

## Installation

You can install this addon like how you would any 3rd party addon.

1. Navigate within your Home Assistant frontend to __Supervisor__ then __Add-on Store__

2. Click the 3-dots menu at upper right, then __Repositories__ and add this repository URL: https://github.com/inverse/hassio-addon-emoncms

3. Once added, scroll down the page to find the new repository section, click on the addon titled "Emoncms"

## Configuration

__Note__: _Remember to restart the add-on when the configuration is changed._

Example add-on configuration:

```yaml
log_level: info
ssl: false
certfile: fullchain.pem
keyfile: privkey.pem
```

__Note__: _This is just an example, don't copy and past it! Create your own!_

### Option: `log_level`

The `log_level` option controls the level of log output by the addon and can
be changed to be more or less verbose, which might be useful when you are
dealing with an unknown issue. Possible values are:

- `trace`: Show every detail, like all called internal functions.
- `debug`: Shows detailed debug information.
- `info`: Normal (usually) interesting events.
- `warning`: Exceptional occurrences that are not errors.
- `error`: Runtime errors that do not require immediate action.
- `fatal`: Something went terribly wrong. Add-on becomes unusable.

Please note that each level automatically includes log messages from a
more severe level, e.g., `debug` also shows `info` messages. By default,
the `log_level` is set to `info`, which is the recommended setting unless
you are troubleshooting.

### Option: `ssl`

Enables/Disables SSL (HTTPS) on the web interface of Emoncms
Panel. Set it `true` to enable it, `false` otherwise.

### Option: `certfile`

The certificate file to use for SSL.

__Note__: _The file MUST be stored in `/ssl/`, which is the default_

### Option: `keyfile`

The private key file to use for SSL.

__Note__: _The file MUST be stored in `/ssl/`, which is the default_

### Option: `remote_mysql_host`

If using an external database, the hostname/address for the MySQL/MariaDB database.

Only applies if a remote MySQL database is used, the username with permissions.

### Option: `remote_mysql_password`

Only applies if a remote MySQL database is used, the password of the above user.

### Option: `remote_mysql_port`

Only applies if a remote MySQL database is used, the port that the database
server is listening on.

## Database usage

By default, Emoncms will automatically use and configure the Home Assistant
MariaDB addon which should be installed prior to startup, this can be changed
within the configuration to use an external MySql/MariaDB Database. Please note
that there is no easy upgrade path between the two options.

## Known issues and limitations

Please report any issues.

- [EmonESP][1] does not currently support parsing the port from the "Emoncms Server" input field, making it complex to map this addon on a non-standard HTTP port. See [issue][2]

## License

MIT License

[0]: https://emoncms.org/
[1]: https://github.com/openenergymonitor/EmonESP
[2]: https://github.com/inverse/hassio-addon-emoncms/issues/13
