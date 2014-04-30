
View = require './view'
$ = require 'jquery'

class Workspace extends View
  @content: ->
    @div class: 'workspace', =>
      @h1 id: 'main-title'
      @div id: 'time'

      @a href: 'javascript:process.exit(0)', 'Quit'
      @br()
      @a href: 'javascript:nw.gui.Window.get().showDevTools()', 'Show dev tools'

  initialize: ->
    @find('#time').text(new Date())

module.exports = Workspace
