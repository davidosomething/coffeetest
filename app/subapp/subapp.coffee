_ = require 'lodash'
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

