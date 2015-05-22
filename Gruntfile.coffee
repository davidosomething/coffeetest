module.exports = (grunt)->

  require 'mocha-clean'
  _ = require 'lodash'
  bundles = require './config/bundles.coffee'

  # Project configuration
  grunt.initConfig
    browserify: bundles.gruntConfig

    clean:
      all: [ 'dist/*', 'build/*' ]

    hogan:
      templates:
        src: 'templates/**/*.mustache'
        dest: 'app/templates.js'
        options:
          binderName: 'nodejs'
          exposeTemplates: true

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
        tasks: [ 'hogan' ]
      bundles:
        files: 'build/**/*.js'
        tasks: [  'uglify' ]

    uglify:
      all:
        options:
          preserveComments: 'some'
          report: 'min'
          screwIE8: true
          sourceMap: true
        files: [{
          expand: true,
          cwd: 'build',
          src: '**/*.js',
          dest: 'dist'
          ext: '.min.js'
        }]

  grunt.loadNpmTasks 'grunt-browserify'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-hogan'
  grunt.loadNpmTasks 'grunt-karma'

  grunt.registerTask 'build', [ 'clean', 'hogan', 'browserify', 'uglify' ]
  grunt.registerTask 'test', [ 'karma:run' ]

  watchifyTasks = _.map(
    _.without(_.keys(bundles.gruntConfig), 'options'),
    (n)-> "browserify:#{n}"
  )
  bgTasks = [ 'karma:watch' ].concat(watchifyTasks, ['watch'])
  grunt.registerTask 'bg', bgTasks

  grunt.registerTask 'default', [ 'build' ]

