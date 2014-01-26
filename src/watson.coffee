_ = require 'lodash'
fs = require 'fs'

module.exports = (files) ->
  # Set the base file for comparison.
  base = files[0]

  # Now set the files to test.
  filesToTest = _.rest files