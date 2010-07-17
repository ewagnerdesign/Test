var FDViewHelper = $.inherit(FDOptionHelper,{

  /**
  * Helpers
  */
  _util:{

    getElementValue: function(el) {
      var val=null;
      if( el!=null ){
        val = el.is(":checkbox")? el.is(":checked"): el.val();
      }
      return val
    },

    prepareInt: function(value){
      if(value=="" || parseInt(value).toString()=='NaN'){
        return "";
      }
     return parseInt(value);
    },

    prepareFloat: function(value){
      if(value=="" || isNaN(parseFloat(value)) || !isFinite(value) ){
        return "";
      }
     return parseFloat(value);
    },
    prepareString: function(value){
      // TODO: implement this, for XSS attack
     return value;
    },

    prepareMessage: function(message, values){
      // TODO: create simple template engine
//       return message.toString().template(values);
       return message.toString()
    }
  },

  labelTag: function(valueName, title){
    return $("<label>").
            attr("for", this.domId(valueName) ).
            text( title );
  },

  textFieldTag: function(valueName, funcPrepareValue) {
    var value = this.getOptionsValue(valueName);
    return $("<input type='input'>").
              attr("id", this.domId(valueName) ).
              attr("fdfield", this.fdfieldName(valueName) ).
              val(
                funcPrepareValue? funcPrepareValue(value): value
              );
  },

  selectFieldTag: function(valueName, options, funcPrepareValue) {
    var value = this.getOptionsValue(valueName);
    var el = $("<select>").
              attr("id", this.domId(valueName) ).
              attr("fdfield", this.fdfieldName(valueName) );

    $.each(options, function(key, val) {
        el.append(
            $("<option></option>").attr("value",key).text(val)
        );
    });
    el.val( funcPrepareValue? funcPrepareValue(value): value );
    return el;
  },

  checkboxFieldTag: function(valueName) {
    var value = this.getOptionsValue(valueName);
    return $('<input type="checkbox">').
              attr("id", this.domId(valueName) ).
              attr("fdfield", this.fdfieldName(valueName) ).
              attr("value", value.toString() ).
              attr("checked", value );
  },

  domId: function(valueName) {
    if( $.isArray(valueName) ){
      valueName=valueName.join('-');
    }
    return this.elId+"_"+valueName;
  },

  fdfieldName: function(valueName) {
    if( $.isArray(valueName) ){
      valueName=valueName.join('_');
    }
    return valueName;
  },

  fdFiledValue: function(varName){
     var element = this.element.find('[fdfield="'+this.fdfieldName(varName)+'"]');
     if( element.length==0 ){
//       throw "Can't find element with fdfield name '"+varName+"'";
       element = null;
     }
    return element;
  }

});
