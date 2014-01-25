_ = require 'lodash'
fs = require 'fs'
glob = require 'glob'

module.exports = (files) ->
  # The files we want to cover.
  htmlFiles = []

  # What we're looking for.
  ext = 'html'

  # Flatten files into a nice array.
  files = _.flatten files

  # Expand any directories.
  _.forEach files, (file) ->
    fileExt = file.split('.').pop()

    if fileExt isnt ext
      # Check if this `file` is a directory. If it is then file all the `.html` files inside, otherwise ignore it
      if fs.lstatSync(file).isDirectory()
        # Check for trailing `/`.
        file = if file.charAt(file.length - 1) isnt '/' then file + '/' else file

        # Get html files in this directory and push it into the `htmlFiles` array.
        htmlFiles.concat glob.sync file + '**/*.' + ext

    else
      # Add this `.html` file to the `htmlFiles` array.
      htmlFiles.push file