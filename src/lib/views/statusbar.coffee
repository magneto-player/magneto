View = require './view'

class StatusbarView extends View
  @content: () ->
    @div class: 'statusbar', =>
      @h1 id: 'main-title', 'NicePlayer'

      @div id:'title', 'No file loaded'

      @div class: 'icon-state', =>
        @i
      @div class: 'btn-group', =>
        @a class: 'btn-max', href: 'javascript:nw.gui.Window.get().maximize()', '+'
        @a class: 'btn-min', href: 'javascript:nw.gui.Window.get().minimize()', '-'
        @a class: 'btn-close', href: 'javascript:process.exit(0)', 'x'
        @a class: 'btn-full', href: 'javascript:nw.gui.Window.get().toggleFullscreen()', '<-->'

  initialize: ->
    @find('.btn-group')
      .addClass('.btn-left')

  setTitle: (title) ->
    @find('#title').html(title)

  setIcon: (icon) ->
    @find('.icon').find('i')
      .removeClass()
      .addClass(icon)

module.exports = StatusbarView
