var FDValidator = $.inherit(FDViewHelper, {

  options: {},

  // parent collection instance
  collection: null,

  general_options:{
    base:{
      enable: false,
      message: "Not valid!"
    },
    titleElements:{},
    headTitle: ""
  },

  default_options: {},

  __constructor :function(collection, savedData) {
    if (! collection instanceof FDValidatorCollection) {
      throw new Error("FDValidator::__constructor - collection must be provided!");
    }
    this.collection = collection;
    this.elId = this.collection.control.elId + "_validator" + FDValidator.getId();
    this.options = $.extend(true, {}, this.general_options, this.default_options);

    // load saved state or init default
    if (savedData) {
      this.load(savedData);
    }
  },

  isEnabled: function() {
    return this.options.base.enable
  },

  update: function() {
    this.updateBaseOptions(this.options.base);
  },

  updateBaseOptions: function(varObject, varName) {
    var newVarname = (varName ? ($.isArray(varName) ? varName : [varName]) : []);
    if (typeof varObject == "object") {
      $.each(varObject, $.proxy(function(varName2, varObject2) {
        this.updateBaseOptions(varObject2, $.merge($.merge([], newVarname), [varName2]));
      }, this))
    } else {
      this.setOptionsValue(
        newVarname,
        this._util.getElementValue(
            this.fdFiledValue(newVarname)
        )
      );
    }
  },

  /**
   * Return options for save
   */
  save: function() {
    // call callback if exists
    if (this.beforeSave && $.isFunction(this.beforeSave)) {
      this.beforeSave();
    }
    return this.options.base;
  },

  /**
   * Load saved state or init default
   *
   * @param data
   */
  load: function(data) {
    this.options.base = $.extend(true, {}, this.options.base, data);
  },

  validate: function(value, paramsObj) {},

  activate: function() {
    // TODO: set rendered param, and show/hide rendered view
    this.render();
    this.initEvents();
  },

  deactivate: function() {
    // TODO: set rendered param, and show/hide rendered view
//    this.element.html('');
  },

  render: function(options) {
    var elementClass = "validator-" + this.type;
    this.element = $('<li>', {
          'id': this.elId,
          'class': "validator"
        }).addClass(elementClass);

    this._buildHead().appendTo(this.element);

    var content = $('<div class="validator-content">');
    content.toggle(this.options.base.enable);

    this._buildBody().appendTo(content);
    this._buildMessage().appendTo(content);
    this._buildActions().appendTo(content);

    this.element.append(content);

    if (options && options.after) {
      this.element.insertAfter(options.after.element)
    } else {
      var position = FDValidatorCollection.validators.find('li.' + elementClass + ':last');
      if (position.length == 1) {
        this.element.insertAfter(position)
      } else {
        this.element.appendTo(FDValidatorCollection.validators);
      }
    }
  },

  onChangeSourceData: function() {},

  initEvents: function() {},

  _buildHead: function() {
    var head = $('<div>', {"class": "validator-title"});
    $([
      this.checkboxFieldTag('enable'),
      this.labelTag('enable', this.options.headTitle),
      $('<span class="description">').text(this._headDescription())
    ]).appendTo(head);
    return head;
  },

  _buildMessage: function() {
    return $([
      $('<a>', { "class": "validator-message", href: "javascript:void(0)"}).
              text('Message').
              click(function() {
                $(this).next().toggle()
              }),
      $('<textarea>').
              attr('fdfield', 'message').
              addClass("validator-message").
              hide().
              text(this.options.base.message)
    ]);
  },

  _buildBody: function() {
    return $()
  },

  _buildActions: function() {
    return $('<div class="validator-actions">').
        append(
          $('<img/>', {
            'src': '/images/fd/add.png',
            'class': 'add-btn'
          }).
          click($.proxy(this.clone, this)),

          $('<img/>', {
            'src': '/images/fd/delete.png',
            'class': 'del-btn'
          }).
          click($.proxy(function() {
             this.collection.remove(this)
          }, this))
        )
  },

  _headDescription: function() {
    if (this.options.base.enable) {
      return "";
    }
    var title = [], opt = this.options;

    $.each(opt.titleElements, function(key, value) {
      if (opt.base[key].toString() != "") {
        title.push(value + ": " + opt.base[key])
      }
    });
    // TODO: add connected icon  if have connections <%= image_tag "fd/connected.png" %>
    return title.join(', ')
  },

  clone: function() {
    var validatorType = FDValidatorCollection.getObjectType(this);
    var validator = this.collection.add(validatorType);
    validator.render({after: this});
  },

  /**
   * Remove validator
   */
  remove: function(event) {
    this.element.remove();
  }

}, {
  // static part
  available_controls: [],
  init: function() {}, // initialize control

  validatorId:0,
  getId: function() {
    return ++this.validatorId;
  }

});


FDValidator.Acceptance = $.inherit(FDValidator, {
});
FDValidator.Confirmation = $.inherit(FDValidator, {
});
FDValidator.Presense = $.inherit(FDValidator, {
});
FDValidator.Numericality = $.inherit(FDValidator, {
});
