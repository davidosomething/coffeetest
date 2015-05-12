module.exports = (grunt)->

  _ = require 'lodash'
  bundleConfig = require './app/config/bundles.coffee'

  # Project configuration
  grunt.initConfig
    browserify: _.extend({
      options:
        browserifyOptions:
          extensions: ['.coffee']
        debug: true
        transform: ['coffeeify']
    }, bundleConfig)

  grunt.loadNpmTasks 'grunt-browserify'

  grunt.registerTask 'default', [ 'browserify' ]

