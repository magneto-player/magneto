
PackageFinder = require './package-finder'
Package = require './package'

class PackageManager
  constructor: (options) ->
    @_dirs = options.dirs
    @_pkgFinders = []
    @packages = {}

    @_initPackageFinder()

  loadPackages: ->
    @_pkgFinders.forEach (pkgFinder) =>
      pkgFinder.paths.forEach (path) =>
        @_initPackage path

  activatePackages: ->
    @activatePackage pkgName for pkgName of @packages

  activatePackage: (pkgName) ->
    @packages[pkgName].activate()

  desactivatePackage: (pkgName) ->
    @packages[pkgName].desactivate()

  _initPackage: (path) ->
    console.log path
    pkg = new Package(path)
    @packages[pkg.name] = pkg

  _initPackageFinder: ->
    @_dirs.forEach (dir) =>
      pkgFinder = new PackageFinder(dir: dir)
      @_pkgFinders.push pkgFinder


module.exports = PackageManager
