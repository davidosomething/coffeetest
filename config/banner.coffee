module.exports = (bundleName, settings)->

  _ = require 'lodash'

  filename = "#{bundleName}.js"

  sources = _.compact _.flatten([
    settings.entry
    _.keys settings.alias
    settings.modules
    settings.require
  ])

  """
  /*!
   * #{filename}
   * Last generated <%= grunt.template.today("yyyy-mm-dd") %>
   * Sources: #{sources}
   */
  """

