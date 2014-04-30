
fs = require 'fs'
path = require 'path'

class Package
  constructor: (dir) ->
    @_dir = dir
    @_readPackageJSON()

  _readPackageJSON: ->
    try
      pkgFile = fs.readFileSync path.join(@_dir, 'package.json')
      @json = JSON.parse pkgFile

      @name = @json.name
    catch e
      console.error "Failed to load package '#{@_dir}#'", e.message
      console.error e.stack

  _require: ->
    @_pkg = @_pkg or require(@_dir)

  activate: ->
    @_require()
    @_pkg.activate()

  desactivate: ->
    @_pkg?.desactivate()


module.exports = Package
