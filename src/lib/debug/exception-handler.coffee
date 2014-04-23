
process.on('uncaughtException', (err) ->
  console.error err
  nw.gui.Window.get().showDevTools()
)
