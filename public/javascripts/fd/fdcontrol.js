
/**
  TODO:
    Handle situation when options are invalid
*/
var FDControl = $.inherit({
  options : { },
  __constructor: function(element, objOptions, options) {
    //Load options
    //IMHO MEGA Hack - Combine object default options and than attach constructor passed options
    this.options = $.extend(
      //REQUIRED! otherwise will extend options for all instances
      {},
      this.options,
      (
        $.extend(true,{},FDControl.options,this.options)
      ),
      objOptions || {}
    );

    options = options || {}

    this.options.id = new FDControlId( options.id )
    this.elId = this.options.id.domId();


    // initialize validators for control
    this.validators = new FDValidatorCollection(this, options.validators );

    this.render(element, objOptions.position);
    //Unset position option, since it's no longer required
    delete this.options['position'];
  },

  render: function(element, position) {
    position = position || 'before';

    var controlBlock = $(this.options.wraper, {'id':this.elId});
    controlBlock.addClass(this.validators.isRequired() ? 'required optional':'optional');
    controlBlock.addClass(this.options.type);
    if(position == 'after') {
      $(element).after(controlBlock);
    } else if (position == 'append') {
      $(element).append(controlBlock);
    } else {
      $(element).before(controlBlock);
    }

    this.controlBlock = controlBlock;

    this._buildLabel().appendTo(controlBlock);
    this._buildControl().appendTo(controlBlock);
    this._buildToolbox().appendTo(controlBlock);

    controlBlock.data('fd.type', this.options.type);
    controlBlock.addClass('fdcontrol');
    controlBlock.effect("highlight", {}, 1500);
    controlBlock.bind('click', $.proxy(this, 'blockClick'));


    //TODO: Bind live event handlers for toolbox
    this.controlBlock.delegate('.bDel', 'click',$.proxy(function(e){
        e.preventDefault();
        if(  FDController.deleteActiveControl() ){
          this.controlBlock.hide("puff", {}, 1000, function(){$(this).remove()} );
        }
     },this));
    //Duplicate control
    this.controlBlock.delegate('.bAdd', 'click',$.proxy(function(e){
        e.preventDefault();
        FDController.addControl(
            this.options.type,
            { element: this.controlBlock, position:'after' },
            this.options,
            { validators: this.validators.save() }
        );
     },this));
  },

  blockClick :function(e) {
    var active = FDController.getActive();
    //Check is current row selected
    if(!active || active.id != this.elId) {
      //Send active to controller
      FDController.setActive(this.elId);
      //Activate current control block
      this.activate();
    }
    e.stopPropagation();
  },

  activate : function() {
    this.controlBlock.addClass('active');
    this.controlBlock.children('.fieldActions').show();
    this.validators.activate();
  },

  deactivate: function() {
    this.controlBlock.removeClass('active');
    this.controlBlock.children('.fieldActions').hide();
    this.validators.deactivate();
  },

  update: function() {
    //Clear content
    if( this.options.clearControlAfterUpdate != false ){
      this.controlBlock.html('');
    }

    this._buildLabel().appendTo(this.controlBlock);
    this._buildControl().appendTo(this.controlBlock);

    if( this.options.clearControlAfterUpdate != false ){
       this._buildToolbox().appendTo(this.controlBlock).show();
    }

    // update validators
    this.validators.update()

    // update required css class if required options exists in a control
    this.controlBlock.toggleClass('required', this.validators.isRequired() )
  },

  updateOptions: function(values) {
    this._updateGeneral(values);
  },

  remove: function(){},

  getTitle: function(){
//    return this.options.base.label;
    return ( this.options.base.label? this.options.base.label:"" )+
           " (#"+ this.options.type+")"
  },

  getId: function() {
    return this.options.id;
  },

  save: function(create) {
    create = create || false;
    var data = $.extend(
      true, {},
      {
        options: this.options.base,
        controlId: this.options.id.controlId
      },
      {
        id: this.getId().save(),
        type: this.options.type,
        validators: this.validators.save()
      }
    );
    //Reset real ids if recreating the form
    if(create) {
      data.controlId = "";
      data.id.controlId = "";
    }
    return data;
  },

  _updateGeneral: function(options) {
    this.options.base = $.extend({}, this.options.base, options);
  },

  _buildLabel: function() {
    if( "false"==this.options.base.label_enable){
      return $()
    }
    return $("<label>", {
      'for': this.elId,
      'html': this.options.base.label,
      'class': 'control_label'
    });
  },

  _buildControl: function() {
    return $(this.options.control,
            $.extend({id: this.elId+'-control'}, this._getControlOptions())
    );
  },

  _getControlOptions: function(){
    return this.options.elOpts || {};
  },

  _buildToolbox: function() {
     return $('<div>', {'class': 'fieldActions', 'style': 'display:none'}).append(
        $('<img>', { 'src': '/images/fd/add.png', 'class':'bAdd'}),
        $('<img>', { 'src': '/images/fd/delete.png','class':'bDel'}),
        $('<img>', { 'src': '/images/fd/move.png', 'class':'bMove'})
      )
  }

},{
  //Static Memebers
  options: {
      type: 'general',
      base: {
        label: 'Click here to change',
        label_enable: true,
        description:''
      },
      id: {},
      position: 0,
      wraper: '<div/>',
      sections: ['general'],
      parent:  false /* parent control params or false */,
      zIndex: 0 /* z-index for view element, set in render*/
  }
});

