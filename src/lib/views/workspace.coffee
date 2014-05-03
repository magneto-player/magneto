
View = require './view'
$ = require 'jquery'

class Workspace extends View
  @content: ->
    @div class: 'workspace'

  initialize: ->
    @_win = nw.gui.Window.get()

    niceplay.on '!toggle-fullscreen', @toggleFullscreen
    niceplay.on '!enter-fullscreen', @enterFullscreen
    niceplay.on '!leave-fullscreen', @leaveFullscreen

    @_win.on 'enter-fullscreen', ->
      $('html').addClass 'full-screen'

    @_win.on 'leave-fullscreen', ->
      $('html').removeClass 'full-screen'

  maximize: ->
    @_win.maximize()

  minimize: ->
    @_win.minimize()

  toggleFullscreen: =>
    @_win.toggleFullscreen()
  enterFullscreen: =>
    @_win.enterFullscreen()
  leaveFullscreen: =>
    @_win.leaveFullscreen()

module.exports = Workspace
