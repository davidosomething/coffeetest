# Browserify bundle config

_ = require 'lodash'
banner = require './banner.coffee'

config =
  options:
    browserifyOptions:
      extensions: ['.coffee']
    transform: ['coffeeify', 'browserify-shim']

################################################################################
# Format:
# require <array{string}> where string is in node_modules
# alias thingToReplace (name of module), thingToReplaceWith (name of module)
# modules <array{string}> where string is relative to ./app/

externalBundles = {}

# vendor =======================================================================

externalBundles.vendor =
  require: [
    'backbone'
  ]

  # replace all instances of underscore with lodash
  alias:
    'lodash': 'underscore'

# modules ======================================================================

externalBundles.modules =
  modules: [
    'modules/base'
    'modules/somemodule'
  ]

# module-b =====================================================================

externalBundles['module-b'] =
  modules: [
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

  # real aliases
  _.each settings.alias, (alias, desired)->
    bundleConfig.options.alias[alias] = desired

  # local aliases
  _.each settings.modules, (alias)->
    bundleConfig.options.alias[alias] = "./app/#{alias}"

  externals = _.compact externals.concat(
    _.values(settings.alias),
    settings.modules,
    settings.require
  )
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
