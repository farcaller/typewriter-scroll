{CompositeDisposable} = require 'atom'
typewriterEditor = require "./typewriter-editor"


module.exports = TypewriterScroll =
  typewriterEditor: typewriterEditor
  subscriptions: null
  enabled: false

  config:
    autoToggle:
      type: 'boolean'
      default: true

  activate: (state) ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-workspace',
      "typewriter-scroll:toggle": => @toggle()
      "typewriter-scroll:enable": => @enable()
      "typewriter-scroll:disable": => @disable()
    if atom.config.get 'typewriter-scroll.autoToggle'
      @toggle()

  deactivate: ->
    @enabled = false
    @subscriptions.dispose()
    @typewriterEditor.disable()

  disable: ->
    @enabled = false
    @typewriterEditor.disable()

  enable: ->
    @enabled = true
    @typewriterEditor.enable()

  toggle: ->
    if @enabled then @disable() else @enable()
