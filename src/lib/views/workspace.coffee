
View = require './view'
$ = require 'jquery'

class Workspace extends View
  @content: ->
    @div class: 'workspace'

module.exports = Workspace
