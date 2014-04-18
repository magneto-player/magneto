config = require('../../package.json')

if config.debug
  {jwerty} = require 'jwerty'

  jwerty.key '⌘+alt+I', ->
    console.log 'Devtools: open dev tools'
    nw.gui.Window.get().showDevTools()
