Base = require 'modules/base'
something = require 'modules/somemodule'
moduleb = require 'module-b/module-b'

console.log('this is the entry point')

a = new Base()
a.log()

moduleb()

something()

