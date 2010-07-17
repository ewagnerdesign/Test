FDConnection.Operational = $.inherit(FDConnection.BaseDropable, {
  disallowedControls: [
    'column-item'
  ],

  _isAllowedDrop: function(controlId) {
    try{
      return -1==$.inArray(
          FDController.getControlById(controlId).options.type,
          this.disallowedControls
      )
    }catch(err){
      $.error("FDConnection.Operational._isAllowedDrop", err)
    }
  },

  clear: function() {
    this.container().html('')
  },

  _add: function(options) {
    return new FDConnection.Operational.Item(this, options)
  },

  container: function() {
    return FDConnection.Operational.container;
  }


}, {
  container: {},

  containerSelect: "#fdConnectionOperationals",

  active: function() {
    return FDConnection.getActive('target');
  }

})

$(document).ready(function(){
  $.proxy(FDConnection.Operational.init(), FDConnection.Operational)
})
