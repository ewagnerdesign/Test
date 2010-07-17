/**
  TODO:
    bind specific params for drop position detection
*/
var FBdnd = $.inherit({

},{
  //Static section
  dragSubject: null,
  dragObject: null,
  inDrag: false,
  dropPos: null,
  formcControls: null,
  //Event handlers

  options: {
    toolboxId: '#toolbox',
    dropPaneId: '#builderpane',
    onDragStart: null,
    onDrag: null,
    onDrop: null
  },

  init: function(options) {
    this.options = $.extend(this.options, options || {});
    this.toolbox = $(this.options.toolboxId);
    this.pane = $(this.options.dropPaneId);
    //Prevent context loss for events

    //Binding DND events
    //For now I assume that only li elements participate in dnd

    this.toolbox.find('li').bind('mousedown', $.proxy(this,"_mouseDown"));
    $(document).bind('mouseup', $.proxy(this, '_mouseUp'));
    $(document).bind('mousemove', $.proxy(this, '_mouseMove'));
  },

  _mouseDown: function(event) {
    //Bind drag subject
    this.dragSubject = $(event.currentTarget);

    //Fire onDragStart callback
    if(this.options.onDragStart){
      this.options.onDragStart(this.dragSubject);
    }

    //Asume that components wont chnage durring the drag
    //This opration will be cheaper than in mouse move event
    //Cache form elements
    this.formcControls = null;
    this.formcControls = this.pane.find('form').children('div').not('.notice');
  },

  _mouseMove: function(event) {
    //Check if we in drag mode
    if(this.dragSubject == null) { return; }
    this.clearSelection();

    //Go in drag mode
    this.inDrag = true;

    //Create drag proxy if it still does not exist
    if(this.dragObject == null) {
      this.dragObject = this.dragSubject.clone().appendTo(document.body);
      this.dragObject = this.dragObject.wrap('<div class="dragSubj" />').addClass('toolbox-li').parent();

      //Position drag proxy to mouse
      this.dragObject.css({position:'absolute',
                      display:'block',
                      opacity: 0.5,
                      'list-style': 'none'});
    }

    //Get Mouse position
    var mousePos = this.mouseCoords(event);

    //Move drag object
    this.dragObject.css({
      top:mousePos.y,
      left:mousePos.x
    });

    //Render drop region
    this.findDropRegion(mousePos);

    //Fire onDrag Event
    if(this.options.onDrag) {
      this.options.onDrag();
    }
  },

  _mouseUp: function(event) {
    if(this.dragObject) {
      //Remove drag object proxy
      this.dragObject.remove();
      this.dragObject = null;

      //Fire onDrop event
      if(this.options.onDrop){
        this.options.onDrop(this.dropPos);
      }
    }

    //Cleanup
    this.inDrag = false;
    this.dragSubject = null;
    this.dropPos = null;
    this.formcControls = null;

    //Hide placeholder
    $('#placeholder').css({left:-1000, top:-1000});
  },

  /*
  * Find Drop position and rener placeholder at it
  * This method need to be refactored
  */
  findDropRegion: function(pos) {

    var _self = this;
    y = pos.y;
    //Reset drop position
    this.dropPos = null;

    $.each(this.formcControls, function(key,el) {
      el = $(el);

      var elpos = el.offset();

      var rowHeight = el.outerHeight(true);
      var rowWidth = el.outerWidth(true);
      //Check we are in range
      if ((y > elpos.top) && (y < (elpos.top + rowHeight))) {

        //Handle columnt layout positioning
        if(el.data('fd.type') =='column' && _self.dragSubject.attr('fdtype') !='column') {
          //Find control position within column box
          $.each(el.find('.fdcontrol'), function(nestedkey, nested) {
            nested = $(nested);
            var nestedHeight = nested.outerHeight(true);
            var nestedWidth = nested.outerWidth(true);
            var nestedPos = nested.offset();

            //Match verticaly and horisontaly
            if (((y > nestedPos.top) && (y < (nestedPos.top + nestedHeight))) &&
                ( (pos.x > nestedPos.left) &&  (pos.x < (nestedPos.left + nestedWidth)) )
               ) {
                if(y > (nestedPos.top + (nestedHeight/2))) {
                  placePos = nestedPos.top+nestedHeight;
                   var position = 'after';
                } else {
                  placePos = nestedPos.top;
                  var position = 'before';
                }
                _self.dropPos = {element:nested, position:position, column:{region: el, col: '#'+nested.data('fd.parent').column}};
                $('#placeholder').css({top: placePos, left:nestedPos.left, width: nestedWidth});
            }
          });

          //Handle situation when column is empty and no position is found
          if(_self.dropPos == null) {
            //Find horisontal drop pos
            $.each(el.find('.fdcolumn'), function(colname, col) {
              var colpos = $(col).offset();
              var colWidth = $(col).outerWidth(true);
              if((pos.x > colpos.left) && (pos.x < (colpos.left + colWidth))){
                $('#placeholder').css({left:colpos.left,top:colpos.top,width: colWidth});
                _self.dropPos = {element:col, position:'append', column:{region: el, col: col}};
              }

            });
          }

        } else {
          //Ordinary positioning
          //Below center?
          if(y > (elpos.top + (rowHeight/2))) {
            placePos = elpos.top+rowHeight;
            _self.dropPos = {element:el, position:'after'}
          } else {
            placePos = elpos.top;
            _self.dropPos = {element:el, position:'before'}
          }
          $('#placeholder').css({left:0, top:placePos, width: rowWidth});
        }
        return true;
      }
    });

    //Nothing found
    if(this.dropPos == null) {
      //Append after last element
      var lastEl = this.formcControls.last();
      this.dropPos = {element: $(lastEl.first()), position: 'after'};
      $('#placeholder').css({left:0, top: (lastEl.outerHeight(true) + lastEl.offset().top), width: $(lastEl.first()).width() });
    }
  },

  findColDropPos: function(pos, columnEl) {
    $.each($(columnEl).find('.fdcontrol'), function() {

    });

  },

  //Get mouse coordinates with scroll
  mouseCoords: function(ev){
    if(ev.pageX || ev.pageY){
      return {x:ev.pageX, y:ev.pageY};
    }
    return {
      x:ev.clientX + document.body.scrollLeft - document.body.clientLeft,
      y:ev.clientY + document.body.scrollTop  - document.body.clientTop
    };
  },

  //Prevent text selection while draging
  clearSelection: function()
  {
    var sel;
    if(document.selection && document.selection.empty){
      document.selection.empty();
    }
    else if(window.getSelection){
      sel = window.getSelection();
      if(sel && sel.removeAllRanges)
        sel.removeAllRanges();
    }
  }
});
