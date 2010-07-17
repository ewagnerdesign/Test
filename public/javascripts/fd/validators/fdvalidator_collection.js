var FDValidatorCollection = $.inherit({

  availableValidators: [],

  /**
   *
   * structure data {
   *     validator_type: {
   *        validatorId1: validator_instance1,
   *        validatorId2: validator_instance2
   *    }
   * }
  */
  validators: {},
  container: null,
  options:{},

  __constructor : function(control, options) {

    // initialize class values
    this.validators = {};
    this.control = control;
    this.availableValidators = this.getAvailableValidators();

    this.Id = "collection" + control.Id;

    // TODO: refactoring load validators
    // load saved data
    if( options ){
       this.load(options)
    } else {
      // show validators available control
      $.each(this.availableValidators, $.proxy(function(index,value){
            this.add( value );
        }, this)
      );
    }
  },

  clear: function(){
    FDValidatorCollection.validators.html('');
  },

  isRequired: function(){
    return this.isEnabled('required', "select_count")
  },

  isEnabled: function() {
    var validatorEnabled = false

    for(var i=0; i<arguments.length; i++){
      var validatorName = arguments[i]
      if( !this.validators[validatorName] ){
        continue;
      }
      $.each(this.validators[validatorName], function(index, validator) {
        if( validator.isEnabled() ){
          validatorEnabled=true
          return false
        }
      });
    }

    return validatorEnabled;
  },

  render: function() {
    if( this.availableValidators.length==0  ){
      FDValidatorCollection.container.hide();
    } else {
      FDValidatorCollection.container.show();
    }

    this.clear();

    // render each validator
    $.each(this.validators, function(type, validators){
      $.each(validators, function(validatorId,validator){
          validator.activate();
      });
    });
  },

  initEvents: function() {
    FDValidatorCollection.container.delegate(
        'input[type=checkbox]',
        "change",
        function(event){
            if( event.set_values ){
               $(this).attr('checked', $(this).val()=="true" );
            } else {
                $(this).val( $(this).is(':checked').toString() );
            }
        }
    );

    FDValidatorCollection.container.delegate(
      '.validator-title > input[type=checkbox]',
      "change",
      function(){
        $(this).parents('li').
          find('div.validator-content').
          toggle( $(this).is(':checked') )
      }
    );

    FDValidatorCollection.container.delegate(
      'div.validator-title',
      "click",
      function(e){
          if( e.originalTarget && !$(e.originalTarget).hasClass("validator-title") ){
            return;
          }
          var checkbox = $(this).find('input[type=checkbox]');
          checkbox.attr( 'checked', !checkbox.is(':checked') );
          checkbox.trigger('change')
      }
    );
  },

  /**
   * Return validators list available for current control
   */
  getAvailableValidators: function(){
    var controlType = this.control.options.type;
    var validators=[];
    $.each(FDValidatorCollection.validatorsMap,  function(index, value){
        if( -1 != $.inArray( controlType, value.available_controls ) ){
          validators.push(index);
        }
    });
    return validators;
  },

  /**
   * Add new validator in a collection
   */
  add: function(validator_type, options){
    if( !FDValidatorCollection.validatorsMap[validator_type] ){
      throw "FDValidatorCollection::add validator type '"+validator_type+"' not found"
    }
    if( !this.validators[validator_type] ){
      this.validators[validator_type]=[];
    }
    var validator = new FDValidatorCollection.validatorsMap[validator_type](this, options);
    validator.type = validator_type;
    this.validators[validator_type].push(validator);
    return validator;
  },

  update: function(){
    $.each(this.validators, function(type, validators){
      $.each(validators, function(validatorId,validator){
          validator.update();
      });
    });
  },

  /**
   * structure save data
   * [
   *   { type: "", data: {} },
   *   { type: "", data: {} },
   *   ....
   * ]
   */
  save: function(){
    var data = [];
    $.each(this.validators, function(type, validators){
      $.each(validators, function(validatorId,validator){
        data.push({
            type: type,
            data: validator.save()
        });
      });
    });
    return data;
  },

  load: function(data){
    if( !data ){
      return;
    }
    $.each( data, $.proxy(function(key,validatorObj){
       this.add( validatorObj.type, validatorObj.data )
    }, this));

  },

  /**
   * Remove all validators
   */
  remove: function( object ){
    if( object ){
      // delete validator
      var validatorType = FDValidatorCollection.getObjectType(object);
      if( !validatorType ){
        return;
      }
      // can't delete last validator
      if( this.validators[validatorType].length==1 ){
        return;
      }

      $.each(this.validators[validatorType], $.proxy(function(index, validatorObject){
         if( object.elId == validatorObject.elId ){
           validatorObject.remove();
           this.validators[validatorType].splice(index, 1);
           return false;
         }
      }, this));
   } else {
      // TODO: delete all validators
    }
  },

  doValidations: function(){

  },

  /**
   * activate all validators
   */
  activate: function(){
    this.render();
    this.initEvents();
  },

  /**
   * Deactivate all validators
   */
  deactivate: function(){
    $.each(this.validators, function(type, validators){
      $.each(validators, function(validatorId,validator){
          validator.deactivate();
      });
    });
  },

  onChangeSourceData: function(){
    if( this.control.options.type!="dsinput" ){
      return;
    }
    $.each(this.validators, function(type, validators){
      $.each(validators, function(validatorId,validator){
          validator.onChangeSourceData();
      });
    });
  }

}, {

  validatorsMap: {
    required: FDValidator.Required,
    size: FDValidator.Length, // must be not length (reserved word)
    presents: FDValidator.Presense,
    format: FDValidator.Format,
    inclusion: FDValidator.Inclusion,
    exclusion: FDValidator.Exclusion,
    range: FDValidator.Range,
    select_count: FDValidator.SelectCount,


    dslength: FDValidator.DSLength,
    dsrange: FDValidator.DSRange,
    dsinclusion: FDValidator.DSInclusion,
    dsexclusion: FDValidator.DSExclusion,
    dsformat: FDValidator.DSFormat

//    'date': FDValidator.Date

  },

  container: null,
  validators: null,
  collectionId:0,

  getId: function() {
   return ++this.collectionId;
  },

  getObjectType: function(object) {
    var type = false;
    $.each(FDValidatorCollection.validatorsMap,  function(validatorType, classObject){
        if( object instanceof classObject ) {
           type  = validatorType;
           return false;
        }
    });
    return type;
  },

  init: function(){
    $.each(FDValidatorCollection.validatorsMap,  function(index, value){
       value.init();
    });

    this.container = $("#opt-validators");

    this.validators = this.container.find(".validators");

    $('#fValidatorsSelect').overlay({
        api: true,
        expose: '#000'
    });
  }

});
