
View = require './view'

class PlayerView extends View
  @content: ->
    @div id: 'player', =>
      @video
        class: 'video-js vjs-default-skin vjs-big-play-centered'
        controls: true
        preload: 'auto'
        width: '100%'
        height: '100%'

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

module.exports = PlayerView
