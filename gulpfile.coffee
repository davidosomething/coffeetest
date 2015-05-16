gulp = require 'gulp'

# task modules -----------------------------------------------------------------
browserifyTasks = require './tasks/browserify'

# task: gulp -------------------------------------------------------------------
gulp.task 'default', ->
  browserifyTasks.bundleModule()
    .pipe(process.stdout)
  return

  browserifyTasks.bundleVendor()
    .pipe(source('vendor.js'))
    .pipe(gulp.dest('./dist/'))

  browserifyTasks.bundleMain()
    .pipe(source('main.js'))
    .pipe(gulp.dest('./dist/'))

