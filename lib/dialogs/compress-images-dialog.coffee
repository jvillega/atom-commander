# FTPDialog = require './ftp-dialog'
# SFTPDialog = require './sftp-dialog'
{View} = require 'atom-space-pen-views'
{CompositeDisposable, File, Directory} = require 'atom'

module.exports =
class NewServerDialog extends View

  constructor: (@containerView, @item) ->
    super();

  @content: ->
    @div class: "atom-commander-new-server-dialog", =>
      @div "Compress Images", {class: "heading"}
      @div {class: "button-panel block"}, =>
        @div {class: "btn-group"}, =>
          @button "Yes", {class: "btn selected", outlet: "yesButton", click: "yesClicked"}
          @button "No", {class: "btn", outlet: "noButton", click: "close"}

  yesClicked: ->
    @compressImages();
    @close();

  compressImages: ->
    @makeBackupDirectory();

  makeBackupDirectory: ->
    options = {};
    pathUtil = @containerView.directory.getFileSystem().getPathUtil();
    path = pathUtil.join(@item.getPath(), 'pictureBackup');

    @item.fileSystem.makeDirectory path, (err) =>
      if err?
        atom.notifications.addWarning(err);
      else
        snapShot = {};
        snapShot.name = name;
        @containerView.refreshDirectoryWithSnapShot(snapShot);

  close: ->
    panelToDestroy = @panel;
    @panel = null;
    panelToDestroy?.destroy();
    @containerView.requestFocus();

  attach: ->
    @panel = atom.workspace.addModalPanel(item: this.element);
