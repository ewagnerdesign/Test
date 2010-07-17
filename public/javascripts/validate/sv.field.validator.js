(function($) {
  $.sv = $.sv || {}
  $.sv.field = $.sv.field || {}

  $.sv.field.validatior = {
    conf: {
      errorClass: 'error',
      validClass: 'valid',
      errorWraper: '<span>',
      oneError: true,
      renderError: true,
      renderSucess: false,
      api: false,
      enabled: true,
      successMessage: 'Thank you!',
      live: true
    }
  }

  function FieldValidator(el, conf) {
    var self = this, $self = $(this);
    var el = $(el);
    var validators = [];
    var messages = [];
    self.errorsList = [];
    el.bind('validate', function(e){
      self.valid();
    });

    // bind all callbacks from configuration
    $.each(conf, function(name, fn) {
      if ($.isFunction(fn)) { el.bind(name, fn); }
    });

    el.bind('keyup focusout change',function(e){
      //Prevent validation in case when keyup tab in new element
      if(!(e.handleObj.type == 'keyup' && e.keyCode == 9)) {
        self.valid();
      }
    });

    $.extend(self, {
      //Field validation
      add: function(conf) {
        var normalizedRules = $.sv.utils.parseParams(conf);
        $.each(normalizedRules, function(i, rule){

          validators.push(rule);
          //Fire validation if condition subject has been changed
          if(rule.action) {
            $(rule.action[0]).change(function(){
              self.valid();
            });
          }
        });
      },

      valid: function() {
        // not validate unvisible elements
        if(!conf.enabled || !el.is(":visible") ){
          return true;
        }
        self.reset();
        $.each(validators, function(name, params){
          //Conditional check
          if(params.action) {
            if(!$.sv.utils.checkCondition(params.action)){
              //Bypass validator by condition
              return true;
            }
          }
          var validator = $.sv.validators[params.type];
          if(validator.fn.call(self, el, el.val(), params.options)!== true){
            self.errorsList.push($.sv.utils.arg($.tryIt(params, 'message') || validator.message, params.options));
            if(conf.oneError) {
              //Break validation on first error found
              return false;
            }
          }
        });
        if(self.errorsList.length > 0){
          var e = e || $.Event('onError');
          e.errors = self.errorsList;
          el.trigger(e, [el, self.errors]);
          if(conf.renderError && !e.isDefaultPrevented()) {
            //Error messages rendering
            el.addClass(conf.errorClass).removeClass(conf.validClass);
            if($.sv.utils.isMultiple(el)) {
              messages.push($(conf.errorWraper).text(self.errorsList.join(',')).addClass('error').insertAfter($('*[name="'+el.attr('name')+'"]:last')).first());
            } else {
              messages.push($(conf.errorWraper).text(self.errorsList.join(',')).addClass('error').insertAfter(el).first());
            }
          }
        } else {
          //Success event
          var e = e || $.Event('onSuccess');
          el.trigger(e);
          if(conf.renderSucess && !e.isDefaultPrevented()){
            //Render default success message
            messages.push($('<span>').text(conf.successMessage).addClass('success').insertAfter(el).first());
            el.removeClass(conf.errorClass).addClass(conf.validClass);
          }
        }
        return self.errorsList.length == 0
      },

      rules: function(){
        return self.validators;
      },

      remove: function(){

      },

      reset: function() {
        self.errorsList = [];

        var e = e || $.Event();
        e.type = "onReset";
        el.trigger(e, [el]);
        if (!e.isDefaultPrevented()) {
          //Remove classes if error is not prevented
          el.removeClass(conf.errorClass).removeClass(conf.validClass);
        }

        //Remove Success message anyway
        $.each(messages, function(){
          $(this).remove()
        });
        messages = [];
      },

      enable: function() {
        conf.enabled = true;
      },

      disable: function() {
        conf.enabled = false;
      },

      errors: function() {
        return self.errorsList;
      },

      onValidationError: function(fn) {
          return this.bind("sv.onValidationError", fn);
      }
    });
    self.add(conf.rules);
    el.data('sv.validator', self);
  }

  //Plugin itself
  $.fn.validate= function(conf) {
    var el = this.eq(typeof conf == 'number' ? conf : 0).data("sv.validator");
    if (el) { return el; }
    conf = $.extend(true, $.extend({},$.sv.field.validatior.conf), conf);
    this.each(function(){
        el = new FieldValidator($(this),conf);
        $(this).data("sv.validator", el);
    });
    return conf.api ? el : this;
  }

})(jQuery);
