
# Copy somes globals references to help
# integration with browser side components.
global.document = window.document
global.navigator = window.navigator
window.nw = global.nw =
  gui: require('nw.gui')


# Debugging
require './lib/debug/livereload'
require './lib/debug/devtools'



# Main
$ = require 'jquery'

$ ->
  $('#time').text(new Date())
