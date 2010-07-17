var FDConnection = $.inherit({
  controls:{},
  id: null,

  options: {
    inversion: false,
    union_conditions: 1,
    name: ""
  },

  __constructor: function(collection, connectionId, objectData) {
    this.collection = collection;

    this.controls= $.extend(true, {}, this.controls );
    this.id = connectionId;

    objectData = objectData || {}

    this.controls = {
      tree: new FDConnection.Tree( FDConnection.Tree.container, objectData.tree ),
      target: new FDConnection.Operational(this, objectData.targets),
      source: new FDConnection.Condition(this, objectData.sources)
      //TODO: add control for options options
    }

    // set default name
    this.options.name = 'Control Relation #'+this.id


    this.options = $.extend(true,{}, this.options, objectData.options)
  },

  getTitle: function() {
    return this.options.name;
  },

  setTitle: function(newTitle) {
    if(newTitle==""){
      throw "connection name can't be blank"
    }
//    $.sv.assert('format', newTitle, 'print')

    $.each(this.collection.connections, $.proxy(function(index, connection) {
      if(connection.id!==this.id && connection.getTitle()==newTitle){
        throw "connection with this name alredy exists"
      }
    }, this));

    this.options.name = newTitle
  },


  activate: function() {
    // set active connection instance
    FDConnection.active = this;

    // activate each of control
    $.each(this.controls, function(index, control) {
      control.activate()
    });

    // render connection options
    FDConnection.conditionUnionControl.val( this.options.union_conditions )
    FDConnection.inversionControl.attr('checked', this.options.inversion)

    // highlight connection in a connections list
    this.collection._highlightItem(this.id)

    FDConnection.show();
  },

  deactivate: function() {
    if(FDConnection.active && this.id == FDConnection.active.id){
      FDConnection.active = false;
      FDConnection.hide()
    }
  },

  save: function() {
    return {
      tree: this.controls.tree.save(),
      options: this.options,
      sources: this.controls.source.save(),
      targets: this.controls.target.save()
    }
  },

  remove: function() {
    this.deactivate();
  },

  isUseControls: function(controlIds){
    return this.controls.source.isUseControls(controlIds)
          ||  this.controls.target.isUseControls(controlIds)
  },

  isEmpty: function(){
    return $.isEmptyObject( this.controls.source.options ) &&
              $.isEmptyObject( this.controls.target.options )
  },

  removeControl: function(control){
    var rthis = this;
    $.each(['source', 'target', 'tree'], function(key, control_name){
      rthis.controls[control_name].removeControl(control)
    })
  }

},{ // static

  connectionCounter: 0,

  container:{},
  active: false,
  inversionControl: {},
  conditionUnionControl: {},

  init: function() {
    $('#fdConnections').click(function(e){
      $('.pane-view').hide();
      $('#menu').children('div').hide();
      $('#connections').show();
      $('#connection-menu').show()
    });

    this.inversionControl = $("#fdConnectionInversion")
    this.conditionUnionControl = $("#fdConnectionConditionUnion")
    this.connectionOptions = $("#connectionOptions")

    // init events
    this.inversionControl.change(this._onInversionChange)
    this.conditionUnionControl.change(this._onConditionUnionChange)
  },

  _onInversionChange: function(event) {
    try {
      FDConnection.getActive().options.inversion = $(this).attr('checked')
    }catch(err){
      $.error('change inversion options in connection', err)
    }
  },

  _onConditionUnionChange: function(event){
    try{
      FDConnection.getActive().options.union_conditions = $(this).val()
    }catch(err){
        $.error('change condition union options in connection', err)
    }
  },

  generateId: function() {
    return ++this.connectionCounter;
  },

  getActive: function(controlName){
    // TODO: add validators
    if(!controlName){
      return this.active;
    }
    if(!this.active || !this.active.controls || !this.active.controls[controlName] ){
      throw "not found active connection with name " + controlName
    }
    return this.active.controls[controlName]
  },

  show: function() {
    this.connectionOptions.show()
    FDConnection.Tree.show()
  },

  hide: function() {
    this.connectionOptions.hide()
    FDConnection.Tree.hide()
  },

  activate: function() {
    FDConnection.Condition.activate()
    FDConnection.Operational.activate()
    FDConnection.Tree.activate()
  },

  deactivate: function() {
    FDConnection.Condition.deactivate()
    FDConnection.Operational.deactivate()
    FDConnection.Tree.deactivate()
  }

});

$(document).ready(function(){
  $.proxy(FDConnection.init(), FDConnection)
})
