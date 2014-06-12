
module.exports =
class WindowState
  constructor: (win)->
    @win = win
    @isMaximizationEvent = false

    # extra height added in linux x64 gnome-shell env, use it as workaround
    @deltaHeight = do ->
      # use deltaHeight only in windows with frame enabled
      if nw.gui.App.manifest.window.frame
        return true
      else
        return 'disabled'

    @initWindowState()

    @win.on 'maximize', =>
      @isMaximizationEvent = true
      @currWinMode = 'maximized'
    @win.on 'unmaximize', =>
      @currWinMode = 'normal'
    @win.on 'minimize', => @currWinMode = 'minimized'
    @win.on 'restore', => @currWinMode = 'normal'

    @win.window.addEventListener 'resize', () =>
      # resize event is fired many times on one resize action,
      # this hack with setTiemout forces it to fire only once
      clearTimeout resizeTimeout
      resizeTimeout = setTimeout(() =>
        # on MacOS you can resize maximized window, so it's no longer maximized
        if @isMaximizationEvent
          # first resize after maximization event should be ignored
          @isMaximizationEvent = false
        else
          @currWinMode = 'normal' if @currWinMode == 'maximized'

        # there is no deltaHeight yet, calculate it and adjust window size
        if @deltaHeight != 'disabled' && @deltaHeight == false
          @deltaHeight = @win.height - @winState.height
          # set correct size
          @win.resizeTo(@winState.width, @win.height - @deltaHeight) if @deltaHeight != 0

        @dumpWindowState();

      , 500)
    , false

    @win.on 'close', () =>
      @saveWindowState()
      @win.close true

  initWindowState: () =>
    @winState = magneto.config.get 'window.state'

    if @winState
      @currWinMode = @winState.mode
      if @currWinMode == 'maximized'
        @win.maximize()
      else
        @restoreWindowState()
    else
      @currWinMode = 'normal'
      @deltaHeight = 0 if @deltaHeight != 'disabled'
      @dumpWindowState()

    #@win.show();

  dumpWindowState: () =>
    @winState = {} if !@winState

    # we don't want to save minimized state, only maximized or normal
    if @currWinMode == 'maximized'
      @winState.mode = 'maximized'
    else
      @winState.mode = 'normal'

    # when window is maximized you want to preserve normal
    # window dimensions to restore them later (even between sessions)
    if @currWinMode == 'normal'
      @winState.x = @win.x
      @winState.y = @win.y
      @winState.width = @win.width
      @winState.height = @win.height

      # save delta only of it is not zero
      if @deltaHeight != 'disabled' && @deltaHeight != 0 && @currWinMode != 'maximized'
        @winState.deltaHeight = @deltaHeight

  restoreWindowState: () =>
    # deltaHeight already saved, so just restore it and adjust window height
    if @deltaHeight != 'disabled' && typeof @winState.deltaHeight != 'undefined'
      @deltaHeight = @winState.deltaHeight
      @winState.height = @winState.height - @deltaHeight

    @win.resizeTo(@winState.width, @winState.height);
    @win.moveTo(@winState.x, @winState.y);

  saveWindowState: () =>
    @dumpWindowState()
    magneto.config.set 'window.state', @winState, true
