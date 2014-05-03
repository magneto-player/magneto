
{jwerty} = require 'jwerty'

class KeyboardShortcut
  constructor: ->

    jwerty.key 'space', ->
      niceplay.emit '!player:toggle'

    jwerty.key 'esc', ->
      niceplay.emit '!leave-fullscreen'

    jwerty.key 'ctrl+m', ->
      console.log 'Menu'



module.exports = KeyboardShortcut

