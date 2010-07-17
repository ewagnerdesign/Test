var FDColumnItem  = $.inherit(FDControl, {

  options:{
    type: 'column-item',
    base: {
      number: 1,
      label: "Column "
    }
  },

  parent:{},// FDColumn parent instance

  __constructor: function(element, objOptions, options) {
    this.__base(element, objOptions, options)
    this.parent = options.parent
  },

  render: function(element, position){
    position = position || 'append';

    this.controlBlock = $('<div>', {id: this.elId } ).
            addClass('fcol'+this.options.base.number+' fdcolumn').
            append( this._buildEmptyContent() );

    if(position == 'after') {
      $(element).after( this.controlBlock );
    } else if (position == 'append') {
      $(element).append(this.controlBlock);
    }
    this.initEvent()
    this.showEmptyContent();
  },

  initEvent: function() {
    //Init column content ordering
    this.controlBlock.sortable({
          connectWith: '.fdcolumn',
          cursor: 'crosshair',
          handle: '.bMove',
          forcePlaceholderSize: true,
          placeholder:'state-highlight',
          opacity: 0.6,
          update: $.proxy(this.parent, '_orderChange'),
          items: 'div.fdcontrol'
        });
  },

  _buildEmptyContent: function(){
     return this.emptyBlock = $('<div>').
              addClass('column-empty').
              text('Column '+this.options.base.number );
  },

  //Show empty column label if it has no children
  showEmptyContent: function() {
    this.emptyBlock.toggle(
        this.controlBlock.find(' > div:not(.column-empty)').length==0
    )
  }

},{

  update: function(columnId) {
    try{
      //Show empty column label if it has no children
      var columnItem = FDController.getControlById(columnId)
      columnItem.showEmptyContent();
    } catch(err){
      $.error('FDColumnItem.update', err)
    }
  }

});