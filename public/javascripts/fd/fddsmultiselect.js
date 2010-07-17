var FDDSMultiSelect = $.inherit({
  el: null,
  options: {
    multi: true,
    sdtmCategories: false
  },
  elcount: 0,

  //Construct
  __constructor: function(element, options) {

    var rthis = this;

    //Load options
    this.options = $.extend({}, this.options, options);

    if( !this.options.sdtmCategories) {
        $.error('Data source url can not be blank');
    }
    this.el = $(element);


    //Prepare controls

    //Add CDASH Drop down select
//    this.dsBox = $('<select>')
//    this.dsBox.append(
//        $("<option></option>").attr("value","-1").text("-Please select-")
//    );
//    this.el.append(this.dsBox);
//    this.dsBox.change($.proxy(this, "_selectCdash"));

    this.dsBox = $("<input/>", {type: "hidden"}).
        change($.proxy(this, "_selectCdash"));
    this.el.append(this.dsBox);

    // attach autocomplete
    this.dsBoxAutocomplete = $('<input/>', {id: "qqq"}).
      autocomplete(this.options.sdtmCategories,{
        formatItem: function(sdtmCategory) {
          return sdtmCategory.name
        },
        minChars: 0,
        delay: 0
    }).result(function(event){
        var selectedCategoryName = $(event.target).val();
        $.each(rthis.options.sdtmCategories, function(index, sdtmCategory){
           if(sdtmCategory.name==selectedCategoryName){
             rthis.dsBox.val( sdtmCategory.id ).trigger('change')
             return false;
           }
        })
   })
   this.el.append(this.dsBoxAutocomplete);

    //Add SDTMs Container
    this.resultBox = $('<div>')

    this.optBox = $('<ul>');
    this.resultBox.append(this.optBox);


    //Add select all and none links

    this.resultBox.append(
      $('<a>',{'href':'#'}).text('Select all').click($.proxy(function(e){
        this.optBox.find('input:checkbox').attr('checked','checked');
        this.onChangeList();
        e.preventDefault();
      }, this))
    );
    this.resultBox.append(
      $('<a>',{'href':'#'}).text('Select none').click($.proxy(function(e){
        this.optBox.find('input:checkbox').attr('checked',false);
        this.onChangeList();
        e.preventDefault();
      }, this))
    );
    this.el.append(this.resultBox);
  },


  //Fill list from dataset
  load: function(cdash, selected){
    this.dsBox.val(cdash);
    $.each(this.options.sdtmCategories, $.proxy(function(index, sdtmCategory){
       if(sdtmCategory.id==cdash){
         this.dsBoxAutocomplete.val( sdtmCategory.name )
         return false;
       }
    }, this))
    this.dsBox.trigger("change");

    if(parseInt(cdash) != -1){

      //No need, all is done via change event
      //this._fillSdtms(this._getSDTMs(cdash));

      this.elcount = 0;
      //Check proper checkboxes
      this.optBox.find('input:checkbox').each(function(){
        if(selected.indexOf($(this).val()) != -1) {
          $(this).attr('checked', 'checked')
        } else {
          $(this).attr('checked', false);
        }
      });
    } else {
      //No CDASH was selected
    }
  },

  /**
   *  Add element
   */
  add:function(position,title,value, selected) {
    var base = $('<li></li>');
    value = value || "";
    selected = selected || true;
    var newId = 'dscb-' +this.elcount;

    $('<input>', {type: 'checkbox', id: newId}).
            appendTo(base).attr('checked',selected).val(value).
            change( $.proxy(this.onChangeList, this) );
    $('<label>', {'for':newId}).appendTo(base).text(title);

    if(position) {
      base.insertAfter(position);
    } else {
      this.optBox.append(base);
    }
    this.elcount += 1;
  },

  //Get list state
  getData:function(){
    return {
      cdash  : this.dsBox.val(),
      options: this._values(),
      selected: this._selected()
    }
  },

  _fillSdtms:function(data){
    this.optBox.find('li').remove();

    for(var i=0; i<data.length;i++) {
      this.add(null,data[i].nci_preferred_term, data[i].id);
    }
    this.onChangeList();
  },

  //On DropBox change
  _selectCdash: function(e) {

    //TODO: check if id is valid
    if(parseInt(this.dsBox.val()) != -1) {
      this._getSDTMs(this.dsBox.val());
      this.optBox.find('input:checkbox').attr('checked','checked');
      this.resultBox.show();
    } else {
      this.optBox.find('li').remove();
      this.resultBox.hide();
    }

  },

  _getSDTMs: function(cdash){
    if( !this.cacheSDTMs ){
      this.cacheSDTMs={};
    }

    if( !this.cacheSDTMs[cdash] ){
      // add respponce to cache
      $.get( Routes.adminSdtmCategorySdtmAnswersPath(cdash, {format:'json'}),
        $.proxy(function(data) {
          this._fillSdtms( data );
          this.cacheSDTMs[cdash] = data
          }, this)
  	  );
    }else {
      this._fillSdtms( this.cacheSDTMs[cdash] );
    }
  },

  //Get selected valaues list with titles
  _values: function() {
    var values = {};
    this.optBox.find('input:checked').each(function() {
      values[$(this).val()] = $(this).next().text();
    });
    return values;
  },

  //Get selected elements list
  _selected: function() {
    var values = [];
    this.optBox.find('input:checked').each(function() {
      values.push($(this).val());
    });
    return values;
  },

  onChangeList: function(){
    if( this.options.onChangeList && typeof this.options.onChangeList=="function" ){
        this.options.onChangeList();
    }
  }

});
