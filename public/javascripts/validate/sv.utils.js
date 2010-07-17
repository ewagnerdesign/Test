(function($) {
  $.tryIt = function(object, field) {
    if(!$.isPlainObject(object))
      return null;
    if(object[field] !== undefined) {
      return object[field];
    } else {
      return null;
    }
  }

  //Helper method for easy validator creation
  $.v = function(validator, options, message, condition) {
    options = options || true;
    var obj = {};
    obj['type'] = validator;
    obj['options'] = options;
    obj['message'] = message;
    obj['action'] = condition;
    return obj;
  }

  $.sv = $.sv || {}

  $.sv.utils = $.sv.utils || {}

  $.sv.utils.arg = function(str, args) {
    if($.isPlainObject(args)) {
      return str.replace(/\{(\w+)\}/gi, function($1,$2){
        return $.tryIt(args, $2) || ""
      })
    } else if ($.isArray(args)) {
      return str.replace(/\{arg(\d)+}/gi, function($1,$2){
        return args[$2-1] || ""
      }).replace(/\{args}/gi, args.join(',') )

    } else {
      return str.replace(/\{arg(\d)+}/gi, args).
              replace(/\{args}/gi, args)
    }
  }

  /*
  * Get object length as for hash
  */
  $.sv.utils.objectLength = function(obj) {
    var size = 0, key;
    for (key in obj) {
        if (obj.hasOwnProperty(key)) size++;
    }
    return size;
  }

  /*
   * [Value, comparison operator, value to compare with], getValue
   * gt - value greater
   * gte - value greater or eaqual
   * lt - value is less
   * lte - value is less or eaqual
   * eq - exact match
   * include - value in range
   * exclude - value not in range
   * gt,gte,lt,lte works only for integers, implict convertion is used
   */
  $.sv.utils.checkCondition = function(condition, getValue) {
    //Default behaviour
    if(getValue == null) {
      getValue = true;
    }
    var value = (getValue ? $(condition[0]).val() : condition[0])

    if(!$.isArray(condition)){
      //TODO: Implement default behaviour here
    } else {
      switch(condition[1]) {
        case 'eq':
          return (value == condition[2])
          break;
        case 'neq':
          return (value !== condition[2])
          break;
        case 'checked':
          return (value == condition[2]) && $(condition[0]).attr('checked')
          break
        case 'unchecked':
          return (value == condition[2]) && !$(condition[0]).attr('checked')
          break
        case 'gt':
          return (parseInt(value) > parseInt(condition[2]))
          break;
        case 'gte':
          return (parseInt(value) >= parseInt(condition[2]))
          break;
        case 'lt':
          return (parseInt(value) < parseInt(condition[2]))
          break;
        case 'lte':
          return (parseInt(value) <= parseInt(condition[2]))
        case 'include':
          return $.inArray(value, $.makeArray(condition[2]));
          break;
        case 'exclude':
          return !$.inArray(value, $.makeArray(condition[2]));
          break;
        //case ':is'
      }
    }
  }

  $.sv.utils.runAction = function(action){
    switch(action[1]) {
      case 'show':
          $(action[0]).show();
        break;
      case 'hide':
          $(action[0]).hide();
        break;
    }
  }

  $.sv.utils.runInversionAction = function(action){
    var actionInversion = {
      'show': 'hide',
      'hide': 'show'
    }
    if( !actionInversion[action[1]] ){
      throw "$.sv.utils.runInversionAction, inversion action not found"
    }
    $.sv.utils.runAction([action[0], actionInversion[action[1]]])
  }

  $.sv.utils.parseParams=function(params) {
    /* Simplified form of validator notation
     * rules : { validator_name: params }
     */
    var validators = [];
    if($.isPlainObject(params)) {
      $.each(params, function(key, value){
        /* Simplified form with additional options
         *  validator_name: {options: opts, message:'Validation message', condition: condition struct}
         * OR
         *  validator_name: {option1: value, option2:value, message:'Validation message', condition: condition struct}
         */
        if($.isPlainObject(value)) {
          if($.tryIt(value,'options') !== null) {
            validators.push($.v(key, $.tryIt(value,'options'), $.tryIt(value, 'message'), $.tryIt(value, 'action')));
          } else {
            //Extended format of simplified form
            var message = $.tryIt(value, 'message');
            if(message !== null) {
              delete value['message'];
            }
            var condition = $.tryIt(value, 'action');
            if(condition !== null) {
              delete value['action'];
            }
            validators.push($.v(key, value, message, condition));
          }
        } else {
          validators.push($.v(key, value));
        }
      });
    } else if($.isArray(params)){
      //Array of params or not params, 'll see it later :D
       $.each(params, function(key, value){
        if(value['type'] !== undefined) {
          //Well formated rule
          validators.push(value);
        }
       });


    } else {
       //Check does validator is already in normal form
    }
    return validators;

  }
  $.sv.utils.isMultiple = function(element) {
    return $(element).is('select, :radio, :checkbox');
  }

  $.sv.utils.getLength = function(element) {
    element = $(element);
    if(element.is('select')) {
      return $("option:selected", element).length
    } else if(element.is(':radio, :checkbox')) {
      return $('*[name="'+element.attr('name')+'"]').filter(':checked').length
    } else {
      return element.val().length
    }
  }

  $.sv.utils.valueIn = function(elements, param) {
    var found = false;
    param = $.makeArray(param);
    $.each(elements, function(i, element) {
      if($.inArray($(element).val(), param) != -1) {
        found = true;
        return false;
      }
    });
    return found;
  }

  $.sv.utils.lessThan = function(val1, val2){
    return val1!=="" ? parseFloat(val1)<=val2: true
  }

  $.sv.utils.moreThan = function(val1, val2){
    return val1!=="" ? parseFloat(val1)>=val2: true
  }



})(jQuery);
