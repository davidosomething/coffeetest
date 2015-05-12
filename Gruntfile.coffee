module.exports = (grunt)->

  # Project configuration
  grunt.initConfig
    coffee:
      options:
        bare: true
      app:
        expand: true
        cwd:    'app'
        src:    [ '**/*.coffee' ]
        dest:   'build/'
        ext:    '.js'

    browserify:
      modules:
        dest: 'dist/modules.js'
        src: []
        options:
          preBundleCB: (b)->
            b.plugin('remapify', [{
              cwd:    './build/modules/'
              src:    '**/*'
              expose: 'modules'
            }])
          require: [
            'modules/base'
            'modules/somemodule'
          ]

      main:
        dest: 'dist/main.js'
        src: ['build/main.js']
        options:
          external: [
            'modules/base'
            'modules/somemodule'
          ]

      subapp:
        dest: 'dist/subapp.js'
        src: ['build/subapp/subapp.js']
        options:
          external: [
            'modules/base'
            'modules/somemodule'
          ]

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-browserify'

  grunt.registerTask 'default', [
    'coffee'
    'browserify'
  ]
