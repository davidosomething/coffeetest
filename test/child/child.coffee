child = require '../../app/child/child'

describe 'child', ->

  it 'should be 10 years old', ->
    expect(child._age).to.equal 10

