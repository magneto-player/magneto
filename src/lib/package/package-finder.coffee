
glob = require 'glob'
path = require 'path'

class PackageFinder
  constructor: (options) ->
    @_dir = options.dir
    @_findPackages()

  _findPackages: ->
    @paths = glob.sync('niceplay-pkg-*', cwd: @_dir).map (f) => path.join(@_dir, f)

module.exports = PackageFinder
