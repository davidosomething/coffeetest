# Browserify bundle config

_ = require 'lodash'
banner = require './banner.coffee'

config = {}

################################################################################

externalBundles = {}

# vendor =======================================================================

externalBundles.vendor =
  require: [
    'lodash'
  ]

# modules ======================================================================

externalBundles.modules =
  alias: [
    'modules/base'
    'modules/somemodule'
  ]

# module-b =====================================================================

externalBundles['module-b'] =
  alias: [
    'module-b/module-b'
  ]


################################################################################

bundles = {}

# main =========================================================================

bundles.main =
  entry: 'main.coffee'

# subapp =======================================================================

bundles.subapp =
  entry: 'subapp/subapp.coffee'

################################################################################

externals = []

# external bundle config =======================================================

_.each externalBundles, (settings, bundleName)->
  bundleConfig =
    dest: "dist/#{bundleName}.js"
    src: []
    options:
      banner: banner(bundleName, settings)
      alias: {}
      require: settings.require

  _.each settings.alias, (alias)->
    bundleConfig.options.alias[alias] = "./app/#{alias}"

  externals = _.compact externals.concat(settings.alias, settings.require)
  config[bundleName] = bundleConfig

# entry points config ==========================================================

_.each bundles, (settings, bundleName)->
  bundleConfig =
    dest: "dist/#{bundleName}.js"
    src: []
    options:
      banner: banner(bundleName, settings)
      external: externals

  bundleConfig.src.push("app/#{settings.entry}") if settings.entry
  config[bundleName] = bundleConfig

################################################################################

module.exports = config
