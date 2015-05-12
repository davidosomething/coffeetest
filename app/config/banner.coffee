module.exports = (bundleName, settings)->

  _ = require 'lodash'

  filename = "#{bundleName}.js"

  sources = _.compact _.flatten([
    settings.entry
    settings.require
    settings.alias
  ])

  """
  /*!
   * #{filename}
   * Last generated <%= grunt.template.today("yyyy-mm-dd") %>
   * Sources: #{sources}
   */
  """

