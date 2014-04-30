class FileInput
  constructor: ->
    argv = nw.gui.App.argv
    if argv.length
      @newFile argv[0]

    nw.gui.App.on 'open', (cmdline) =>
      @newFile cmdline

    window.ondragover = (e) ->
      e.preventDefault()
      false

    window.ondrop = (e) =>
      e.preventDefault()
      file = e.dataTransfer.files[0]
      @newFile file.path

  newFile: (path) ->
    niceplay.emit 'file:new', path

module.exports = FileInput