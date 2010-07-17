//Abstract base class for controls with datasource
var FDDSControl = $.inherit(FDControl, {

    getDomainId: function() {
    var domainId = parseInt(this.options.base.domain_id);
    var checkCondition = function(domainIdParam){return domainIdParam==undefined || domainIdParam<=0};
    var tmpDomain = -1;
    if(checkCondition(domainId)){
        tmpDomain = this.controlBlock.data('fd.domain') || {domain:{id:-1}};
        domainId = tmpDomain.domain.id;
    }
    if(checkCondition(domainId)){
        tmpDomain = this.controlBlock.data('fd.tmp.domain') || {domain:{id:-1}};
        domainId = tmpDomain.domain.id;
    }

    if(typeof(domainId)!='number'){
        domainId = parseInt(domainId);
    }

    return domainId;
  }

},{});

var FDDSDropDown = $.inherit(FDDSControl, {
  options: {
    type: 'dsdropdown',
    control: '<select>',

    base: {
      cdash: "-1",
      options : {},
      selected: [],
      emptyElement: "false",
      
      domain_id: "-1",
      cdash_question_id: "-1"
    },
    sections: ['general', 'datasource', 'sdtm', 'dropdownOptions']
  },

  //Redefine control rendering
  _buildControl: function() {
    var control = $(this.options.control,
    $.extend({id: this.elId}, this._getControlOptions()));
    var __self = this;
    if(this.options.base.emptyElement==='true') {
        control.append($("<option></option>").attr("value","-1").text("-Please select-"));
    }
    $.each(this.options.base.options, function(key, val) {
          var optEl = $("<option></option>").attr("value",key).text(val);
          if(__self.options.base.selected == val) {
            optEl.attr('selected','selected');
          }
          control.append(optEl);
      });
    return control;
  }
},{});

var FDDSCheckBox = $.inherit(FDDSControl, {
  options: {
    type: 'dscheckbox',
    control: '<input>',
    elOpts: {
      type: 'checkbox'
    },
    base: {
      cdash: "-1",
      options : {},
      selected: [],
      domain_id: "-1",
      cdash_question_id: "-1"
    },
    sections: ['general', 'datasource', 'sdtm']
  },
  //Redefine control renderig
  _buildControl: function() {
    controls = [];
    __self = this;
    var base = $('<p>');
    //Show empty set
    if($.isEmptyObject(this.options.base.options)){
        base.html('Click to see options & select datasource');
    } else {
        var ch = 0;
        $.each(this.options.base.options, function(key, val) {
          optEl = $("<input>", {'type':'checkbox', 'id': __self.elId +'-ch'+ch}).attr("value",key);
          /*if(__self.options.base.selected.indexOf(key) != -1) {
            optEl.attr('checked','checked');
          }*/
          optEl = optEl.wrap('<span>').parent();
          base.append(optEl);
          optEl.append(
            $('<label>', {
              'for':__self.elId +'-ch'+ch
            }).text(val));
          ch  +=1;
        });
    }
    return base;
  }
},{});

var FDDSRadioBox = $.inherit(FDDSControl, {
  options: {
    type: 'dsradiobox',
    control: '<input>',
    elOpts: {
      type: 'radio'
    },
    base: {
      cdash: "-1",
      options : {},
      selected: [],
      domain_id: "-1",
      cdash_question_id: "-1"
    },
    sections: ['general', 'datasource', 'sdtm']
  },

  //Redefine control renderig
  //TODO: Use options to render component
  _buildControl: function() {
    controls = [];
    __self = this;
    var base = $('<p>');
     if($.isEmptyObject(this.options.base.options)){
        base.html('Click to see options & select datasource');
    } else {
        var ch = 0;
        $.each(this.options.base.options, function(key, val) {
          optElId = __self.elId +'-rb'+ch;
          optEl = $("<input>", {'type':'radio', 'id': optElId, 'name':__self.elId +'-rb'}).attr("value",key);
          /*if(__self.options.base.selected == val) {
            optEl.attr('checked','checked');
          }*/
          optEl = optEl.wrap('<span>').parent();
          base.append(optEl);
          optEl.append(
            $('<label>', {
              'for':optElId
            }).text(val));
          ch  +=1;
        });
    }
    return base;
  }
},{});

var FDDSInput =  $.inherit(FDDSControl, {
  options: {
    type: 'dsinput',
    control: '<input>',
    elOpts: {
      /*type: 'radio'*/
    },
    base: {
      cdash: -1,
      options : {},
      selected: [],
      domain_id: "-1",
      cdash_question_id: "-1"
    },
    sections: ['general', 'datasource', 'sdtm']
  },

  _buildControl: function() {
    var input = $(this.options.control,
            $.extend({id: this.elId}, this._getControlOptions()));
    var dd = $('<select>');
    var __self = this;
    $.each(this.options.base.options, function(key, val) {
      optEl = $("<option></option>").attr("value",key).text(val);
      if(__self.options.base.selected == val) {
        optEl.attr('selected','selected');
      }
      dd.append(optEl);
    });

    return input.add(dd);
  }
},{});

var FDDSTextArea =  $.inherit(FDDSControl, {
  options: {
    type: 'dstextarea',
    control: '<textarea>',
    base: {
      cdash: -1,
      options : {},
      selected: [],
      domain_id: "-1",
      cdash_question_id: "-1"
    },
    sections: ['general', 'datasource']
  }
},{});

var FDDSInputText =  $.inherit(FDDSControl, {
  options: {
    type: 'dsinputtext',
    control: '<input>',
    elOpts: {
      type: 'text'
    },
    base: {
      cdash: -1,
      options : {},
      selected: [],
      domain_id: "-1",
      cdash_question_id: "-1"
    },
    sections: ['general', 'datasource']
  }
},{});