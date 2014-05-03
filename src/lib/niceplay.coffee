
{Model} = require 'theorist'
osenv = require 'osenv'
path = require 'path'

class NicePlay extends Model
  @::Views =
    View: require './views/view'

  initialize: ->
    @package = require '../package.json'

    # Debugging
    if @package.debug
      require('./debug/livereload').initialize()
      require('./debug/devtools').initialize()

    # Exception handler
    require './debug/exception-handler'

    # Require components
    Config = require 'niceplay-config'
    PackageManager = require './package/package-manager'
    Stylesheets = require './stylesheets'
    Workspace = require './views/workspace'
    FileInput = require './file-input'
    #Player = require './player'
    KeyboardShortcut = require './keyboard-shortcut'

    # Init components
    envDir = path.join osenv.home(), '.niceplay'

    @config = new Config(
      dir: envDir
    )
    @packages = new PackageManager(
      dirs: [
        path.join __dirname, '../../node_modules'
        path.join envDir, 'packages'
      ]
    )

    @stylesheets = new Stylesheets()
    @workspace = new Workspace()


    #@player = new Player()
    @fileInput = new FileInput()

    @playerShortcut = new KeyboardShortcut

    # On ready
    $ = require 'jquery'
    $ =>
      @stylesheets.require('niceplay-style/dist/styles/main')

      @workspace.appendTo 'body'

      @packages.loadPackages()
      @packages.activatePackages()

      console.log @packages

module.exports = NicePlay
