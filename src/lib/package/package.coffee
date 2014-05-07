
fs = require 'fs'
path = require 'path'
CSON = require 'season'

class Package
  @readPackageJSON = (pkgDirPath) ->
    if pkgFilePath = CSON.resolve(path.join(pkgDirPath, 'package'))
      try
        pkg = CSON.readFileSync(pkgFilePath)
      catch error
        throw error

    pkg ?= {}
    pkg.name = path.basename(pkgDirPath)
    pkg

  constructor: (@pkgDirPath, @pkg) ->
    @pkg ?= Package.readPackageJSON(pkgDirPath)
    @name = @pkg.name

  activate: ->
    @_require()
    @_module.activate()

  desactivate: ->
    @_module?.desactivate()


  ## Private methods

  _require: ->
    @_module = @_module or require(@pkgDirPath)


module.exports = Package
