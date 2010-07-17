var FDColumnBlock = $.inherit(FDControl, {
  options: {
    type     : 'column',
    control  : '<div>',
    elOpts   : {
      'class': 'fdcolumn'
    },
    base: {
      columns: 3
    },
    sections: ['columnBlockOptions'],
    clearControlAfterUpdate: false,
    diffColumnCount: 0
  },

  __constructor:function(element, objOptions, options) {
    this.columns = [];
    this.children = {};
    this.__base(element, objOptions, options);

    $(this.controlBlock).addClass('colno'+this.options.base.columns);

    this.initEvents()
  },

  initEvents: function() {
    //Override duplicate function
    this.controlBlock.undelegate('.bAdd', 'click'); //Remove parent event handler

    //Duplicate control
    this.controlBlock.delegate('.bAdd', 'click', $.proxy(function(e){
        e.preventDefault();
        e.stopPropagation();
        FDController.addControl(
            this.options.type,
            {element: this.controlBlock, position:'after'},
            this.options
        );
    },this));
  },

  updateOptions: function(options) {
    if( parseInt(options.columns) != this.options.base.columns ){
      $(this.controlBlock).
              removeClass('colno'+this.options.base.columns).
              addClass('colno'+options.columns);

      this.options.diffColumnCount = options.columns - this.options.base.columns;
    }

    this._updateGeneral(options);
  },

  remove: function(){
    $.each(this.columns, $.proxy(function(key, value) {
      this._removeColumn(value, true);
    }, this))
  },

  getChildsControls: function(){
    // show confirmation if childs control used in connections
    var controlsArray = $.merge([], this.columns)
    var rthis = this;
    $.each(this.columns, function(key, columnId){
      // TODO: refactoring this move drooped column control in column item
      controlsArray = $.merge(controlsArray, rthis.children[columnId] )
    })
    return FDController.getControlsById(controlsArray)
  },

  _buildLabel:function() {
    return $();
  },

  //Redefine control rendering
  _buildControl: function() {
  // update columns
    if( this.columns.length>0 ){
      if( this.options.diffColumnCount!=0 ){
        do {
            // add new column
            if( this.options.diffColumnCount >0 ){
              this._createColumn(
                { element: '#'+ this._columnId(this.columns.length), position:'after' },
                this.columns.length+1
              );
              this.options.diffColumnCount--;
            } else {
              // delete column
              this._removeColumn(
                 this._columnId(this.columns.length)
              );
              this.options.diffColumnCount++;
            }
        }while( this.options.diffColumnCount!=0 )
      }

    } else {
        for(var i=1; i<=this.options.base.columns; i++){
          this._createColumn({ element: this.controlBlock }, i);
        }

        //Clear component
        this.controlBlock.append(
          $('<div>').css({'clear':'both'})
        );
        var hint = $('<div>').
            addClass('column-tooltip').
            attr('title', 'This is top level component which allows split form into columns');

        //Init column group tooltip
        hint.tooltip({
          effect: "fade",
          opacity: 0.7,
          tip: '.tooltip' ,
          position: 'top right'
        });
        this.controlBlock.append(hint);
    }

    return $()
  },

  /**
   * Create column with number
   *
   * @param dropPosition - position options
   * @param num - column number
   */
  _createColumn: function(dropPosition, num){
    var columnId = this._columnId(num);
    this.columns.push( columnId );
    this.children[columnId]=[];

    FDController.addControl(
      'column-item',
      dropPosition,
      { base: { label: "Column "+num, number: num} },
      {
        id: { virtualId: columnId },
        parent: this
      }
    );
  },

  _columnId: function(num){
    return this.elId +'-col'+num;
  },

  /**
   * Delete column
   * @param num - column number
   */
  _removeColumn: function(columnId, clearColumn){
    // delete child elements
    if( clearColumn || this.columns.length==1 ){
      // delete child controls
      $.each(this.children[columnId], function(index,value){
        FDController.deleteControl( value );
      });
    }else{
      // move child elements to prev column
      var targetColumn = $( '#' + this.columns[this.columns.length-2] );
      var __self = this;
      $.each(this.children[columnId], function(index, value){
        __self.addChild(targetColumn, value );
        targetColumn.append( $("#"+value) );
      });
      this.children[columnId] = null;
    }

    delete this.children[columnId];

    // delete column
//    this.columns = $.grep(this.columns, function(val) { return val != columnId; });
    this.columns = $.destroyArrayElement(columnId, this.columns ) 

    // delete controller control
    FDController.deleteControl(columnId);

    // remove container
    $( "#"+ columnId ).remove()
  },

  /*
  * Redefine all controls parents and orders on change
  */
  _orderChange:  function(event, ui) {
    var elements = $(event.target).sortable('toArray');

    // TODO: clear parent container

    //Clear column children
    this.children[$(event.target).attr('id')] = [];
    for(var i=0; i<elements.length; i++){
      if(elements[i] == "") continue;
      this.addChild(event.target, elements[i] );
    }

    //Show empty column label if it has no children
    FDColumnItem.update($(event.target).attr('id'))
//    if(this.children[$(event.target).attr('id')].length == 0){
//      $(event.target).find('.column-empty').show();
//    }
  },

  /*
  * Add child reference to the column group
  */
  addChild: function(column, element) {
//    $(column).find('.column-empty').hide();
    var columnId = $(column).attr('id');
    if( !this.children[columnId] ){
      this.children[columnId] = [];
    }
    this.children[columnId].push(element);

    $("#"+element).data( 'fd.parent', {column: columnId, container: this.elId});

    FDColumnItem.update(columnId)
  }


//  /**
//   * Delete child reference from column
//   *
//   * @param columnId - column id
//   * @param controlId
//   */
//  removeChild: function(columnId, controlId){
//    if( !this.children[columnId] || -1 == $.inArray( controlId, this.children)){
//      return;
//    }
//    if($.isEmptyObject(this.children[$(column).attr('id')])){
//        column.show();
//    }
//  }

},{});
