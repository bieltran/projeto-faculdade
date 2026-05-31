const path = require('path');
const { getDefaultConfig } = require('expo/metro-config');

const config = getDefaultConfig(__dirname);

config.resolver.extraNodeModules = {
  ...config.resolver.extraNodeModules,
  'expo-asset': path.resolve(__dirname, 'node_modules/expo-asset'),
};

module.exports = config;
