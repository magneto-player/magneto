
module.exports = devtools =
  initialize: ->
    @listenKeyboardShortcut()

  showDevTools: ->
    nw.gui.Window.get().showDevTools()

  listenKeyboardShortcut: ->
    {jwerty} = require 'jwerty'
    jwerty.key '⌘+alt+I', ->
      devtools.showDevTools()
