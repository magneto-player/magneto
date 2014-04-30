
PlayerView = require './views/player'
KeyboardShortcut = require './keyboard-shortcut'

class Player
  constructor: ->
    @playerView = new PlayerView
    niceplay.workspace.append @playerView

    niceplay.on 'file:new', @load

    niceplay.on '!player:play', @play
    niceplay.on '!player:pause', @pause
    niceplay.on '!player:stop', @stop

    # Shortcut
    @playerShortcut = new KeyboardShortcut

  load: (url) =>
    @playerView.setFile(url)

  play: =>
    @playerView.play()

  pause: =>
    @playerView.pause()

  stop: =>
    @playerView.stop()


module.exports = Player
