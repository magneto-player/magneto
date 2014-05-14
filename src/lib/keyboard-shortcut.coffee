
{jwerty} = require 'jwerty'

class KeyboardShortcut
  constructor: ->

    jwerty.key 'space', ->
      niceplay.emit '!player:toggle'

    jwerty.key 'esc', ->
      niceplay.emit '!window:leave-fullscreen'

    jwerty.key 'm', ->
      niceplay.emit '!menu:toggle'



module.exports = KeyboardShortcut

