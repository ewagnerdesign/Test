FDValidator.DSBase = $.inherit(FDValidator, {

  default_options: {
    headTitle: "",
    base: {
      childs:{}
    },
    default_child: {}
  },

//  optionsContainer: {},
  childs_html: {},

  _buildBody: function() {
    this.optionsContainer = $('<ul>');
    this._buildSelectedOptions();
    return this.optionsContainer;
  },

  _buildSelectedOptions: function() {
    if(!this.optionsContainer){
      return;
    }
    this.optionsContainer.html('');

    var selectedOptions = FDController.optDS._values();
    if( $.isEmptyObject(selectedOptions) ){
      this.optionsContainer.append(
           $('<li>').append(
               $('<h3>').text('No data selected')
           )
      );
     return;
    }

    $.each(selectedOptions, $.proxy(function(index, value){
        // init child options 
        this.options.base.childs[index] = $.extend(
            true,
            {},
            this.options.default_child,
            this.options.base.childs[index]
        );

        // child
        this._buildOptionItem(index, value).
            appendTo( this.optionsContainer )
    }, this));
  },

  beforeSave: function() {
    var childsForSave={}, base=this.options.base;
    var selectedOptions = FDController.optDS._values();
    // save only checked values
    $.each(selectedOptions, function(index){
        childsForSave[index] = base.childs[index];
    });
    base.childs = childsForSave;
  },

  onChangeSourceData: function(){
    // save inputs data
//    this.update();
    this._buildSelectedOptions();
  }

})


FDValidator.DSCustomParamsBase = $.inherit(FDValidator.DSBase, {

  default_options: {
    headTitle: "Title",
    base: {
      childs:{},
      message: "Message"
    },
    default_child: {
       params: {},
       count: 0
     }
  },

  _buildOptionItem: function(childId, title) {
    var child = this.options.base.childs[childId]
    if( $.isEmptyObject(child.params) ){
      child.params[ this._genParamItemId(childId) ] = this.default_param
    }

    var paramsContainer = $('<ul>')
    $.each(child.params, $.proxy(function(paramId) {
      this._buildParamItem(childId, paramId).
              appendTo(paramsContainer)
    }, this))

    return $('<li>').
      append(
          $('<h4>').text(title),
          paramsContainer
      );
  },

  _genParamItemId: function(childId) {
    return ++this.options.base.childs[childId].count;
  },

  _buildParamItem: function(childId, paramId){
    return $('<li>').
            append(
              this._buildParamItemControl(childId, paramId),
              $('<img>', { 'src': '/images/fd/add.png', 'class': 'action-btn add-param'}).
                 data('childId', childId),
              $('<img>', { 'src': '/images/fd/delete.png', 'class': 'action-btn del-param'}).
                data('childId', childId).
                data('paramId', paramId)
            )
  },

  initEvents: function() {
    this.element.delegate('.add-param', 'click', $.proxy(this._addParamItem,this))
    this.element.delegate('.del-param', 'click', $.proxy(this._removeParamItem,this))
  },

  _addParamItem: function(event) {
    event.preventDefault()
    var el = $(event.target)
    var childId = el.data('childId')
    var paramId = this._genParamItemId( childId )

    this.options.base.childs[childId].params[paramId] = this.default_param
    this._buildParamItem(childId, paramId ).
            insertAfter( el.parent('li') )
  },

  _removeParamItem: function(event) {
    event.preventDefault()
    var el = $(event.target)
    var childId = el.data('childId'), paramId = el.data('paramId')

    delete this.options.base.childs[childId].params[paramId]
    el.parent('li').remove();
  }

});
