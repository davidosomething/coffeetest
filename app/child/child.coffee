Parent = require('parent/parent')

module.exports = class Child extends Parent

  @_age = 10

  constructor: ->
    super
    return

  isAdult: ->
    return false

