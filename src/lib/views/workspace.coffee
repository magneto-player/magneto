
View = require './view'
$ = require 'jquery'

class Workspace extends View
  @content: ->
    @div class: 'workspace', =>
      @h1 id: 'main-title'
      @video
        class: 'video-js vjs-default-skin vjs-big-play-centered'
        #poster: 'http://www.videojs.com/img/poster.jpg'
        controls: true
        preload: 'auto'
        width: 600
        height: 400
        # =>
        #   @source src: '', type: 'video/mp4'
      @div id: 'time'

      @a href: 'javascript:process.exit(0)', 'Quit'
      @br()
      @a href: 'javascript:nw.gui.Window.get().showDevTools()', 'Show dev tools'

  initialize: ->
    @find('#time').text(new Date())

    videojs = require 'video.js/dist/video-js/video.dev.js'
    niceplay.stylesheets.require('video.js/dist/video-js/video-js')

    autoPlay = false
    title = 'Hello World !'

    video = @find('video').get(0)
    mainTitle = @find('#main-title')
    $(mainTitle).text(title)

    player = videojs video
    player.ready ->
      # Player (this) is initialized and ready.
      console.log 'player ready'

    niceplay.on 'file:new', (path) ->
      $(video).attr 'src', path
      player.play()

module.exports = Workspace
