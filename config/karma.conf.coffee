module.exports = (config)->

  _ = require 'lodash'
  bundleConfig = require './bundles.coffee'

  config.set

    browsers:  [ 'PhantomJS' ]

    frameworks: [
      # testing
      'mocha'
      # assertion
      'chai-sinon' # peerdep version
      'chai-as-promised'
      'jquery-chai' # peerdep version
      # compilation
      'browserify'
    ]

    # out of the config/ dir
    basePath: '../'

    files: [
      'http://cdnjs.cloudflare.com/ajax/libs/modernizr/2.8.3/modernizr.min.js'
      'http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.4/jquery.min.js'
      'dist/bundles/**/*.js'
      'test/**/*.coffee'
    ]

    # Don't apply karma-coverage preprocessor since all it does it istanbulify
    # coffee files. Browserify-istanbul will do that
    preprocessors:
      'test/**/*.coffee': [ 'browserify' ]

    browserify:
      debug: true # sourcemapping, thx
      transform: [ 'coffeeify', 'browserify-shim', 'browserify-istanbul' ]
      extensions: [ '.coffee', '.js', '.jsx' ]
      configure: (b)->
        # Specify external bundles
        b.on 'prebundle', ->
          _.each bundleConfig.allExternals, (e)-> b.external(e)

    reporters: [ 'spec', 'DHTML', 'coverage' ]

    dhtmlReporter:
      outputFile: '/reports/karma/report.html'
      exclusiveSections: true
      openReportInBrowser: false

    coverageReporter:
      dir: 'reports/coverage/'
      reporters: [
        { type: 'cobertura', subdir: 'cobertura' }
        { type: 'lcovonly', subdir: 'lcov' }
      ]


