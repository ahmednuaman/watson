_ = require 'lodash'
fs = require 'fs'
Spooky = require 'spooky'

module.exports = (base, filesToTest, verbose = false) ->
  # Init [`Spooky`](https://github.com/WaterfallEngineering/SpookyJS).
  browser = new Spooky
    child:
      transport: 'http'
    casper:
      logLevel: if verbose then 'debug' else 'error'
      verbose: verbose