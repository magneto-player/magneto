
View = require './view'

class Workspace extends View
  @content: ->
    @div class: 'workspace', =>
      @h1 'Hello World!'
      @video
        class: 'video-js vjs-default-skin vjs-big-play-centered'
        poster: 'http://www.videojs.com/img/poster.jpg'
        controls: true
        preload: 'auto'
        width: 600
        height: 400
        =>
          @source src: 'http://video-js.zencoder.com/oceans-clip.mp4', type: 'video/mp4'
      @div id: 'time'

      @a href: 'javascript:process.exit(0)', 'Quit'
      @br()
      @a href: 'javascript:nw.gui.Window.get().showDevTools()', 'Show dev tools'

  initialize: ->
    @find('#time').text(new Date())

    videojs = require 'video.js/dist/video-js/video.dev.js'

    video = @find('video').get(0)

    niceplay.stylesheets.require('video.js/dist/video-js/video-js')

    videojs video, {}, ->
      # Player (this) is initialized and ready.
      console.log 'player ready'

module.exports = Workspace
