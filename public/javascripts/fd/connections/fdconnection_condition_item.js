FDConnection.Condition.Item = $.inherit(FDConnection.ItemBase, {

  conditions: {},

  default_item_options: {
    conditions: [{
       comp: "",
       value: ""
    }]
  },

  _init: function() {
    this.conditions = new FDConnection.Condition.Item.Conditions(this, this.options.conditions)
  },

  _render: function() {
    return $([
      $("<span>").addClass("target").
        text( this.control.getTitle() ),
        this.conditions.render()
    ])
  },

  _save: function() {
    return {
      conditions: this.conditions.save()
    }
  }


})
