# TO-DO:
  # remove compress images
  # push to new branch
  # getEntries
    # move createReadStream callback to function
    # data displaying 12 times


VFile = require '../fs/vfile'
VDirectory = require '../fs/vdirectory'
{View, TextEditorView} = require 'atom-space-pen-views'
{CompositeDisposable, File, Directory} = require 'atom'
fs = require 'fs'

module.exports =
class RecursiveSearchDialog extends View

  constructor: (@view, @directory) ->
    super();

  @content: ->
    @div {class: "container"}, =>
      @div "Recursive Search", {class: "heading"}
      @div class: "atom-commander-recursive-search-dialog", =>
        @table =>
          @tbody =>
            @tr =>
              @td "Enter search string:", {class: "text-highlight", style: "width:50%"}
              @td =>
                @subview "backupEditor", new TextEditorView(mini: true)
      @div {class: "button-panel block"}, =>
        @div {class: "btn-group"}, =>
          @button "Search", {class: "btn selected", outlet: "searchButton", click: "searchClicked"}
          @button "Cancel", {class: "btn", outlet: "cancelButton", click: "close"}

  cancelButton: ->
    @close();

  searchClicked: ->
    @recursiveSearch();
    @close();

  recursiveSearch: ->
    @getEntries(@directory, null, null);
    console.log('recursive search');

  getEntries: (curDirectory, snapShot, callback) ->
    # @showSpinner();
    curDirectory.getEntries (curDirectory, err, entries) =>
      for entry in entries
        if entry instanceof VFile
          entry.createReadStream (err, stream) =>
            stream.on "data", (data) =>
              console.log('data');
              # console.log(data.toString())
              # buffer.push(data);

            stream.on "end", =>
              console.log("end")
              # console.log(@test.toString())
              # if left
              #   @leftContent = buffer.toString();
              #   buffer.clear();
              # else
              #   @rightContent = buffer.toString();
              #   buffer.clear();
              # @fileRead();
              # @hideStatus(left);

            stream.on "error", (err) =>
              console.log(err);
              # @setStatusError(left, err);
        else if entry instanceof VDirectory
          console.log(entry.getPath());
  close: ->
    panelToDestroy = @panel;
    @panel = null;
    panelToDestroy?.destroy();
    @view.requestFocus();

  attach: ->
    @panel = atom.workspace.addModalPanel(item: this.element);
