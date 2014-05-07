
$ = require 'jquery'
path = require 'path'
fs = require 'fs-plus'
_ = require 'lodash'
Module = require 'module'

class Stylesheets
  constructor: ->
    @$head = $ 'head'

  require: (file, paths = []) ->
    filepath = @resolveStylesheet(paths, file)

    unless filepath
      console.error("Stylesheets #{file} does not exists.")

    @$head.append(
      $('<link />', href: filepath, rel: 'stylesheet')
    )

  # Public: Resolve path to stylesheet using node's modules paths as the load paths to
  #
  # loadPaths - An {Array} of absolute and relative paths to search.
  # pathToResolve - The {String} containing the path to resolve.
  # extensions - An {Array} of extensions to pass to {resolveExtensions} in
  #              which case pathToResolve should not contain an extension
  #              (optional).
  #
  # Returns the absolute path of the file to be resolved if it's found and
  # undefined otherwise.
  resolveStylesheet: (args...) ->
    extensions = if _.isArray(_.last(args)) then args.pop() else []
    pathToResolve = args.pop()?.toString()

    loadPaths = Module.globalPaths.concat _.flatten(args)
    loadPaths = loadPaths.concat module.paths

    if not path.extname(pathToResolve) and not extensions.length
      extensions = ['css']

    fs.resolve.apply fs, loadPaths.concat([pathToResolve, extensions])

module.exports = Stylesheets
