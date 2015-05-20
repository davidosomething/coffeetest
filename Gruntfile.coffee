module.exports = (grunt)->

  _ = require 'lodash'

  # Project configuration
  grunt.initConfig
    browserify: require './config/bundles.coffee'
    clean:
      css:         'dist/*'

  grunt.loadNpmTasks 'grunt-browserify'
  grunt.loadNpmTasks 'grunt-contrib-clean'

  grunt.registerTask 'default', [ 'clean', 'browserify' ]

