module.exports = (bundleName, settings)->

  _ = require 'lodash'

  filename = "#{bundleName}.js"

  sources = _.compact _.flatten([
    settings.entry
    _.keys(settings.alias)
    settings.modules
    settings.require
  ])

  """
  /*!
   * #{filename} last generated <%= grunt.template.today("yyyy-mm-dd") %>
   * Provides: #{sources}
   */
  """

