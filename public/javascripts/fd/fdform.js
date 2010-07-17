/*
 * FDForm is the base class to store form information, like title, description,
 * form id if any etc.
 * This class does not contain any field information.
 */
var FDForm = $.inherit({
  elId: "",
  options: {
    title: 'New form',
    description: 'Description goes here',
    cumulative: 0,
    formId: 0
  },

  __constructor :function(node, options) {
    this.options = $.extend({}, this.options, (options || {}));
    this.render(node);
  },

  render: function(node) {
    this.element = $('<div class="formheader">');
    $(node).prepend(this.element);
    this.elId = 'FDForm';
    this.element.attr('id', this.elId);
    this.element.append(this._buildControl());
    this.element.bind('click', $.proxy(this, '_blockClick'));
  },

  _buildControl: function(){
    return $('<h2>').text(this.options.title).add(
      $('<div>').text(this.options.description)
    );
  },

  updateOptions: function(options) {
    this.options = $.extend({}, this.options, options || {});
    this.element.html('').append(this._buildControl());
  },

  _blockClick: function(e) {
    var active = FDController.getActive();
    //Check is current row selected
    if(!active || active.id != this.elId) {
      FDController.activateFormOptions(this.elId);
    }
    e.stopPropagation();
  },

  activate: function() {
    this.element.addClass('active');
  },

  deactivate: function() {
    this.element.removeClass('active');
  }

});
