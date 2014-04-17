config = require('../../package.json')

if config.livereload
  {Gaze} = require('gaze')
  gaze = new Gaze('**/*')
  doReload = false

  setInterval (->
    if doReload
      window.location.reload()
      doReload = false
  ), 2000

  gaze.on 'all', (event, filepath) ->
    doReload = true if window.location
