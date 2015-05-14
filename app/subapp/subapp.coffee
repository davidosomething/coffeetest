_ = require 'underscore'
AnotherBase = require 'modules/base'
AnotherSomething = require 'modules/somemodule'

console.log('subapp base', AnotherBase)

test = [
  'this'
  'is'
  'a'
  'test'
]

_.each test, (t)->
  console.log(t)

console.log('in subapp, _ is', _.VERSION)
console.log('in subapp, Backbone is', typeof Backbone)
