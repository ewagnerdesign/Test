/**
* Class that operates different views switching
*/
var FDView = $.inherit({
//No instance
}, {
  menu: null,
  pane: null,
  views: {},
  current: null,
  prev: null,

  init: function(options) {
    this.menu = $('#menu');
    this.pane = $('#pane-container');
    var self = this;
    //Autoload all available panes
    this.pane.children('div').each(function(){
      self.views[$(this).attr('id')] = {};
    });
    this.menu.children('div').hide();
    this.pane.children('div').hide();
    $.each(options, function(name, fn) {
      if ($.isFunction(fn)) { $(self).bind(name, fn)}
    });
  },

  //Show particular view
  show: function(name) {
    var view = $('#'+name);
    if(view) {
      this.prev = this.current;
      this.current = name;
      //Hide menu
      this.menu.find('#'+this.prev+'-menu').hide();
      //Hide pane
      $('#'+this.prev).hide();
      //Show pane
      view.show();
      //Show menu
      $('#'+name+'-menu').show();
      //Trigger events
      $(this).trigger($.Event(this.prev+'Hide'));
      $(this).trigger($.Event('on'+this.current+'Show'));
      $(this).trigger($.Event('onShow'));
    }
  }
});
