# Browserify bundle config

_       = require 'lodash'
util    = require 'util'
pkgJson = require '../package.json'

banner  = require './banner.coffee'

config =
  options:
    browserifyOptions:
      extensions: ['.coffee']
    transform: ['coffeeify', 'browserify-shim']

################################################################################
# Format:
# require <array{string}> where string is in node_modules
# alias <array{string}> [required:useInstead]
# modules <array{string}> where string is relative to ./app/

externalBundles = {}

# vendor =======================================================================

externalBundles.vendor =
  require: [
    'backbone'
  ]

  # replace all instances of underscore with lodash
  alias: {
    'lodash': 'underscore'
  }

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

# add each global shim as an external
externals = []
_.each pkgJson['browserify-shim'], (value, key)->
  externals.push(key) if /^global\:/.test(value)

baseBundleConfig =
  src: []
  options:
    external: externals

# external bundle config =======================================================

_.each externalBundles, (settings, bundleName)->
  bundleConfig = _.merge {}, baseBundleConfig,
    dest: "dist/#{bundleName}.js"
    options:
      banner: banner(bundleName, settings)
      alias: {}
      require: settings.require # maybe undefined

  # real aliases
  _.each settings.alias, (alias, desired)->
    bundleConfig.options.alias[alias] = desired

  # local aliases
  _.each settings.modules, (alias)->
    bundleConfig.options.alias[alias] = "./app/#{alias}"

  # update externals for entry point bundles to use later
  externals = _.compact _.union(
    externals,
    _.values(settings.alias),
    settings.modules,
    settings.require
  )

  console.log bundleConfig if bundleName is 'vendor'
  config[bundleName] = bundleConfig


# entry points config ==========================================================

_.each bundles, (settings, bundleName)->
  bundleConfig = _.merge {}, baseBundleConfig,
    dest: "dist/#{bundleName}.js"
    options:
      banner: banner(bundleName, settings)
      external: externals

  bundleConfig.src.push("./app/#{settings.entry}") if settings.entry
  config[bundleName] = bundleConfig

################################################################################

module.exports = config
