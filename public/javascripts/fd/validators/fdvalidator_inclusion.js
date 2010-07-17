FDValidator.Inclusion  = $.inherit(FDValidator, {

  default_options: {
      headTitle: "Inclusion",
      base: {
        params: {},
        message: 'Value should be inclusion in {args}'
      }
  },

  _buildBody: function() {
    var items = $('<ul>');
    if( $.isEmptyObject(this.options.base.params) ){
      this.options.base.params[ this._genId() ] = ''
    }
    $.each(this.options.base.params, $.proxy(function(index) {
      this._buildItem(index).appendTo( items )
    }, this))
    
    return items
  },

  _buildItem: function(index) {
    return $('<li>').
      append(
          this.textFieldTag(["params", index]),
          $('<img/>', {
              'src': '/images/fd/add.png', 'class':'add-item-btn'
            }),
          $('<img/>', {
              'src': '/images/fd/delete.png', 'class':'del-item-btn'
            }).data('id', index)
      )
  },

  _genId: function() {
    return this.itemsCount()+1;
  },

  _add: function(event) {
    var itemId = this._genId() 
    this.options.base.params[ itemId ] = '';
    this._buildItem(itemId).
            insertAfter(
              $(event.target).parent('li')
            )
  },

  itemsCount: function() {
    return this.element.find('ul > li').length
  },

  _remove: function(event) {
    if( this.itemsCount()==1 ){
      return
    }
    var el = $(event.target)
    el.parent('li').remove()
    delete this.options.base.params[ el.data('id') ]

  },

  initEvents: function() {
    this.element.delegate('.add-item-btn', 'click', $.proxy(this._add,this))
    this.element.delegate('.del-item-btn', 'click', $.proxy(this._remove,this))
  }

}, {
  available_controls: ['input', 'textarea', 'dstextarea', 'dsinputtext' ]
});
