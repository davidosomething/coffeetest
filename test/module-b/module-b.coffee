moduleb = require '../../app/module-b/module-b'

describe 'module-b FAILING TEST CASE', ->

  it 'should be return "no"', ->
    expect(moduleb()).to.equal "no"

