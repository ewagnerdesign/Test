FDConnection.Condition = $.inherit(FDConnection.BaseDropable, {

  // 'file', 'dateinput',
  allowedControls: [
    'input', "checkbox", 'radiobox', 'dsdropdown', 'dsradiobox',
    'textarea', "dropdown"
  ],

  default_item_options: {
    conditions: {}
  },

  _isAllowedDrop: function(controlId) {
    try{
      return -1!==$.inArray(
          FDController.getControlById(controlId).options.type,
          this.allowedControls
      )
    }catch(err){
      $.error("_isAllowedDrop", err)
      return false
    }
  },

  _add: function(options) {
      return new FDConnection.Condition.Item(this, options)
  },

  container: function() {
    return FDConnection.Condition.container;
  }

}, {

  containerSelect: "#fdConnectionConditions",


  active: function() {
    return FDConnection.getActive('source');
  }

})

$(document).ready(function(){
  $.proxy(FDConnection.Condition.init(), FDConnection.Condition )
})

