View = require './view'

class StatusbarView extends View
  @content: () ->
    @header class: 'status-bar', =>
      @ul class:'os-nav', =>
        @li class: 'os-nav-item os-nav-item-close', =>
          @a href: '#'
        @li class: 'os-nav-item os-nav-item-min', =>
          @a href: '#'
        @li class: 'os-nav-item os-nav-item-max', =>
          @a href: '#'

      @div class: 'title-file'

      @a class:'fullscreen', href: '#', 'fullscreen'

  initialize: ->
    @on 'click', '.os-nav-item-close', -> process.exit(0)
    @on 'click', '.os-nav-item-min', -> nw.gui.Window.get().minimize()
    @on 'click', '.os-nav-item-max', -> nw.gui.Window.get().maximize()
    @on 'click', '.fullscreen', -> nw.gui.Window.get().toggleFullscreen()

  setTitle: (title) ->
    @find('.title-file').html(title)
    nw.gui.Window.get().title = title

  setIcon: (icon) ->
    @find('.icon').find('i')
      .removeClass()
      .addClass(icon)

module.exports = StatusbarView
