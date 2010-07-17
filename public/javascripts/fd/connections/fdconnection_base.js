FDConnection.Base = $.inherit({
  options:{},

  __constructor: function(connection, options) {
    this.options = $.extend(true, {}, this.options )
    this.connection = connection;
//    this.initData();
    this.initEvents();
    if(options){
      this.load(options);
    }
  },

  activate: function() {
    this.initData()
    this.render()
  },

  render: function() {
    this.container().html('');
    this._render();
    this._renderEvents();
  },


  // methods for successors
  load: function(options) {},

  initEvents: function() {},

  initData: function() {},

  _render: function() {},

  _renderEvents: function(){},

  save: function() { return {}  }

}, {

});

