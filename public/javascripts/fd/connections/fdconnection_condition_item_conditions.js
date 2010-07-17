FDConnection.Condition.Item.Conditions = $.inherit({

  item: {},
  options:{},

  default_item_options: {
    comp: "",
    value: ""
  },

  comparisonType: {
    input:    [ 'input', 'textarea', "dateinput" ],
    checkbox: [ "checkbox", 'dscheckbox' ],
    select:   [ "dropdown", 'dsdropdown' ],
    radiobox: [ "radiobox", 'dsradiobox']
  },

  renderType: "",
  container: $(''),

  comparisonOptions:{
    input: {
      'eq': "is",
      'neq' : "not"
    },
    checkbox: {
      'checked':"checked",
      'unchecked': "unchecked"
    },
    select: {
      'eq':"selected",
      'neq': "unselected"
    },
    radiobox: {
      'checked':"selected",
      'unchecked': "unselected"
    }
  },

  __constructor: function(item, options) {
    this.item = item;
    this.options = $.extend(true, {}, this.options)
    this.load(options)

    this._updateRenderType()
  },

  _updateRenderType: function() {
    var renderType = "";
    var controlType = this.item.control.options.type
    $.each(this.comparisonType, function(key, value) {
      if (-1 != $.inArray(controlType, value)) {
        renderType = key;
        return false;
      }
    });
    this.renderType = renderType;
  },

  render: function() {
    this.container = $('<div>').addClass('item-conditions')

    $.each(this.options, $.proxy(function(index, condition) {
      this.renderItem(index, condition).appendTo(this.container)
    }, this))

    return this.container;
  },

  renderItem: function(itemId, option) {
    var condition = $('<div>', { id: itemId, "class":"item-condition"});

    condition.append(
        this._renderComparison(itemId, option),
        this._renderValue(itemId, option),
        this._buildToolbox(itemId)
    )
    return condition;
  },

  _renderComparison: function(index, option) {
    var container;
    if( this.comparisonOptions[this.renderType] ){
      if(option.comp==""){
        option.comp = $.getObjectFirst(this.comparisonOptions[this.renderType], 0)
      }
      container = this._createSelectTag(
          this.comparisonOptions[this.renderType],
          option.comp
      )
      this._changeEvent(container, index, 'comp')
    } else {
      container = $('<span>').text('(not implement)')
    }
/*
    switch (this.renderType) {
      case 'checkbox':
      case 'select':
      case 'input':
      case 'textarea':
      case 'radiobox':
        container = this._createSelectTag(
            this.comparisonOptions[this.renderType],
            option.comp
        )
        this._changeEvent(container, index, 'comp')
        break;
      default:
        container = $('<span>').text('(not implement)')
    }
*/
    return container;
  },


  _renderValue: function(index, options) {
    var container;
    switch (this.renderType) {
      case 'input':
      case 'textarea':
        container = $("<input>").attr('value', options.value)
        break
      case 'checkbox':
      case 'radiobox':
      case 'select':
        var selectOptions = {}
        $.each(this.item.control.options.base.options, function(index, value) {
          selectOptions[index] = value;
        });
        if(options.value==""){
          options.value = $.getObjectFirst(selectOptions, 0)
        }
        container = this._createSelectTag(
            selectOptions,
            options.value
        )
        break;
      default:6
        container = $('<span>').text('(not implement)');
    }
    this._changeEvent(container, index, 'value');
    return container;
  },

  _changeEvent: function(element, index, value) {
    element.change($.proxy(function(e) {
      this.options[index][value] = $(e.target).val()
    }, this))
  },

  _createSelectTag: function(options, value) {
    var tag = $('<select>');
    $.each(options, function(value, title) {
      $('<option>').
          text(title).
          attr('value', value).
          appendTo(tag)
    });
    tag.val(value)
    return tag;
  },

  load: function(data) {
    if (!data) {
      return;
    }
    $.each(data, $.proxy(function(index, condition) {
      this.add(condition)
    }, this))
  },

  add: function(data) {
    var id = FDConnection.Condition.Item.Conditions.genUniqueId();
    this.options[id] = $.extend({}, this.default_item_options, data)
    return id;
  },

  addNew: function() {
    var itemId = this.add()
    this.renderItem(itemId, this.options[itemId]).
        appendTo(this.container)
  },

  save: function() {
    var data = [];
    $.each(this.options, function(index, condition) {
      data.push(condition)
    });
    return data;
  },

  activate: function() {},

  remove: function(itemId) {
    if (this.container.find(".item-condition").length == 1) {
      return;
    }
    delete this.options[itemId];
    this.container.find('#' + itemId).remove()
  },

  _buildToolbox: function(itemId) {
    return $('<span>').append(
        $('<img>', { 'src': '/images/fd/add.png'}).
            addClass('condition-add-btn').
            click($.proxy(this.addNew, this)),
        $('<img>', { 'src': '/images/fd/delete.png'}).
            addClass("condition-del-btn").
            click($.proxy(function(event) {
          this.remove(itemId)
        }, this))
      ).addClass('item-condition-actions')
  }


},{

  uniqueCount: 0,

  genUniqueId: function() {
    return "con-i-cond-" + ( ++this.uniqueCount )
  }

})
