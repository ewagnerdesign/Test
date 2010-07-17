(function($) {
  $.sv.validators = {
    required:{
       message: 'This field is required',
       fn: function(element, value, params) {
        if($(element).is('select')) {
          var selected = $(element).find(':selected');
          if(selected.length == 0) return false;
          if(params.except !== undefined) {
            return !$.sv.utils.valueIn(selected, params.except);
          } else if (params.only) {
            return $.sv.utils.valueIn(selected, params.only);
          } else {
            return !$.sv.utils.valueIn(selected, ["", "-1"]);
          }
        }else if($(element).is(':file')){
          return $(element).val()!==""
        }else {
          return $.sv.utils.getLength(element) > 0;
        }
      }
    },

    numeric: {
      message: 'Value should be an number',
      fn: function(element, value, params){
        return !isNaN(parseFloat(value)) && isFinite(value);
      }
    },

    min: {
      message: 'Value should be greater than',
      fn: function(element, value, params) {
        return value >= params;
      }
    },

    max: {
      message: 'Not implemented',
      fn: function(element, value, params) {
        return valie <= params;
      }
    },

    minlength: {
      message: 'Must be not shorter than {arg1}',
      fn: function(element, value, params) {
        return $.sv.utils.getLength(element) >= params;
      }
    },

    email: {
      message: 'Value should be valid email address',
      fn: function(element, value, params) {
        var regexp = /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
        return null!==value.toString().match(regexp)
      }
    },

    maxlength: {
      message: 'Must be more longer than {arg1}',
      fn: function(element, value, params) {
        return $.sv.utils.getLength(element) <= params;
      }
    },

    rangelength: {
      message: 'Length should be between {arg1} and {arg2}',
      fn: function(element, value, params) {
        var length = $.sv.utils.getLength(element);
        return $.sv.utils.lessThan(params[0], length) && $.sv.utils.moreThan(params[1], length)
      }
    },

    range: {
      message: 'Value should be between ... and ...',
      fn: function(element, value, params) {
        return $.sv.utils.lessThan(params[0], value) && $.sv.utils.moreThan(params[1], value)
      }
    },

    inclusion: {
      message: 'Value should be inclusion in ...',
      fn: function(element, value, params) {
        return -1!=$.inArray(value,params)
      }
    },

    exclusion: {
      message: 'Value should be exclusion in ...',
      fn: function(element, value, params) {
        return -1==$.inArray(value,params)
      }
    },

    format: {
      message: 'Invalid format',
      fn: function(element, value, params) {
        var pattern;
        switch( params ){
          case "numeric": pattern = /^(\d)+(\.+[\d]{1,})?$/; break;// allow float number
          case "digit": pattern = /^\d*$/; break;
          case 'email': pattern = /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i ; break;
          case 'words': pattern = /^[\w]*$/i; break;
          case 'print': pattern = /^:print/i; break;
        }
        return null!==value.toString().match(pattern)
      }
    },

    date: {
      message: 'Not implemented',
      fn: function() {
        return false;
      }
    },

    number: {
      message: 'Not implemented',
      fn: function() {
        return false;
      }
    },

    accept: {
      message: 'Not implemented',
      fn: function() {
        return false;
      }
    },

    //TODO: Implement allow empty option
    compare: {
      message: 'Field does not match',
      fn: function(element, value, params) {
        if(typeof params == 'string') {
          return  $.sv.utils.checkCondition([value, 'eq', $(params).val()], false);
          //Bind validation check on compared with change
          $(params).bind('keyup focusout', $.noop());
        } else if ($.isArray(params)) {
          //Prevent array modification
          params = params.slice();
          params.unshift(value);
          //Get value of element compared to
          params[2] = $(params[2]).val();
          //Comparison itself
          return $.sv.utils.checkCondition(params, false);
        } else {
          return false;
        }
      }
    }
  }


  $.sv.assert = function(validator, value, params, message){
    if( !$.sv.validators[validator] ){
      throw "not found validator with name "+ validator.toString()
    }

    // TODO check this
    if( !$.sv.validators[validator].fn( null, value, params) ){
      throw (typeof message=="undefined"? $.sv.validators[validator].message: message)
    }
  }

})(jQuery);
