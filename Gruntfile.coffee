module.exports = (grunt)->

  _ = require 'lodash'

  # Project configuration
  grunt.initConfig
    browserify: require './config/bundles.coffee'

  grunt.loadNpmTasks 'grunt-browserify'

  grunt.registerTask 'default', [ 'browserify' ]

