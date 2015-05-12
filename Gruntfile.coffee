module.exports = (grunt)->

  # Project configuration
  grunt.initConfig
    browserify:
      options:
        transform: ['coffeeify']
        browserifyOptions:
          extensions: ['.coffee']

      modules:
        dest: 'dist/modules.js'
        src: []
        options:
          require: [
            './app/base'
            './app/somemodule'
          ]

      main:
        dest: 'dist/main.js'
        src: ['app/main.coffee']
        options:
          external: [
            '/app/base'
            '/app/somemodule'
          ]

      subapp:
        dest: 'dist/subapp.js'
        src: ['app/subapp/subapp.coffee']
        options:
          external: [
            '/app/base'
            '/app/somemodule'
          ]

  grunt.loadNpmTasks 'grunt-browserify'

  grunt.registerTask 'default', [
    'browserify'
  ]
