StatusbarView = require './views/statusbar'
path = require 'path'

class Statusbar
  initialize: ->
    @statusbarView = new StatusbarView()
    @statusbarView.appendTo('body')

    niceplay.on 'file:new', @load

    niceplay.on '!player:play', @play
    niceplay.on '!player:pause', @pause
    niceplay.on '!player:stop', @stop

  play: =>
    @statusbarView.setIcon 'icon-play'

  pause: =>
    @statusbarView.setIcon 'icon-pause'

  stop: =>
    @statusbarView.setIcon 'icon-stop'

  load: (fileName) =>
    @statusbarView.setTitle(
      path.basename(
        fileName
      )
    )

module.exports = Statusbar
