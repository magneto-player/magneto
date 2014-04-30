StatusbarView = require './views/statusbar'

class Statusbar
  constructor: ->
    @statusbarView = new StatusbarView()
    niceplay.workspace.append @statusbarView

    niceplay.on 'file:new', @load

    niceplay.on '!player:play', @play
    niceplay.on '!player:pause', @pause
    niceplay.on '!player:stop', @stop

  play: ->
    @statusbarView.setIcon 'icon-play'

  pause: ->
    @statusbarView.setIcon 'icon-pause'

  stop: ->
    @statusbarView.setIcon 'icon-stop'

  load: (url) ->
    @statusbarView.setTitle url

module.exports = Statusbar
