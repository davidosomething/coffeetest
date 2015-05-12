# window.globalbase is available to browser window object
# and exported as commonjs module

module.exports = window.globalbase = class Base

  log: ->
    console.log('this is base')

