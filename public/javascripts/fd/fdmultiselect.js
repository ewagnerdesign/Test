//Special for IE
if(!Array.indexOf){
   Array.prototype.indexOf = function(obj){
      for(var i=0; i<this.length; i++){
         if(this[i]===obj){
            return i;
         }
      }
      return -1;
   }
}

var FDMultiSelect = $.inherit({
  el: null,
  options: {
    multi: true
  },
  elcount: 0,

  //Construct
  __constructor :function(element, options) {
    //Load options
    this.options = $.extend({}, this.options, options);

    this.el = $(element);
    this.el.find('.add-btn').live('click', $.proxy(this,"addClick"));
    this.el.find('.del-btn').live('click', $.proxy(this,"removeClick"));
    this.add()
  },

  //Handle add click
  addClick: function(e) {
    this.add($(e.currentTarget).parent());
  },

  //Handle remove click
  removeClick: function(e) {
    //Check if not last element
    if(this.elcount > 1) {
      $(e.currentTarget).parent().remove();
      this.elcount -=1;
    }
  },

  //Fill list from dataset
  load: function(options, selected){

    if(selected.constructor != Array) {
      selected = new Array(selected);
    }
    //Clear list
    this.el.find('li').remove();
    this.elcount = 0;

    if(options.length == 0) {
      //Add empty stub
      this.add();
    } else {
      for(var i=0; i< options.length; i++) {
        this.add(null, options[i], (selected.indexOf(options[i]) == -1? false : true));
      }
    }
  },

  //Add element
  add: function(position,value, selected) {
    var base = $('<li></li>');
    value = value || "";
    
    selected = selected || false;
    if(this.options.multi) {
      $('<input>', {type: 'checkbox'}).appendTo(base).attr('checked',selected);
    } else {
      $('<input>', {type: 'radio', name:'selbase'}).appendTo(base).attr('checked', selected);
    }
    $('<input>', {type:'text'}).appendTo(base).val(value);
    $('<img/>',{
        'src': '/images/fd/add.png',
        'class': 'add-btn'
      }).appendTo(base);
    $('<img/>',{
        'src': '/images/fd/delete.png',
        'class': 'del-btn'
      }).appendTo(base);
    if(position) {
      base.insertAfter(position);
    } else {
      this.el.append(base);
    }
    this.elcount += 1;
  },

  //Get list state
  getData:function(){
    return {
      options: this._values(),
      selected: this._selected()
    }
  },

  //Toggle multiselect type
  toggleType: function(multi){

    if( this.options.multi == multi) return; // Nothing to do
    //TODO: Store previous selected state
    //Clear elements
    if(this.options.multi) {
      this.el.find('*[type|=checkbox]').remove();
    } else {
      this.el.find('*[type|=radio]').remove();
    }
    //Add new controls
    if(multi==true) {
      this.el.find('li').prepend($('<input>', {type: 'checkbox'}));
    } else {
      this.el.find('li').prepend($('<input>', {type: 'radio', name:'selbase'}));
    }
    this.options.multi = multi;
  },

  //Get valaues list
  _values: function() {
    var values = [];
    this.el.find('input[type|=text]').each(function() {
      values.push($(this).val());
    });
    return values;
  },

  //Get selected elements list
  _selected: function() {
    var selList = this.el.find('input:checked');
    if(this.options.multi) {
      var selected = []
      selList.each(function(){
        selected.push($(this).next().val());
      })
    } else {
      selected = selList.first().next().val() || "";
    }
    return selected;
  }
});
