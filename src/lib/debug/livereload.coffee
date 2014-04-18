config = require('../../package.json')

if config.livereload
  {Gaze} = require('gaze')
  gaze = new Gaze('**/*')
  doReload = false

  setInterval ->
    if doReload
      console.log 'Livereload: Start reload window'

      # Clear require cache
      cache = global.require.cache
      for reqCache of cache
        delete cache[reqCache]

      # Reload window
      window.location.reload()

      doReload = false
  , 500

  gaze.on 'all', (event, filepath) ->
    console.log "Livereload: File change on #{filepath}"
    if window.location
      doReload = true
      gaze.close()
