#!/usr/bin/with-contenv bashio
# ==============================================================================
# Home Assistant Community Add-on: Node-RED-Minimal
# Configures Node-RED before running
# ==============================================================================

# Ensure the credential secret value is set
if bashio::config.is_empty 'credential_secret'; then
    bashio::log.fatal
    bashio::log.fatal 'Configuration of this add-on is incomplete.'
    bashio::log.fatal
    bashio::log.fatal 'Please be sure to set the "credential_secret" option.'
    bashio::log.fatal
    bashio::log.fatal 'The credential secret is an encryption token, much like'
    bashio::log.fatal 'a password, that is used by Node-RED for encrypting'
    bashio::log.fatal 'credentials you put into Node-RED.'
    bashio::log.fatal
    bashio::log.fatal 'Just like a password, a credential secret can be'
    bashio::log.fatal 'anything you like. Just be sure to store it somewhere'
    bashio::log.fatal 'safe for later, e.g., in case of a recovery.'
    bashio::log.fatal
    bashio::exit.nok
fi

# Ensure configuration exists
if ! bashio::fs.directory_exists '/config/node-red/'; then
    mkdir -p /config/node-red/nodes \
        || bashio::exit.nok "Failed to create node-red configuration directory"

    # Copy in template files
    cp /etc/node-red/flows.json /config/node-red/
    cp /etc/node-red/settings.js /config/node-red/

    # Create random flow id
    id=$(node -e "console.log((1+Math.random()*4294967295).toString(16));")
    sed -i "s/%%ID%%/${id}/" "/config/node-red/flows.json"
fi

# Ensures conflicting Node-RED packages are absent
cd /config/node-red || bashio::exit.nok "Could not change directory to Node-RED"
if bashio::fs.file_exists "/config/node-red/package.json"; then
    npm uninstall \
        node-red-contrib-home-assistant \
        node-red-contrib-home-assistant-llat \
        node-red-contrib-home-assistant-ws \
        node-red-dashboard \
        node-red-node-pi-gpio \
            || bashio::exit.nok "Failed un-installing conflicting packages"
fi
