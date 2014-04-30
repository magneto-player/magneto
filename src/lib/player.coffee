

View = require './views/view'

class PlayerView extends View
  @content: ->
    @div id: 'player', =>
      @video
        class: 'video-js vjs-default-skin vjs-big-play-centered'
        controls: true
        preload: 'auto'
        width: 600
        height: 400

  initialize: ->
    @video = @find('video')

    # Init video.js
    videojs = require 'video.js/dist/video-js/video.dev.js'
    niceplay.stylesheets.require('video.js/dist/video-js/video-js')

    console.log @video

    @player = videojs @video.get(0)
    @player.ready =>
      niceplay.emit('player:ready')

  setFile: (url, play = true) ->
    @video.attr 'src', url
    @play() if play

  play: ->
    @player.play()
    # @player.on('play', =>
    #   niceplay.emit('player:play')
    # )

  stop: ->
    @player.stop()

  pause: ->
    @player.pause()


class Player
  constructor: ->
    @playerView = new PlayerView
    niceplay.workspace.append @playerView

    niceplay.on 'file:new', @load

    niceplay.on '!player:play', @play
    niceplay.on '!player:pause', @pause
    niceplay.on '!player:stop', @stop

  load: (url) =>
    @playerView.setFile(url)

  play: =>
    @playerView.play()

  pause: =>
    @playerView.pause()

  stop: =>
    @playerView.stop()


module.exports = Player
