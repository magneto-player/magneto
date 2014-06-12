
# Copy somes globals references to help
# integration with browser side components.
global.document = window.document
global.navigator = window.navigator
window.nw = global.nw =
  gui: require('nw.gui')


# Initialize application
Magneto = require './lib/magneto'
magneto = new Magneto()

window.magneto = global.magneto = magneto

magneto.initialize()
