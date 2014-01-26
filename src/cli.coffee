# Use [Optimist](http://npmjs.org/package/optimist) to create a nice CLI.
watson = require './watson'
argv = require('optimist')
        .usage("watson is a CasperJS HTML assessor; simply pass in a base file and some HTML files or directories and bingo.
          \nUsage: watson base.html folder/**/*.html")
        .demand(1)
        .argv

# Pass the `argv` files glob to [`watson.coffee`](watson.html) to be processed.
watson argv._