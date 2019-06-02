# FTPDialog = require './ftp-dialog'
# SFTPDialog = require './sftp-dialog'
{View} = require 'atom-space-pen-views'

module.exports =
class NewServerDialog extends View

  constructor: (@containerView, @item) ->
    super();
    # @ftpDialog.setParentDialog(@);
    # @sftpDialog.setParentDialog(@);
    # @currentDialog = @ftpDialog;
    # @sftpDialog.detach();

  @content: ->
    @div class: "atom-commander-new-server-dialog", =>
      @div "Compress Images", {class: "heading"}
      @div {class: "button-panel block"}, =>
        @div {class: "btn-group"}, =>
          @button "Yes", {class: "btn selected", outlet: "yesButton", click: "yesClicked"}
          @button "No", {class: "btn", outlet: "noButton", click: "noClicked"}
      # @div {outlet: "dialogContainer"}, =>
      #   @subview "ftpDialog", new FTPDialog()
      #   @subview "sftpDialog", new SFTPDialog()

  # Called from the embedded dialog after it got initialized.
  # The dialog that was initialized. Either FTPDialog or SFTPDialog.
  # dialogInitialized: (dialog) ->
  #
  # getMain: ->
  #   return @containerView.getMain();
  #
  # getServerManager: ->
  #   return @containerView.getMain().getServerManager();
  #
  # serverExists: (id) ->
  #   return @getServerManager().getFileSystemWithID(id) != null;
  #
  yesClicked: ->
    @compressImages();

  noClicked: ->
    @close();

  close: ->
    panelToDestroy = @panel;
    @panel = null;
    panelToDestroy?.destroy();
    @containerView.requestFocus();

  # ftpClicked: ->
  #   @setSelected(@ftpButton, @ftpDialog);
  #
  # sftpClicked: ->
  #   @setSelected(@sftpButton, @sftpDialog);
  #
  # setSelected: (button, dialog) ->
  #   @ftpButton.removeClass("selected");
  #   @sftpButton.removeClass("selected");
  #   button.addClass("selected");
  #
  #   @currentDialog.detach();
  #   @currentDialog = dialog;
  #   @currentDialog.appendTo(@dialogContainer);
  #   @currentDialog.selected();
  #
  attach: ->
    @panel = atom.workspace.addModalPanel(item: this.element);
    # @currentDialog.selected();
  #
  # addServer: (config) ->
  #   @close();
  #   serverManager = @getServerManager();
  #   server = serverManager.addServer(config);
  #   @containerView.openDirectory(server.getInitialDirectory());
  #

  compressImages: ->
    console.log(@item);
