/**
 *  Connection Collection list
 *  Deals with the connection list
 */
var FDConnectionCollection = $.inherit({

  connections: {},
  menu_list: {},

  __constructor: function() {
    this.container = FDConnectionCollection.container;
    this.clear();
    this._initEvents();
  },

  _initEvents: function() {
    //Add new connection
    //TODO: Move this out of here to allow binding to any event
    $('#fdConnectionAdd').click($.proxy(function(){
      var itemId = this.add();
      var connection = this.getById(itemId);
      this.renderItem( itemId, connection );

      //activate added connection
      connection.activate()
    },this));

    //Handle row(connection item) click
    this.container.delegate('li a.connection-title', 'click', $.proxy(function(event){
      try{
        event.preventDefault();
        var link = $(event.currentTarget);
        this.edit(link.data('id'));
      }catch(err){
        $.error("connection title activate", err)
      }
    },this));

    //TODO: Save state
  },

  //Add new connection item into collection
  add: function(options) {
    var connectionId = FDConnection.generateId();
    this.connections[connectionId] =  new FDConnection(this, connectionId, options)
    //Hide no items message
    this._showEmptyMessage();
    return connectionId;
  },

  //Remove connection item from collection by it's id
  remove: function(connectionId) {
    //activate other connection if removed active
    if( FDConnection.active && FDConnection.active.id==connectionId ){
       this.activateFirst( connectionId )
    }

    // delete in menu list
    this.menu_list[connectionId].remove()
    delete this.menu_list[connectionId]

    // todo check errors
    this.getById(connectionId).remove();
    delete this.connections[connectionId];
    this._showEmptyMessage()
  },

  //Load connection collection and display it
  load: function(data) {
    var self = this;
    //Populate connections data
    if(data){
      $.each(data, function() {
        try {
          self.add(this);
        }catch(err){
          $.error("can't load connection", err)
        }
      })
    }
    this.render();
  },

  //Activate current item
  edit: function(itemId) {
    this.getById(itemId).activate();
  },

  //Clear container and reset all data
  clear: function() {
    this.container.html('')
    FDConnection.connectionCounter = 0
    this.connections={};
    this.menu_list = {};
    FDConnection.hide()
  },

  // Show/Hide no items message
  _showEmptyMessage: function() {
    var message = this.container.parent().find('.connections-empty');
    if($.getObjectLength(this.connections)==0){
      message.show();
    } else {
      message.hide()
    }
  },

  //Render list
  render: function() {
    this._showEmptyMessage();
    $.each(this.connections, $.proxy(this.renderItem, this))
  },

  renderItem: function(itemId, connection) {
    var item = $("<li>").addClass('connectionItem')

    var onRemove = function(event) {
      event.preventDefault();
      this.remove(itemId)
    }

    var onRename = function(event){
      event.preventDefault();

      var container = $(event.target).parents('li').find('span.connection-title')
      var inputText = $('<input>').val(connection.getTitle())
      var renameLink = $(this)
      renameLink.hide();

      var onCancel = function(){
        container.html(connection.getTitle())
        renameLink.show();
      }

      var onSave = function(){
        try{
          connection.setTitle( inputText.val() )
          onCancel()
        }catch(err){
          // show error
          alert(err)
        }
      }

      container.html('').append(
         inputText,
          $('<button>').text('save').click(onSave),
          $('<button>').text('cancel').click(onCancel)
      )
    }

    item.append(
        $('<a>').append(
              $('<div>').text(itemId).addClass('connection-number'),
              $('<span>').text(connection.getTitle()).addClass('connection-title')
            ).
          data('id',itemId).
          addClass('connection-title'),

        $('<div>').append(
            $('<a>', {href: "javascript:void(0)"}).
                text('rename').click(onRename),
            $('<img>', {src: "/images/icons/cross.png"}).
                click($.proxy(onRemove,this))
        ).addClass('connection-actions')
    )
    item.appendTo(this.container)

    this.menu_list[itemId] = item;
    return item;
  },

  _highlightItem: function(itemId) {
    try{
      var item = this.menu_list[itemId];
      this.container.find('li.connection-list-active').removeClass('connection-list-active')
      item.addClass('connection-list-active');
    }catch(err){
      $.error("can't hihlight connection", err)
    }
  },

  //Save the vhole collection
  save: function() {
    var data = [];
    $.each(this.connections, function(index, connection) {
      data.push(connection.save());
    });
    return data;
  },

  //Get connection by id
  getById: function(connectionId) {
    return this.connections[connectionId];
  },

  activateFirst: function(connectionId) {
    if( $.isEmptyObject(FDController.connections.connections) ){
      FDConnection.hide()
      return false;
    }

    if(connectionId){
      // activate first find connection when go up
      for(var i=connectionId-1; i>0; i--){
        if( this.connections[i] ){
          this.connections[i].activate()
          return true;
        }
      }
    }

    // activate first connection
    var firstConnection = $.getObjectFirst(FDController.connections.connections, 1)
    firstConnection.activate();
  },

  isUseControl: function(controls){
    var controlIds = [];
    $.each((controls.elId? [controls]: controls) , function(i,v){
      controlIds.push(  v.getId() )
    })

    var isFindControl = false;
    $.each( this.connections, function(key, connection){
       if(connection.isUseControls(controlIds)){
         // stop find for first correct result
         isFindControl= true;
         return false
       }
    })
    return isFindControl;
  },

  removeControl: function(control){
    $.each( this.connections, $.proxy(function(key, connection){
      connection.removeControl(control)
      if( connection.isEmpty() ){
          this.remove( connection.id)
      }
    }, this))
  }

},{

  container: {},

  init: function() {
    FDConnectionCollection.container = $("#dlConnectionCollectionItems")
  },

  activate: function() {
    // enable events
    FDConnection.activate()

    if( FDConnection.active ){
       FDConnection.active.activate()
    } else {
      // activate first connection
      FDController.connections.activateFirst()
    }
  },

  deactivate: function() {
    // disable events
    FDConnection.deactivate()
  }

});

$(document).ready(FDConnectionCollection.init)
