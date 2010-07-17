var FDOptionHelper = $.inherit({

  getOptionsValue: function(valueName){
    return this._findOptionByValueName(valueName)
/*
    var findOption = function(value, options){
      if( $.isArray(value) ){
         var index = value.shift();
         return (value.length==0)? options[index]: findOption(value, options[index]);
      }
      return options[value]
    }

    return findOption(
      (typeof valueName =="string")? [valueName]: $.extend([],valueName),
      this.options.base
    )
*/
  },

  _findOptionByValueName: function(valueName, newValue) {
    var findOption = function(value, options){
      if( $.isArray(value) ){
         var index = value.shift();
         return (value.length==0)? [options, index]: findOption(value, options[index]);
      }
      return [options, index]
    }

    var result = findOption(
      (typeof valueName =="string")? [valueName]: $.extend([],valueName),
      this.options.base
    )
    var option = result[0], key= result[1]
    if( typeof newValue == "undefined"){
      return option[key]
    } else {
      option[key] = newValue;
      return true
    }
  },

  setOptionsValue: function(valueName, value){
    if(value==null){
      return false;
    }
    this._findOptionByValueName(valueName, value)
  }

});
