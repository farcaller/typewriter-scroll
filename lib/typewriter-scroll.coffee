{CompositeDisposable} = require 'atom'

module.exports = TypewriterScroll =
  subscriptions: null
  lineChanged: null

  config:
    autoToggle:
      type: 'boolean'
      default: true

  activate: (state) ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-workspace', 'typewriter-scroll:toggle': => @toggle()
    @lineChanged?.dispose()
    if atom.config.get 'typewriter-scroll.autoToggle'
      @setEnabled(true)

  deactivate: ->
    @subscriptions.dispose()
    @lineChanged?.dispose()

  setEnabled: (value) ->
    if not value
      @lineChanged?.dispose()
      @lineChanged = null
    else if not @lineChanged
      editor = atom.workspace.getActiveTextEditor()
      @lineChanged = editor.onDidChangeCursorPosition ->
        halfScreen = Math.floor(editor.getRowsPerPage() / 2)
        cursor = editor.getCursorScreenPosition()
        element = editor.getElement()
        element.setScrollTop editor.getLineHeightInPixels() * (cursor.row - halfScreen)

  toggle: ->
    if @lineChanged
      @setEnabled false
    else
      @setEnabled true
