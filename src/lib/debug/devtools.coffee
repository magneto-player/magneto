
module.exports = devtools =
  initialize: ->
    @showDevTools()
    @listenKeyboardShortcut()

  showDevTools: ->
    nw.gui.Window.get().showDevTools()

  listenKeyboardShortcut: ->
    {jwerty} = require 'jwerty'
    jwerty.key '⌘+alt+I', ->
      console.log 'Devtools: open dev tools'
      devtools.showDevTools()
