# TO-DO:
  # User defined directory name
    # frontend
      # styling
    # backend DONE

  # Copy files into new directory
  # Move compress lofic to file-system folder

VFile = require '../fs/vfile'
{View, TextEditorView} = require 'atom-space-pen-views'
{CompositeDisposable, File, Directory} = require 'atom'

module.exports =
class NewServerDialog extends View

  constructor: (@view, @item) ->
    super({prompt:'Enter a name for the new directory:'});

  @content: ->
    @div {class: "container"}, =>
      @div "Compress Images", {class: "heading"}
      @div class: "atom-commander-compress-server-dialog", =>
        @table =>
          @tbody =>
            @tr =>
              @td "Enter name of backup directory", {class: "text-highlight", style: "width:50%"}
              @td =>
                @subview "backupEditor", new TextEditorView(mini: true)
      @div {class: "button-panel block"}, =>
        @div {class: "btn-group"}, =>
          @button "Yes", {class: "btn selected", outlet: "yesButton", click: "yesClicked"}
          @button "No", {class: "btn", outlet: "noButton", click: "close"}

  # initialize: ->
  #   @nameEditor.attr("tabindex", 1);

  yesClicked: ->
    @compressImages();
    @close();

  compressImages: ->
    @makeBackupDirectory();
    @getEntries(@item, null, null);

  getEntries: (curDirectory, snapShot, callback) ->
    # @showSpinner();
    curDirectory.getEntries (curDirectory, err, entries) =>
      for entry in entries
        if entry instanceof VFile
          console.log(entry.getPath());
      # if err == null
      #   @entriesCallback(curDirectory, entries, snapShot, callback);
      # else if !err.canceled?
      #   Utils.showErrorWarning("Error reading folder", null, err, null, false);
      #   callback?(err);
      # else
      #   @openLastLocalDirectory();
      # # @hideSpinner();

  entriesCallback: (curDirectory, entries, snapShot, callback) ->
    if (@directory != null) and (@directory.getURI() != curDirectory.getURI())
      callback?(null);
      return;

    highlightIndex = 0;

    if @highlightedIndex != null
      highlightIndex = @highlightedIndex;

    @resetItemViews();

    index = @itemViews.length;

    for entry in entries
      console.log(entry);
      # if entry instanceof VFile
      #   itemView = @createFileView(index, new FileController(entry));
      # else if entry instanceof VDirectory
      #   itemView = @createDirectoryView(index, new DirectoryController(entry));
      # else if entry instanceof VSymLink
      #   itemView = @createSymLinkView(index, new SymLinkController(entry));
      # else
      #   itemView = null;
      #
      # if itemView?
      #   @itemViews.push(itemView);
      #   # @addItemView(itemView);
      #   index++;

    # if @itemViews.length > 0
    #   @highlightIndex(highlightIndex);

    # @restoreSnapShot(snapShot);
    # @enableAutoRefresh();
    # @sort(true);
    # callback?(null);

  makeBackupDirectory: ->
    options = {};
    pathUtil = @view.directory.getFileSystem().getPathUtil();
    path = pathUtil.join(@item.getPath(), @getName());

    @item.fileSystem.makeDirectory path, (err) =>
      if err?
        atom.notifications.addWarning(err);
      else
        snapShot = {};
        snapShot.name = name;
        @view.refreshDirectoryWithSnapShot(snapShot);

  getName: ->
    return @backupEditor.getModel().getText().trim();

  close: ->
    panelToDestroy = @panel;
    @panel = null;
    panelToDestroy?.destroy();
    @view.requestFocus();

  attach: ->
    @panel = atom.workspace.addModalPanel(item: this.element);
