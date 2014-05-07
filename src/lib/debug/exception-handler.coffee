
onError = (err) ->
  console.error err
  nw.gui.Window.get().showDevTools()

process.on 'uncaughtException', onError
window.onerror = onError