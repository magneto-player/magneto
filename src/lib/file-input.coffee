
[$] = []

class FileInput
  constructor: ->
    @_listenOpen()
    @_listenDrag()

    niceplay.on 'ready', =>
      @_parseArgv()

  newFile: (path) ->
    niceplay.emit 'file:new', path

  openFileDialogs: ->
    $ = $ or require 'jquery'
    $file = $('<input />', type: 'file', style: 'display: none').appendTo('body')

    $file.on 'change', =>
      @newFile $file.val()
      $file.remove()

    $file.trigger 'click'


  _parseArgv: ->
    argv = nw.gui.App.argv
    if argv.length
      @newFile argv[0]

  _listenOpen: ->
    nw.gui.App.on 'open', (cmdline) =>
      @newFile cmdline

  _listenDrag: ->
    preventDefault = (e) -> e.preventDefault()

    # Prevent dropping files into the window
    window.addEventListener 'dragover', preventDefault, false
    window.addEventListener 'drop', (e) =>
      e.preventDefault()
      file = e.dataTransfer.files[0]
      @newFile file.path
    , false

    # Prevent dragging files outside the window
    window.addEventListener 'dragstart', preventDefault, false


module.exports = FileInput