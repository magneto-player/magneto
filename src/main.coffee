
# Copy somes globals references to help
# integration with browser side components.
global.document = window.document
global.navigator = window.navigator
global.MediaLoader = window.MediaLoader
window.nw = global.nw =
  gui: require('nw.gui')


# Initialize application
NicePlay = require './lib/niceplay'
niceplay = new NicePlay()
niceplay.initialize()

global.require.cache['niceplay'] = niceplay
