_ = require 'lodash'
watson = require './watson'

# Use [Optimist](http://npmjs.org/package/optimist) to create a nice CLI.
argv = require('optimist')
        .usage("watson is a CasperJS HTML assessor; simply pass in a base file and some HTML files or directories and bingo.
          \nUsage: watson [-v] base.html folder/**/*.html")
        .demand(1)
        .argv

# Cache the files.
files = argv._

# Set the base file for comparison.
base = files[0]

# Now set the files to test.
filesToTest = _.rest files

# Pass the `base` and `filesToTest` to [`watson.coffee`](watson.html) to be assessed.
watson base, filesToTest, argv.v