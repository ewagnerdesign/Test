FDConnection.Operational.Item = $.inherit(FDConnection.ItemBase, {

  default_item_options: {
     action: "show"
  },

  availableActions: {
    "show": "Show",
    "hide": "Hide"
  },

  _init: function() {

  },

  _render: function() {
    return $([
      this._renderIcon(),
      this._renderAction(),
      $("<span>").text( this.control.getTitle() )
    ])
  },

  _renderAction: function() {
    var action = $("<span>")

    var select = $('<select>')
    $.each(this.availableActions, function(value, title) {
      select.append(
         $('<option>').attr('value',value).text(title)
      )
    });
    select.val( this.options.action )
    select.change($.proxy(function(event) {
      this.options.action = $(event.target).val()
    }, this))
    action.append( select )
    return action;
  },

  _save: function() {
    return {
      action: this.options.action
    }
  }

});
