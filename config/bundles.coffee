# Browserify bundle config

_       = require 'lodash'
pkgJson = require '../package.json'

banner  = require './banner.coffee'

gruntConfig =
  options:
    browserifyOptions:
      extensions: ['.cjsx', '.coffee']
    transform: ['coffee-reactify', 'browserify-shim']
    watch: true # use watchify binary instead of browserify

################################################################################
# Format:
# require <array{string}> where string is in node_modules
# alias <array{string}> [required:useInstead]
# modules <array{string}> where string is relative to ./app/

externalBundles = {}

# vendor =======================================================================
externalBundles['vendor'] =
  require: [ 'backbone', 'react' ]
  alias: { 'lodash': 'underscore' } # replace "underscore" with "lodash"

# templates ====================================================================
# Run hogan before compiling these!
externalBundles['templates'] =
  modules: [ 'templates' ]

# modules ======================================================================
externalBundles['modules/modules'] =
  modules: [
    'modules/base'
    'modules/somemodule'
    'modules/ReactView'
  ]

# module-b =====================================================================
externalBundles['module-b/module-b'] =
  modules: [ 'module-b/module-b' ]

# parent =======================================================================
externalBundles['parent/parent'] =
  modules: [ 'parent/parent' ]

# child ========================================================================
externalBundles['child/child'] =
  modules: [ 'child/child' ]

################################################################################

bundles = {}

# main =========================================================================

bundles.main =
  entry: 'main.coffee'

# subapp =======================================================================

bundles.subapp =
  entry: 'subapp/subapp.coffee'

################################################################################

# external bundle config =======================================================

_.each externalBundles, (settings, bundleName)->
  bundleConfig =
    src: []
    dest: "dist/bundles/#{bundleName}.js"
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

  bundleConfig.provides = _.compact [].concat(
    _.values(settings.alias),
    settings.modules,
    settings.require
  )
  gruntConfig[bundleName] = bundleConfig

# entry points config ==========================================================

_.each bundles, (settings, bundleName)->
  bundleConfig =
    src: ["./app/#{settings.entry}"]
    dest: "dist/entry/#{bundleName}.js"
    options:
      banner: banner(bundleName, settings)
  gruntConfig[bundleName] = bundleConfig

################################################################################

# Map externals

# add each global shim as an external
globalExternals = []
_.each pkgJson['browserify-shim'], (value, key)->
  globalExternals.push(key) if /^global\:/.test(value)

# combine all the bundleConfig.provides into one big array
moduleExternals = _.compact _.flatten _.pluck(gruntConfig, 'provides')
allExternals = [].concat(globalExternals, moduleExternals)

# add externals to each bundleConfig
gruntConfig = _.transform gruntConfig, (result, config, bundleName)->
  if bundleName isnt 'options'
    config.options.external = _.difference allExternals, config.provides
  result[bundleName] = config
  return

################################################################################

module.exports =
  gruntConfig: gruntConfig
  globalExternals: globalExternals
  moduleExternals: moduleExternals
  allExternals: allExternals

