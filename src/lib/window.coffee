
$ = require 'jquery'

# todo: https://github.com/rogerwang/node-webkit/wiki/Preserve-window-state-between-sessions

class Window
  fullScreenClass: 'full-screen'

  constructor: ->
    @_win = nw.gui.Window.get()

    @_$html = $('html')
    @_win.on 'enter-fullscreen', => @_$html.addClass @fullScreenClass
    @_win.on 'leave-fullscreen', => @_$html.removeClass @fullScreenClass

    niceplay.on '!window:maximize', @maximize
    niceplay.on '!window:minimize', @minimize
    niceplay.on '!window:toggle-fullscreen', @toggleFullscreen
    niceplay.on '!window:enter-fullscreen', @enterFullscreen
    niceplay.on '!window:leave-fullscreen', @leaveFullscreen
    niceplay.on '!window:exit', @exit
    niceplay.on '!window:set-title', @setTitle

  maximize: =>
    @_win.maximize()
  minimize: =>
    @_win.minimize()

  toggleFullscreen: =>
    @_win.toggleFullscreen()
  enterFullscreen: =>
    @_win.enterFullscreen()
  leaveFullscreen: =>
    @_win.leaveFullscreen()

  exit: =>
    @_win.close()

  setTitle: (title) =>
    @_win.title = title

module.exports = Window
