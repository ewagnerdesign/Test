
var FConnection = $.inherit({

  conditions: [],
  actions: [],
  options: {},

  __constructor: function(savedData) {
    this.conditions = []
    this.actions = []

    this.options = $.extend(true, {}, savedData.options)

    $.each(savedData.targets, $.proxy(function(index, options) {
      this.initTarget(options)
    }, this))

    $.each(savedData.sources, $.proxy(function(index, options) {
      this.initSource(options)
    }, this))


    this.onSourceChange( {activateInversion: true} )
  },

  initTarget: function(options) {
    var elements = this._controlElement(options.control)

    if( !elements.hasClass("colcontainer") ){
      elements = elements.parents('.ctrlHolder');
    }

    this.actions.push([ elements, options.action ])
  },

  initSource: function(options) {
    var elements = this._controlElement(options.control)

    if(elements.is(':radio, :checkbox')){
      elements =  $('*[name="'+elements.attr('name')+'"]')
    }

    elements.change($.proxy(this.onSourceChange,this))

    var rthis = this;
    $.each(options.conditions, function(index, condition) {
      var sourceCondition = []
      $.each(elements, function(index, element) {
        sourceCondition.push(
            [element, condition.comp, condition.value]
        )
      })
      rthis.conditions.push( sourceCondition )
    })
  },

  onSourceChange: function(options) {
    var fireTargets = true ;
    var unionCondition =  parseInt(this.options.union_conditions)==1
    $.each(this.conditions, function(index, conditionGroup) {

      var conditionResult = false;
      $.each(conditionGroup, function(index, conditionData) {
        if( $.sv.utils.checkCondition(conditionData, true) ){
          conditionResult = true;
          return false;
        }
      });

      if( conditionResult ){
        if(unionCondition){
          // continue if union conditions
          fireTargets = fireTargets && conditionResult
          return fireTargets;// break or continue check conditions
        } else {
          fireTargets = true
          return false;
        }

      } else {
        fireTargets = false
      }
    })

    if( fireTargets ){
      this.activateTargets();
    }else if(this.options.inversion || options.activateInversion){
      this.activateInversionTargets()
    }
  },

  activateTargets: function() {
    $.each(this.actions, function(index, action) {
      $.sv.utils.runAction(action)
    });
  },

  activateInversionTargets: function() {
    $.each(this.actions, function(index, action) {
      $.sv.utils.runInversionAction(action)
    });
  },

  _controlElement: function(control) {
    var controlId = "#control_"+control.id.controlId
    var element = $(controlId)
    if( $.isEmptyObject(element) ){
      throw "control not not found with id "+ controlId
    }

    return element;
  }


})