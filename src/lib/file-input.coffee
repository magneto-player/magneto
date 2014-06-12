
[$] = []

class FileInput
  constructor: ->
    @_listenOpen()
    @_listenDrag()

    magneto.on 'ready', =>
      @_parseArgv()

  newFile: (path) ->
    magneto.emit 'file:new', path

  openFileDialogs: ->
    $ = $ or require 'jquery'
    $file = $('<input />', type: 'file', style: 'display: none').appendTo('body')

    $file.on 'change', =>
      @newFile $file.val()
      $file.remove()

    $file.trigger 'click'

  openPrompt: ->
    videoUrl = window.prompt 'URL :'
    @newFile videoUrl if videoUrl?.length

  _parseArgv: ->
    argv = nw.gui.App.argv
    if argv.length
      @newFile argv[0]

  _listenOpen: ->
    nw.gui.App.on 'open', (cmdline) =>
      @newFile cmdline

  _listenDrag: ->
    # Prevent dropping files into the window
    window.addEventListener 'dragover', ((e) -> e.preventDefault()), false
    window.addEventListener 'drop', (e) =>
      e.preventDefault()
      file = e.dataTransfer.files[0]
      if file and file.path
        @newFile file.path
    , false

    # Prevent dragging files outside the window
    window.addEventListener 'dragstart', ((e) -> e.preventDefault()), false


module.exports = FileInput