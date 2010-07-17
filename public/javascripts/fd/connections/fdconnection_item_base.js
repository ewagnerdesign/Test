FDConnection.ItemBase = $.inherit({

  control: {},
  elId: "",

  options:{
    control:{
      id: "", value: ""
    }
  },
  default_item_options: {},

  __constructor: function(parent, options) {
    this.options = $.extend(true, {}, this.options, this.default_item_options, options)
    this.parent = parent;
    this.control = FDController.getControlById( this.options.control.id )

    this.elId = FDConnection.ItemBase.generateUniqueId();
    this._init();
  },

  render: function() {
    var item = $('<div>', {id: this.elId, "class":"item"})

    this._render().appendTo(item)
    this._buildToolbox().appendTo(item)

    return item;
  },

  save: function() {
    return $.extend({
      control:{
        id: this.control.getId().save(),
        value: this.options.control.value
      }
    }, this._save());
  },

  remove: function(event) {
    event.preventDefault();
    var item = $(event.target).parents('.item')
    if(!item){
      throw "FDConnection.ItemBase.remove item not found"
    }
    item.remove()

    this.parent.remove( this.elId )
  },

  _renderIcon: function() {
    // todo implement render control icon
    return $('')
  },

  _buildToolbox: function() {
     return $('<span>').append(
        $('<img>').
            attr('src','/images/icons/cross.png').
            addClass('del-btn').
            click($.proxy(this.remove,this))
     ).addClass( 'item-actions' )
  },

  _init: function() {},
  _save: function() { return {} },
  _render: function() {}

}, {

  itemId: 0,

  generateUniqueId: function() {
    return "connection_item" + ( ++this.itemId )
  }

})
