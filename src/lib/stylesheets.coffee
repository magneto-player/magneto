
$ = require 'jquery'
path = require 'path'
fs = require 'fs-plus'

class Stylesheets
  constructor: ->
    @$head = $ 'head'

  require: (file) ->
    filepath = @resolveStylesheet(file)

    unless filepath
      throw new Error("Stylesheets #{file} does not exists.")

    @$head.append(
      $('<link />', href: filepath, rel: 'stylesheet')
    )

  resolveStylesheet: (file) ->
    if path.extname(file).length > 0
      return fs.resolveOnLoadPath file
    else
      return fs.resolveOnLoadPath file, ['css']

module.exports = Stylesheets
