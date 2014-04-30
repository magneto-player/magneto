
PlayerView = require './views/player'

class Player
  constructor: ->
    @playerView = new PlayerView
    niceplay.workspace.append @playerView

    niceplay.on 'file:new', @load

    niceplay.on '!player:play', @play
    niceplay.on '!player:pause', @pause
    niceplay.on '!player:stop', @stop
    niceplay.on '!player:toggle', @toggle

  load: (url) =>
    @playerView.setFile(url)

  play: =>
    @playerView.play()

  pause: =>
    @playerView.pause()

  stop: =>
    @playerView.stop()

  toggle: =>
    @playerView.toggle()

module.exports = Player
