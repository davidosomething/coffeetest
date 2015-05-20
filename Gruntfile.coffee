module.exports = (grunt)->

  _ = require 'lodash'
  bundles = require './config/bundles.coffee'

  # Project configuration
  grunt.initConfig
    browserify: bundles.gruntConfig

    clean:
      css: 'dist/*'

    hogan:
      templates:
        src: 'templates/**/*.mustache'
        dest: 'app/templates.js'
        options: { binderName: 'nodejs' }

    karma:
      options:
        configFile: 'config/karma.conf.coffee'
      run:
        singleRun: true
      watch:
        background: true
        singlerun: false

    watch:
      templates:
        files: 'templates/**/*.mustache'
        tasks: ['hogan']

  grunt.loadNpmTasks 'grunt-browserify'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-hogan'
  grunt.loadNpmTasks 'grunt-karma'

  grunt.registerTask 'build', [ 'clean', 'hogan', 'browserify' ]
  grunt.registerTask 'test', [ 'karma:run' ]

  watchifyTasks = _.map(
    _.without(_.keys(bundles.gruntConfig), 'options'),
    (n)-> "browserify:#{n}"
  )
  bgTasks = [ 'karma:watch' ].concat(watchifyTasks, ['watch'])
  grunt.registerTask 'bg', bgTasks

  grunt.registerTask 'default', [ 'build' ]

