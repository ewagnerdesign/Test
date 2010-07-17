var FDController = $.inherit({
},{
  controlId:0,
  controls: {},
  ds: [],
  sortOrder: [],
  controlsMap: {
    'text'      : null,
    'input'     : FDInputText,
    'dateinput' : FDInputDate,
    'textarea'  : FDTextArea,
    'dropdown'  : FDDropDown,
    'checkbox'  : FDCheckBox,
    'radiobox'  : FDRadioBox,
    'file'      : FDFileUpload,
    'dsdropdown': FDDSDropDown,
    'dscheckbox': FDDSCheckBox,
    'dsradiobox': FDDSRadioBox,
    'section'   : FDSection,
    'dsinput'   : FDDSInput,
    'dstextarea'   : FDDSTextArea,
    'dsinputtext'   : FDDSInputText,
    'column'    : FDColumnBlock,
    'column-item': FDColumnItem
  },
  activeControl : {},
  activeTab     : 'fdc',

  init:function(options){
    FBdnd.init({
      onDragStart: function(subject){
        FDController.dObject = subject.attr('fdtype');
      },
      onDrop:function(dropPos){
        var el = FDController.addControl(FDController.dObject, dropPos);
        //Add children to the Column Control
        if(dropPos.column) {
          FDController.controls[$(dropPos.column.region).attr('id')].addChild(dropPos.column.col, el);
        }
      }
    });

    //TODO: Move this out of here!!!!!!!!!!!!!!!!!
    this.connections = new FDConnectionCollection();

    // init validators
    FDValidatorCollection.init();

    $('#save-options').bind('click',$.proxy(this, 'saveOptions'));
    this._bindSidebar();

    //Init options handlers
    this.optDD = new FDMultiSelect($('#opt-options'), {multi:false});
    var rthis = this;
    this.optDS = new FDDSMultiSelect(
        $('#opt-cdash'), {
              multi: false,
              sdtmCategories: options.sdtmCategories,
              onChangeList: function(){
                  rthis.controls[rthis.activeControl.id].validators.onChangeSourceData();
              }
        }
    );


    //Sortable list
    $("#builderpane form").sortable({
      axis: 'y',
      cursor: 'crosshair',
      handle: ' > .fieldActions > .bMove ', // skip .bMove handlers in column controls
      forcePlaceholderSize: true,
      tolerance: 'pointer',
      containment: 'parent',
      placeholder:'state-highlight',
      opacity: 0.6,
      items: "> div:not(#FDForm)",
      update: function(event, ui) {
        //Preserve sort order
        FDController.sortOrder = $(this).sortable('toArray');
      }
    });

    //Clear selection
    $('#builderpane').click(function(e) {
      var active = FDController.getActive();
      if(active && active.control != null) {
        active.control.deactivate();
      }
      //TODO: Hide all options and show no selected message
      FDController.setActive(null);
    });

    if( options.data ){
       this.load( options.data );
    } else {

      //Add top form info
      this.form = new FDForm('#builderpane form');

      //Add Main Column
      this.addControl('column',null, {base: {columns: 1}});
      this.connections.load()
    }


    //No fields notice click
    $('#nofields').click($.proxy(this,'onNofieldsNoticeClick'));

    //Save Form Options, not form TODO: rename this
    $('#form-save').click($.proxy(this,'updateFormOptions'));

    //save checked status in value
    $('#panel-options input[type=checkbox]').change(
        function(event){
            if( event.set_values ){
               $(this).attr('checked', $(this).val()=="true" );
            } else {
                $(this).val( $(this).is(':checked').toString() );
            }
        }
    );
  },
// end init

  getControlStruct: function() {
    // TODO: get all control structure for form
    var parentControls = $("#builderpane form").sortable('toArray');
    var controlsData = {};
    $.each(parentControls, function(i, controlId) {
        try{
           controlsData[controlId] = FDController.getControlById(controlId);
        }catch(err){
          $.error("getControlStruct", err)
        }
    });
    return controlsData;
  },

  /**
   * Save entire form in JSON
   */
  save: function(create) {
    create = create || false;
    this.onNofieldsNoticeClick()

    // TODO: refactoring this method
    var qForm = {}
    //Update sort order
    this.sortOrder = $("#builderpane form").sortable('toArray');
    //Get form options
    qForm.form = this.form.options;
    qForm.controls = [];
    //Save fields based on theirs order
    for(var i=0;i<this.sortOrder.length;i++) {
      if(this.sortOrder[i] == 'FDForm' || this.sortOrder[i] == 'nofields') {
        continue;
      }
      if(this.controls[this.sortOrder[i]].options.type == 'column') {
        var group = this.controls[this.sortOrder[i]];

        var struc = {group:{ size:group.options.base.columns,  id: group.options.id.base, columns:[]}};
        //Clear controlId if any on create/recreate form
        if(create){
          struc.group.id.controlId = "";
        }
        var controllist = this.controls;
        //Populate all children
        $.each(group.children, function(key,controlIds) {
          //Each column
          var col = [];
          var controlRange = [];

          //reorder controls using UI index position
          $.each(controlIds, function(ind, controlId){
            controlRange.push({
               index: $('#'+controlId).index(),
               controlId: controlId
            });
          })
          controlRange.sort(function(x, y){
              var a = x.index;
              var b = y.index;
              if(a>b){
                  return 1;
              }
              else if(a==b){
                  return 0;
              }
              return -1;
          });
          //end of reordering
          //Each element in the column
          $.each(controlRange, function(ind, controlPair){
            var control = controllist[controlPair.controlId];
            if(control != undefined && control){
                col.push({
                  control: control.save(create)
                });
            }
          });

          struc.group.columns.push(col);
        });

        //Add control group into form controls list
        qForm.controls.push(struc);

      } else {
        //Skip controls with parent, the are saved ealier
        if($('#'+this.sortOrder[i]).data('fd.parent')) {
          continue;
        }
        qForm.controls.push({
          control: this.controls[this.sortOrder[i]].save(create)
        });
      }
    }
    // save controls connections
    qForm.connections = this.connections.save()
    //Reset form_id on "save as form"
    if(create){
      qForm.form.formId = ""
    }
    return qForm;
  },

  /**
   * Restore form state from options
   */
  load: function(state){
    // TODO: refactoring this method
    //TODO: Restore form options
    //Clear form container
    this.clear();
    if($.isEmptyObject(state)) {
      state.controls = {};
      state.connections = {};
    }
    //Render form element
    this.form = new FDForm('#builderpane form', state.form);
    var __self = this;

    $.each(state.controls, function(key, val) {
      //Add ordinary control
      if(val.control) {
        __self.addControl(
            val.control.type,
            {
                element: $("#builderpane form"),
                position:'append'
            }, {
                base: val.control.options
            },
            {
                validators: val.control.validators,
                id: val.control.id
            }
        );
      } else if(val.group) {
        //Add group control
        var groupId = __self.addControl(
                'column',
                {
                  element: $("#builderpane form"),
                  position:'append'
                }, {
                  base: {columns: val.group.size }
                },
                {
                   id: val.group.id
                }
             );
        var groupControl = __self.controls[groupId];
        //Add controls to columns
        $.each(val.group.columns, function(colno, colcontrols) {
          var colId = '#'+groupControl.columns[colno];
          //Iterate over controls
          $.each(colcontrols,function(ctrlno, ctrlel){

            //Add control to column
            groupControl.addChild(
                colId,
                //Add control per se
                __self.addControl(
                    ctrlel.control.type,
                    {  element: $(colId), position:'append' },
                    {  base: ctrlel.control.options  },
                    {
                      validators: ctrlel.control.validators,
                      id: ctrlel.control.id
                    }
                )
            );
          });
        });
        //__self.addControl(val.control.type, {element: $("#builderpane form"), position:'append' }, {base: val.control.options});
      }
    });

    this.onControlsChange();

    //load controls connection
    this.connections.load(state.connections)
  },

  /*
   * Clear all form components
   */
  clear: function() {
    this.controls = {};
    this.activeControl = {};
    this.controlId = 0;
    this.form = null;
    this.connections.clear();
    $('#builderpane form > div ').remove()
  },

  saveOptions:function(event) {
    var options =this._collectOptions();
    //Update actual control options
    this.controls[this.activeControl.id].updateOptions(options);

    //TODO: Call this implictly
    this.controls[this.activeControl.id].update();
  },

  generateId: function() {
    return ++this.controlId;
  },

  addControl: function(controlType, dropPosition, objOptions, options) {
    objOptions= objOptions || {};
    dropPosition = dropPosition || {element: this.form.element, position:'after'};

    if(controlType) {
      obj = this.controlsMap[controlType];
      if(obj) {
        //Fire change event
        var instance = new obj(
            dropPosition.element,
            $.extend({},{position: dropPosition.position}, objOptions),
            options
        );
        this.controls[instance.elId] = instance;
        this.onControlsChange();
        return instance.elId;
      }
    }
    return false;
  },

  deleteActiveControl: function() {
    if( this.isConfirmRemoveControl() ){
      this.deleteControl( this.activeControl.id )
      this.setActive(null);
      return true;
    }
    return false;
  },

  isConfirmRemoveControl: function(controls){
    if(!controls){
      var actControl =  this.activeControl.control
      controls = actControl.options.type=='column'?
                 $.merge( actControl.getChildsControls(), [actControl] ):
                 [actControl]
    }

    if( this.connections.isUseControl(controls) ){
      return confirm("Are you sure want delete control(s) which used in connections?");
    }

    return true;
  },

  deleteControl: function(controlId){
    var control =  this.controls[ controlId ];
    if( !control ){
      return false;
//      throw "can't delete control with id ["+controlId+"]"
    }

    // remove control from connections
    this.connections.removeControl( control )

    //remove control
    control.remove()

    delete this.controls[ controlId ];

//    if(control.controlBlock && control.controlBlock.data('fd.parent')){
//      var parentData = control.controlBlock.data('fd.parent')
//      var parent = this.getControlById(parentData.container)
//      parent.removeChild(parentData.column, controlId)
//    }
    this.onControlsChange();

    return true;
  },

  activateFormOptions: function(show){
    //Deactivate any active control
    this.setActive(null);
    if(show) {
      //Set options form active, to allow other controls deactivate it
      this.activeControl = {id:  this.form.elId, control: this.form};
      //Hide field options
      $('#noFieldSlection').show();
      $('#optionGroup').hide();
      this.form.activate();
      //Activate form options tab
      this._activateTab('fdf');
      //Update control options in field
      this.loadFormOptions();

    } else {
      this.form.deactivate();
    }
  },

  getControlById: function(idData) {
    if( typeof idData =="object" ){
      $.each(FDController.controls, function(controlIndex, control) {
        if( control.options.id.isEqual(idData) ){
          idData = controlIndex
          return false;
        }
      });

      if( typeof idData =="object" ){
        throw "control not found with object id " + $.prepareObjectToString(idData);
      }
    }

    if( !FDController.controls[idData] ){
      throw "control not found with id " + idData;
    }

    // TODO: check
    return FDController.controls[idData];
  },

  getControlsById: function(controlIds){
    var result = []
    $.each(controlIds, function(key, controlId){
      try{
        result.push( FDController.getControlById( controlId) )
      }catch(err){
        $.error("getControlsById", err)
      }
    })
    return result;
  },

  loadFormOptions: function(){
    //activateFormOptions
    $.each(this.form.options, function(key, val){
        var optField = $('#form-'+key);
        //TODO: Handle empty array here
        if(key=='cumulative'){
            optField.attr('checked', val);
        }

        optField.attr('value', val);
    });
  },

  updateFormOptions: function(){
    var options = {};
    $.each(this.form.options, function(key, val){
        var optField = $('#form-'+key);
        //TODO: Handle empty array here
        options[key] = optField.val();
    });
    this.form.updateOptions(options);
  },

  setActive: function(element) {
    //Deactivate previous element
    if(this.activeControl.control != null) {
      this.activeControl.control.deactivate();
    }

    if(element) {
      this.activeControl = {id: element, control: this.controls[element]};
      this._activateTab('fdo');
      //Hide all sections
      $('*[fdtype|=optblock]').hide();
      $.each(this.activeControl.control.options.sections, function(cnt, section){
         $('#opt-'+ section).show();
      });
      //Reload options block
      $.each(this.activeControl.control.options.base, function(key, val){
        var optField = $('#opt-'+key);
        //TODO: Handle empty array here
        optField.attr('value', val);
      });

       // change checkboxes checked status to them values
       $('#panel-options input[type=checkbox]').
             trigger({
                type:"change", set_values: true
            });

      //Handle custom controls
      //Togle options
      if(this.activeControl.control instanceof FDCheckBox) {
        this.optDD.toggleType(true);
      } else if (this.activeControl.control instanceof FDDropDown || this.activeControl.control instanceof FDRadioBox) {
        this.optDD.toggleType(false);
      }

      //Load options for dropdown
      if(this.activeControl.control instanceof FDDropDown ||
        this.activeControl.control instanceof FDCheckBox || this.activeControl.control instanceof FDRadioBox) {
        this.optDD.load(this.activeControl.control.options.base.options, this.activeControl.control.options.base.selected);
      }

      //Load options for datasource components
      if(this.activeControl.control instanceof FDDSControl) {
        //Populate domain info
        this.loadDomain();
        //Load SDTM data
        this.optDS.load(this.activeControl.control.options.base.cdash, this.activeControl.control.options.base.selected);
      }

      //attach dictionary editors popups
      $('.dict-icon').overlay({
          api:true,
          onBeforeLoad: function() {

			// grab wrapper element inside content
			var wrap = this.getOverlay().find(".content");

			// load the page specified in the trigger to iframe src
                        //wrap.attr("src", this.getTrigger().attr("href"));

                        //wrap.load(this.getTrigger().attr("href"));
                        wrap.load(Routes.indexFdPath());
          }
      });

      //Hide bo field selected message & show option block
      $('#noFieldSlection').hide();
      $('#optionGroup').show();
    } else {
      this.activeControl = {}
      $('#noFieldSlection').show();
      $('#optionGroup').hide();
    }
  },

  //This is called only from domainselect, not in case of form population
  setDomain: function(domain, cdash) {
    //Load corresponding SDTM
    if(cdash.sdtm_category_id) {
      this.optDS.load(cdash.sdtm_category_id, []);
    } else {
      this.optDS.load(-1, []);
    }
    //Save domain objects into temporary data storadge
    $(this.activeControl.control.controlBlock).data('fd.tmp.domain', {'domain': domain, 'cdash':cdash });
    this.updateDomainView(true);
  },

  //Move temporaty domain selection into actual control data
  saveDomain: function() {
    //Move temporary to main data info if any
    var tmp = $(this.activeControl.control.controlBlock).data('fd.tmp.domain');
    //Make sure that there is any domain
    if(tmp) {
      $(this.activeControl.control.controlBlock).data('fd.domain', tmp.domain);
      $(this.activeControl.control.controlBlock).data('fd.cdash', tmp.cdash);
      $(this.activeControl.control.controlBlock).data('fd.tmp.domain', null);
    }
  },

  updateDomainView: function(temporary) {
    temporary = temporary || false;
    if(temporary) {
      var tmp = $(this.activeControl.control.controlBlock).data('fd.tmp.domain');
      var domain = tmp.domain;
      var cdash  = tmp.cdash;
    } else {
      var domain = $(this.activeControl.control.controlBlock).data('fd.domain');
      var cdash  = $(this.activeControl.control.controlBlock).data('fd.cdash');
      //Lazy load domain for control with domain id
      if(!domain && this.activeControl.control.options.base.domain_id) {
        domain = FDDomainSelect.getDomainById(this.activeControl.control.options.base.domain_id);
      }

      if(!cdash && this.activeControl.control.options.base.cdash_question_id){
        cdash = {id:-1};
        var url = Routes.adminDomainCdashQuestionPath(this.activeControl.control.options.base.domain_id, this.activeControl.control.options.base.cdash_question_id, {format: 'json'});
        cdash = FDDomainSelect.getCdashData(url, function(data){}, false);
      }
    }
    if(domain) {
      $('#domain-info').show();
      $('#fdomainselect').text('Change Domain & CDASH');

       //Update info view on pane
      $('#fd-domain').html('').
              text(domain.name+'('+ domain.code+')').
              append(
                 $('<img>',{src:'/images/icons/question-frame.png'}).attr('title', domain.description)
              );
      //TODO: Init tooltip
      //Update values if new domain/cdash is chosen

      //Update CDASH text
      if(cdash){
        //Did the domain really changed?
        if(this.activeControl.control.options.base.domain_id != domain.id) {
          $('#opt-label').val(cdash.data_collection_field);
        }
        var text = cdash.data_collection_field;
        //Check is there any corresponding sdtm
        if($.isPlainObject(cdash.sdtm_category)) {
          text = text + ' ('+cdash.sdtm_category.code+')';
        }
        $('#fd-cdash').html('').text(text);
	//Update label only if CDASH and SDTM is changed
        if(this.activeControl.control.options.base.cdash_question_id != cdash.id){
          $('#opt-description').val(cdash.completion_instructions);
        }
        //Set CDASH id
        $('#opt-cdash_question_id').val(cdash.id);
      }
      
      //Set id
      $('#opt-domain_id').val(domain.id);
      
    } else {
      //Hide domain block
      $('#domain-info').hide();
      $('#fdomainselect').text('Select Domain & CDASH');
      $('#opt-domain_id').val("-1");
      $('#opt-cdash_question_id').val("-1");
    }
  },

  loadDomain: function() {
    this.updateDomainView(false);
  },

  //TODO: Refactor this appendix
  _cdashLoaded: function(data) {
    //Set CDASH
    $(this.activeControl.control.controlBlock).data('fd.cdash',data);
    this.updateDomainView(false);
  },

  _collectOptions:function(){
    var options = {};
    var controlOptions = this.controls[this.activeControl.id].options;

    //Collect all options avaliable for control
    $.each(controlOptions.base, function(name, val) {
      options[name] = $('*[fdfield="'+name+'"]').val();
    });
    //Get Multiple Options
    if(this.controls[this.activeControl.id] instanceof FDDropDown ||
        this.activeControl.control instanceof FDCheckBox || this.activeControl.control instanceof FDRadioBox) {
      options = $.extend({},options, this.optDD.getData());
    }

    //Get DS Options
    if(this.activeControl.control instanceof FDDSControl) {
      //Update controls domain info
      //NOTE!!! This should be only before actual options save, need to resolve this dep
      this.saveDomain();
      //Save domain
      options = $.extend({},options, this.optDS.getData());
    }
    return options;
  },

  _bindSidebar: function() {
    $('#panel-options #ptabs a').click(function(e) {
      e.preventDefault();
      var tabId = $(this).parent().attr('id');
      FDController._activateTab(tabId);
      FDController.onTabChange(tabId)
    });
  },

  //Activate tab by id
  _activateTab: function(tabId) {
    $('#panel-options').attr('class', tabId);
    $('.sidebar-container').hide();
    $('#'+tabId+'-container').show();
    this.activeTab = tabId;
  },

  //Get selected component
  getActive:function() {
    return this.activeControl;
  },

  onTabChange: function(tabId) {
    //Select form header on tab activate
    this.activateFormOptions(tabId == 'fdf');
    //Remember active tab
    this.activeTab = tabId;
  },

  onControlsChange: function() {
   if($.isEmptyObject(this.controls)) {
      //Show no fields pane
      $('#nofields').show();
    } else {
      //Hide no fields notice
      $('#nofields').hide();
    }
  },

  onNofieldsNoticeClick: function(e) {
    if(this.activeTab != 'fdc') {
      this._activateTab('fdc');
    } else {
      $('#fdc-container').effect('shake',{'direction':'left', 'distance':'6'}, 100);
    }
  }

});
