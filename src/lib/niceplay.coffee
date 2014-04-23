
theorist = require 'theorist'

class NicePlay extends theorist.Model
  initialize: ->
    @package = require '../package.json'

    # Debugging
    if @package.debug
      require('./debug/livereload').initialize()
      require('./debug/devtools').initialize()

    # Exception handler
    require './debug/exception-handler'

    # Init components
    Config = require './config'
    PackageManager = require './package-manager'
    Stylesheets = require './stylesheets'
    Workspace = require './views/workspace'

    @config = new Config(
      dir: '~/.niceplay'
    )
    @packages = new PackageManager(
      dir: '~/.niceplay/packages'
    )
    @stylesheets = new Stylesheets()
    @workspace = new Workspace()

    # Main
    $ = require 'jquery'

    $ =>
      @workspace.appendTo 'body'

module.exports = NicePlay