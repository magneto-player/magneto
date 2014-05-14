
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
    Window = require './window'
    Workspace = require './views/workspace'
    FileInput = require './file-input'
    KeyboardShortcut = require './keyboard-shortcut'
    MenuBar = require './menu-bar'

    # Init components
    envDir = path.join osenv.home(), '.niceplay'

    @config = new Config(
      dir: envDir
    )
    @packages = new PackageManager(
      dirs: [
        path.join __dirname, '../../node_modules'
        path.join __dirname, '../node_modules'
        path.join envDir, 'packages'
      ]
    )

    @stylesheets = new Stylesheets()
    @window = new Window()
    @workspace = new Workspace()

    @fileInput = new FileInput()

    @keyboardShortcut = new KeyboardShortcut

    @menuBar = new MenuBar
      debug: @package.debug

    # On ready
    $ = require 'jquery'
    $ =>
      @stylesheets.require('niceplay-style/dist/styles/main')

      @workspace.appendTo 'body'

      @packages.loadPackages()
      @packages.activatePackages()

      @emit('ready')

module.exports = NicePlay
