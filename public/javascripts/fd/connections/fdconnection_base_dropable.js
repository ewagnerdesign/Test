FDConnection.BaseDropable = $.inherit(FDConnection.Base, {

  // save items
  options: {},

  default_item_options: {},

  load: function(options) {
    $.each(options, $.proxy(function(index, item) {
      this.add(item)
    }, this))

    this._load()
  },

  drop: function(controlId) {
   var item = this.add({
            control: { id: controlId }
          })
    this.connection.controls.tree.disableNode(controlId)
    item.render().appendTo( this.container() );
  },

  add: function(options) {
    var item = this._add(
        $.extend(
            {},
            this.default_options,
            options
        )
    )
    return this.options[item.elId] = item
  },

  save: function() {
    var data=[]
    $.each(this.options, function(controlId, item) {
      data.push( item.save() )
    });

    return data;
  },

  remove: function(itemId) {
    if(!this.options[ itemId ] ){
      throw "FDConnection.BaseDropable remove item not found"
    }

    // enable tree nodes
    this.connection.controls.tree.enableNode(this.options[itemId].control.elId)

    delete this.options[itemId];
  },

  initEvents: function() {
//    // delete item
//    this.container().delegate(
//      '.item-actions .del-btn',
//      'click',
//       $.proxy(this.remove,this)
//    )
  },

  isAllowedDrop: function(controlId) {
    // TODO check unique control in list
    return this._isAllowedDrop(controlId);
  },

  isUseControls: function(controlObjectIds){
    var findResult= false
    $.each(this.options, function(key1, item) {
      $.each(controlObjectIds, function(key2, controlObjectId) {
        try{
          if(
              controlObjectId.isEqual(
                FDController.getControlById(
                    item.options.control.id
                ).getId()
              )
          ){
            findResult=true;
            return false;
          }
        } catch(err){
          $.error('isUseControls', err)
        }
      })
      return !findResult;// break if find first
    });
    return findResult;
  },

  removeControl: function(control){
    $.each(this.options, $.proxy(function(key, item) {
      if( !control.getId().isEqual( item.options.control.id ) ){
        return true;
      }
      delete this.options[key]
    }, this))
  },

  _render: function() {
    var container = this.container();
    $.each(this.options, $.proxy(function(controlId, item) {
      item.render().appendTo(container)
    }, this))
  },

  _getItem: function(controlId) {
    return this.options[controlId];
  },

  // methods for successors
  _load: function() {},
  _isAllowedDrop: function(controlId){ return true; }

}, {

  container: {},
  droppableContainer: {},

  init: function() {
    this.container =  $(this.containerSelect);
    this.droppableContainer = this.container.parent('.view-block');

    this.initEvents();
  },

  initEvents: function() {
      var rthis = this;
       this.droppableContainer.droppable({
          activeClass: 'droppable-active',
          hoverClass: 'droppable-hover',
//          accept: '*:not(.tool-section)',
          drop: function(ev, ui) {
            try {
              rthis.active().
                  drop( ui.draggable.data('id') )
            // ui.draggable.parent('li').find('.draggable').draggable( "option", "disabled", true );
            }catch(e){
              $.error( 'droppable.drop', e )
            }
          },
          activate: function(event, ui) {
            try {
              $(this).droppable(
                  rthis.active().
                      isAllowedDrop( ui.draggable.data('id') )? "enable": "disable"
              )
            }catch(e){
              $.error( 'droppable.activate', e )
            }
          },
          deactivate: function(event, ui) {
            $(this).droppable('enable')
          }
      });
    this.deactivate()
  },

  deactivate: function() {
    this.droppableContainer.droppable("disable")
  },

  activate: function() {
    this.droppableContainer.droppable("enable")
  }

})
