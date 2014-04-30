$ = require 'jquery'

class FileInput
  constructor: ->
    argv = nw.gui.App.argv
    if argv.length
      @_newFile argv[0]

    nw.gui.App.on 'open', (cmdline) =>
      @_newFile cmdline

    windoow = $('window').get(0)
    window.ondragover = (e) ->
      e.preventDefault()
      false

    window.ondrop = (e) =>
      e.preventDefault()
      file = e.dataTransfer.files[0]
      @_newFile file.path

  _newFile: (path) ->
    niceplay.emit 'file:new', path

module.exports = FileInput