
View = require './view'

class Workspace extends View
  @content: ->
    @div class: 'workspace', =>
      @h1 'Hello World!'
      @video poster: 'http://www.videojs.com/img/poster.jpg', controls: true, preload: 'auto', =>
        @source src: 'http://vjs.zencdn.net/v/oceans.mp4', type: 'video/mp4'
      @div id: 'time'

      @a href: 'javascript:process.exit(0)', 'Quit'
      @br()
      @a href: 'javascript:nw.gui.Window.get().showDevTools()', 'Show dev tools'

  initialize: ->
    @find('#time').text(new Date())

    # @stylesheets.append('video.js/dist/video-js/video-js')
    # videojs 'example_video_1', {}, ->
    #   # Player (this) is initialized and ready.
    #   console.log 'player ready'

module.exports = Workspace
