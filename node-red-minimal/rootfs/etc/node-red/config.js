const config = require('/config/node-red/settings.js');
const fs = require('fs');
const options = JSON.parse(fs.readFileSync('/data/options.json', 'utf8'));
const bcrypt = require('bcryptjs');

// Set dark theme if enabled
if (options.dark_mode) {
    config.editorTheme.page = {
        css: '/opt/node_modules/@node-red-contrib-themes/midnight-red/theme.css',
    };
}

// Sane and required defaults for the add-on
config.debugUseColors = false;
config.flowFile = 'flows.json';
config.nodesDir = '/config/node-red/nodes';
config.uiPort = 8099;
config.userDir = '/config/node-red/';

//Disable httpNodeRoot, since we will not expose beyond the interne HASS network
config.httpNodeRoot = false;

// Disable authentication, let HA handle that
config.adminAuth = null;

// Disable SSL, since the add-on handles that
config.https = null;

// Several settings
config.credentialSecret = options.credential_secret;

// Set debug level
if (options.log_level) {
    config.logging.console.level = options.log_level.toLowerCase();
    if (config.logging.console.level === 'warning') {
        config.logging.console.level = 'warn';
    }
}

module.exports = config;