var FDInputText = $.inherit(FDControl, {
  options: {
    type     : 'input',
    control  : '<input>',
    elOpts   : {
      size:10,
      'class': 'inputText'
    }
  }
},{});

var FDTextArea = $.inherit(FDControl, {
  options: {
    type: 'textarea',
    control: '<textarea>',
    elOpts:  {},
    base: {
      rows: 5,
      cols: 25
    }
  },
  _getControlOptions: function(){
    return $.extend({}, this.options.elOpts || {}, {rows: this.options.base.rows, cols: this.options.base.cols});
  }
},{});


var FDDropDown = $.inherit(FDControl, {
  options: {
    type: 'dropdown',
    control: '<select>',
    base: {
      options : [],
      selected: [],
      emptyElement: "false"
    },
    sections: ['general', 'multiple', 'dropdownOptions']
  },

  updateOptions: function(options) {
    this._updateGeneral(options);
    //No need to split, implicly array received
    //this.options.base.options = this.options.base.options.split('\n');
  },

  //Redefine control rendering
  _buildControl: function() {

    var control = $(this.options.control,
            $.extend({id: this.elId}, this._getControlOptions()));
    var __self = this;
    if( this.options.base.emptyElement==="true" ){
       control.append(
          $("<option></option>").attr("value","-1").text("-Please select-")
       );
    }

    $.each(this.options.base.options, function(key, val) {
          var optEl = $("<option></option>").attr("value",val).text(val);
          if(__self.options.base.selected == val) {
            optEl.attr('selected','selected');
          }
          control.append(optEl);
      });
    return control;
  }
},{});

var FDCheckBox = $.inherit(FDControl, {
  options: {
    type: 'checkbox',
    control: '<input>',
    elOpts: {
      type: 'checkbox'
    },
    base: {
      options : ["First Choice", "Second Choice", "Third Choice"],
      selected: []
    },
    sections: ['general', 'multiple']
  },

  //Redefine control renderig
  _buildControl: function() {
    controls = [];
    __self = this;
    var base = $('<p>');
    var ch = 0;
    $.each(this.options.base.options, function(key, val) {
      optEl = $("<input>", {'type':'checkbox', 'id': __self.elId +'-ch'+ch}).attr("value",val);
       if(__self.options.base.selected.indexOf(val) != -1) {
        optEl.attr('checked','checked');
      }
      optEl = optEl.wrap('<span>').parent();
      base.append(optEl);
      optEl.append(
        $('<label>', {
          'for':__self.elId +'-ch'+ch
        }).text(val));
      ch  +=1;
    });
    return base;
  }
},{});

var FDRadioBox = $.inherit(FDControl, {
  options: {
    type: 'radiobox',
    control: '<input>',
    elOpts: {
      type: 'radio'
    },
    base: {
      options : ["First Choice", "Second Choice", "Third Choice"],
      selected: ""
    },
    sections: ['general', 'multiple']
  },

  //Redefine control renderig
  //TODO: Use options to render component
  _buildControl: function() {
    controls = [];
    __self = this;
    var base = $('<p>');
    var ch = 0;
    $.each(this.options.base.options, function(key, val) {
      optElId = __self.elId +'-rb'+ch;
      optEl = $("<input>", {'type':'radio', 'id': optElId, 'name':__self.elId +'-rb'}).attr("value",val);
       if(__self.options.base.selected == val) {
        optEl.attr('checked','checked');
      }
      optEl = optEl.wrap('<span>').parent();
      base.append(optEl);
      optEl.append(
        $('<label>', {
          'for':optElId
        }).text(val));
      ch  +=1;
    });
    return base;
  }
},{});

var FDFileUpload = $.inherit(FDControl, {
  options: {
    type: 'file',
    control: '<input>',
    elOpts: {
      type: 'file'
    }
  }
},{});

var FDSection = $.inherit(FDControl, {
  options: {
    type: 'section',
    base: {
       label: 'Section Break',
       description: 'A description of the section goes here.'
    }
  },

  _buildLabel:function() {
    return $();
  },

  _buildControl: function() {
    return $('<h3>').text(this.options.base.label).add(
      $('<div>').text(this.options.base.description).addClass('form-note')
    );
  }

},{});

var FDInputDate = $.inherit(FDControl, {
  options: {
    type     : 'dateinput',
    control  : '<input>',
    elOpts   : {
      size:10,
      'class': 'inputDate'
    }
  },

  render:function(element, position){
    this.__base(element, position);
    this.controlBlock.find('input').datepicker({onSelect: function() {}});
  }
},{});


