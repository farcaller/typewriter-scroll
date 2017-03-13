{CompositeDisposable} = require 'atom'

module.exports = TypewriterScroll =
  subscriptions: null
  lineChanged: null

  activate: (state) ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-workspace', 'typewriter-scroll:toggle': => @toggle()

    @lineChanged?.dispose()

  deactivate: ->
    @subscriptions.dispose()
    @lineChanged?.dispose()

  toggle: ->
    editor = atom.workspace.getActiveTextEditor()

    if @lineChanged
      @lineChanged.dispose()
      @lineChanged = null
    else
      @lineChanged = editor.onDidChangeCursorPosition ->
        halfScreen = Math.floor(editor.getRowsPerPage() / 2)
        cursor = editor.getCursorScreenPosition()
        element = editor.getElement()
        element.setScrollTop editor.getLineHeightInPixels() * (cursor.row - halfScreen)
