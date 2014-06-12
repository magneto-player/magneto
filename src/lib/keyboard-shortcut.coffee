
{jwerty} = require 'jwerty'

class KeyboardShortcut
  constructor: ->

    jwerty.key 'space', ->
      magneto.emit '!player:toggle'

    jwerty.key 'esc', ->
      magneto.emit '!window:leave-fullscreen'

    jwerty.key 'm', ->
      magneto.emit '!menu:toggle'



module.exports = KeyboardShortcut

