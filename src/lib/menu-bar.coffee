
gui = nw.gui

class MenuBar
  constructor: (options) ->
    win = gui.Window.get()
    win.menu = @_menubar = new gui.Menu(type: 'menubar')

    if options.debug
      @_initializeDebug()

    @_initializeFile()

  _appendMenu: (menuData) ->
    items = menuData.items
    delete menuData.items

    if items and items.length
      menuData.submenu = new gui.Menu()
      for item in items
        itemMenu = new gui.MenuItem(item)
        menuData.submenu.append itemMenu

    item = new gui.MenuItem(menuData)
    @_menubar.insert item, 1

  _initializeDebug: ->
    devtools = require './debug/devtools'
    livereload = require './debug/livereload'

    @_appendMenu {
      label: 'Developer'
      items: [
        label: 'Show developer tools'
        click: -> devtools.showDevTools()
      ,
        label: 'Reload'
        click: -> livereload.reload()
      ]
    }

  _initializeFile: ->
    @_appendMenu {
      label: 'File'
      items: [
        label: 'Open...'
        click: -> niceplay.fileInput.openFileDialogs()
      ,
        type: 'separator'
      ,
        label: 'Exit'
        click: -> process.exit(0)
      ]
    }


module.exports = MenuBar
