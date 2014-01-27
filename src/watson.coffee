fs = require 'fs'
jsdom = require 'jsdom'

module.exports = (base, filesToTest, verbose = false) ->
  baseExpectations = []
  processChildren = 0

  # Create our helper functions. First we start off with `loadDOM` that takes a file path, grabs the content and runs it
  # it [`jsdom`](https://github.com/tmpvar/jsdom).
  loadDOM = (file, cb) ->
    content = readFile file

    jsdom.env
      html: content
      # Inject [jQuery](http://jquery.com/) for helpfulness.
      src: [
        jQuery
      ]
      done: (err, window) ->
        if err
          return showError err

        cb window

  processedChild = () ->
    if --processChildren is 0
      console.log baseExpectations

  readChildren = ($, element) ->
    children = element.children()
    processChildren++

    # Check to see if this `element` has any children.
    if children.length
      # Read the `element`'s children and iterate over them to set the `baseExpectations`.
      children.each () ->
        child = $ @

        baseExpectations.push element.prop('tagName') + ' > ' + child.prop('tagName')

        readChildren $, child

  readFile = (file) ->
    fs.readFileSync file, 'utf-8'

  showError = (err) ->
    console.error err

  # Cache jQuery locally.
  jQuery = readFile './node_modules/jquery/dist/jquery.js'

  # Load the `base` file and cache its expectations for `watson` to assess.
  loadDOM base, (window) ->
    # `watson` builds its base expectations by querying the DOM's children, interating of each child's child and so on;
    # this is then used to assess the DOMs of the files to be tested and helps check their integrity.
    readChildren window.$, window.$ 'html'