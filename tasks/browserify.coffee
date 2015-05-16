# node
path = require 'path'

# lib
_ = require 'lodash'
browserify = require 'browserify'

# transforms
browserifyShim = require('browserify-shim')
coffeeify = require('coffeeify')

# json
packageJson = require('../package.json')

appDir = path.dirname(__dirname) + '/app'

# ==============================================================================
# options ======================================================================

globalBundleOptions =
  basedir: 'app'
  bundleExternal: false
  extensions: ['.coffee']

# ==============================================================================
# utility functions ============================================================

# requiresToExternals
#
# @param {object} requires
# @return {array<string>}
requiresToExternals = (requires)->
  _.transform requires, (result, value, key)->
    result.push(key) if value is null
    result.push(value.expose) if value?.expose
    return
  , []

# bundle
#
# @param {object} args
# @option args {array<string>} files
# @option args {object} requires
# @option args {array<string>} externals
bundle = ({ files, bundleOptions, requires, externals })->
  files ?= []
  bundleOptions ?= globalBundleOptions
  b = browserify(files, bundleOptions)
  b.transform(coffeeify)
  b.transform(browserifyShim)
  _.each externals, (external)-> b.external(external)
  _.each requires, (value, key)->
    if value
      b.require(key, value)
    else
      b.require(key)

  return b.bundle()

# ==============================================================================
# global externals =============================================================

shims = packageJson['browserify-shim']
globalExternals = _.transform shims, (result, value, key)->
  isGlobal = value.indexOf('global:')
  result.push(key)
  return isGlobal
, []

# ==============================================================================
# bundling =====================================================================

tasks = {}

# vendor -----------------------------------------------------------------------
vendorRequires =
  backbone: null
  lodash: { expose: 'underscore' }

vendorExternals = requiresToExternals(vendorRequires)

tasks.bundleVendor = ->
  bundle({
    requires: vendorRequires
    externals: globalExternals
  })

# modules ----------------------------------------------------------------------
moduleRequires =
  './modules/base.coffee': null
  './modules/somemodule.coffee': null
moduleExternals = requiresToExternals(moduleRequires)

tasks.bundleModule = ->
  bundle({
    requires: moduleRequires
    externals: globalExternals
  })

# main -------------------------------------------------------------------------
mainExternals = ['backbone', 'underscore'].concat(
  globalExternals,
  moduleExternals
)
tasks.bundleMain = ->
  bundle({
    files: [ './app/main.coffee' ]
    externals: mainExternals
  })

module.exports = tasks
