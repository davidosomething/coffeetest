# Browserify bundle config
# Define grunt config for aliases, external bundles, and main bundles

_       = require 'lodash'
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
# alias {object} key thing to use instead of value when require(value)
# modules <array{string}> where string is relative to ./app/

externalBundles = {}

# vendor - node_modules packages that are requirable and externally bundled
externalBundles.vendor =
  # require and expose backbone as an external
  require: [
    'backbone'
  ]

  # example alias - require lodash and provide lodash when any instance of
  # require('underscore') is found. It is requirable only as 'underscore'
  # in the app/subapps
  alias: {
    'lodash': 'underscore'
  }

# example module -- note the paths are all relative to ./app/
# it is externally bundled so subapps can require it
# E.g. Backbone objects and controller functions
externalBundles.modules =
  modules: [
    'modules/base'
    'modules/somemodule'
  ]

# example provides external for require('module-b/module-b')
externalBundles['module-b'] =
  modules: [
    'module-b/module-b'
  ]


################################################################################
# These are the main bundles that do not export anything -- they run code and
# require other bundles
# E.g. the main app.js

bundles = {}

# main
bundles.main =
  entry: 'main.coffee'

# subapp
bundles.subapp =
  entry: 'subapp/subapp.coffee'

################################################################################

# add each global shim as an external so it doesn't need to be bundled
externals = []
_.each pkgJson['browserify-shim'], (value, key)->
  externals.push(key) if /^global\:/.test(value)

# object skeleton
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
