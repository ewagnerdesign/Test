(function($) {
  $.sv = $.sv || {}
  $.sv.form = $.sv.form || {}
  $.sv.form.validatior = {
    conf: {
      api: false,
      enabled: true,
      preventSubmit: true,
      fieldValidatorDefault:{}
    }
  }

  function FormValidator(trigger, rules, conf) {
    //private vars
    var self = this,
      $self = $(this);
    var el = $(trigger);
    var errorsList = {};
    var controls= [];
    var formSubmited = false;
    if(conf.preventSubmit) {
      //Remove onSubmit attribute to prevent its execution
      el.attr('oldSubmit', el.attr('onSubmit'));
      el.attr('onSubmit', $.noop);
    }

    el.bind('submit', function(e) {
      formSubmited = true;
      var valid = self.valid();
      formSubmited = false;

      var e = $.Event('onFormSubmit');
      e.valid = valid;
      el.trigger(e);

      if(conf.preventSubmit) {
        //Restore previous error handler
        if(valid) {
          //Trigger original onSubmit handler
          var submitHandler = el.attr('oldSubmit');
          if (typeof submitHandler === 'function') {
            return submitHandler();
          } else {
//            eval(submitHandler);
          }
        }
        return valid;
      } else {
        return true;
      }
    });

    // bind all callbacks from configuration
    $.each(conf, function(name, fn) {
      if ($.isFunction(fn)) { el.bind(name, fn); }
    });

    $.extend(self, {
      //API methods
      add: function(element, validator) {
        controls.push(element);
        element.validate({rules: validator});
      },

      valid: function() {
        if(!conf.enabled) return true;
        self.reset();
        var ev = jQuery.Event('validate');
        ev.caller = el;
        el.find(':input').trigger(ev);

        //var e = e || $.Event('onFormError');
        //e.errors = errorsList;
        return $.sv.utils.objectLength(errorsList) == 0;
      },

      reset: function() {
        errorsList = {};
        //Reset all children validators
        el.find(':input').trigger($.Event('reset'));

        //Trigger form reset event
        var e = e || $.Event();
        e.type = "onFormReset";
        el.trigger(e, [el]);
      }
    });

    $.each(rules, function(element, validator) {
      self.add($('#'+element), validator);
    });

    //Remove onSubmit handler to prevent its execution
    if(conf.preventSubmit && el.attr('onSubmit')){
      el.attr('oldSubmit', el.attr('onSubmit'));
      el.attr('onSubmit', "");
    }

    //Collect errors while live validation
    el.bind('onError', function(e, params) {
      errorsList[params.attr('id')] = e.errors;
      //TODO: Prevent default behaviour according to FormValidator
      //Fire onFormError if form is not submited but errors received form chil components
      if(!formSubmited) {
        var e = e || $.Event('onFormError');
        e.errors = errorsList;
      }
    });
  }

  //Plugin implementations
  $.fn.validateForm = function(rules, conf) {
    var el = this.eq(typeof conf == 'number' ? conf : 0).data("sv.validator");
    if (el) { return el; }
    conf = $.extend(true, $.extend({},$.sv.form.validatior.conf), conf);
    this.each(function(){
        el = new FormValidator($(this),rules, conf);
        $(this).data("sv.validator", el);
    });
    return conf.api ? el : this;
  }
})(jQuery);
