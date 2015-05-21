_ = require 'underscore'
$ = require 'jquery'
Backbone = require 'backbone'
Backbone.$ = $
Modernizr = require 'modernizr'

Base = require 'modules/base'
something = require 'modules/somemodule'
moduleb = require 'module-b/module-b'
ReactView = require 'modules/ReactView'

templates = require 'templates'

console.log('this is the entry point')

a = new Base()
a.log()

moduleb()

something()

console.log('backbone in scope:', Backbone)
console.log('modernizr shimmed from window:', Modernizr)
console.log('$ shimmed from window.jQuery:', $)

class V extends Backbone.View
  el: '#vtest'

  initialize: (options = {})->
    console.log(@$el)
    return

  render: ->
    @$el.html('<strong>view rendered</strong>')
    return

myView = new V()

$ ->
  myView.render()
  $(templates.article()).appendTo('#template-fixture')
  $(templates.hr()).appendTo('#template-fixture')

console.log('underscore is', _.VERSION)


