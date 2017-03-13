module.exports =
  enable: ->
    @activeItemSubscription = atom.workspace.onDidStopChangingActivePaneItem =>
      @prepareEditor()
    @prepareEditor()

  disable: ->
    @activeItemSubscription?.dispose()
    @cursorChangePosSubscription?.dispose()

  center: ->
    halfScreen = Math.floor(@editor.getRowsPerPage() / 2)
    cursor = @editor.getCursorScreenPosition()
    position = @editor.getLineHeightInPixels() * (cursor.row - halfScreen)
    @editorElement.setScrollTop position

  prepareEditor: ->
    @cursorChangePosSubscription?.dispose()
    @editor = atom.workspace.getActiveTextEditor()
    return unless @editor
    @editorElement = atom.views.getView @editor
    @cursorChangePosSubscription = @editor.onDidChangeCursorPosition @center.bind(this)
