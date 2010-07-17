
$.getObjectLength = function(obj){
  var size = 0, key;
  for (key in obj) {
    if (obj.hasOwnProperty(key)) size++;
  }
  return size;
}

$.getObjectFirst = function(obj, key){
  var result = []
  $.each(obj, function(index, value) {
    result.push(index)
    result.push(value)
    return false
  });
  return (typeof key=="undefined")? result: result[key];
}

$.prepareObjectToString = function(obj){
  var result=[];
  $.each(obj, function(index, value) {
     result.push( "'"+index.toString()+"'=>'"+value.toString()+"'" )
  });

  return "{"+result.join(', ')+"}";
}


$.fn.extend({
   disableSelection: function(){
      this.each(function(){
        if( $.browser.msie ){
          this.onselectstart = function(){ return false; }
          this.unselectable = "on"
        }
//         $(this).css('-moz-user-select', 'none').css()
         $(this).css('-moz-user-select', '-moz-none').css('-khtml-user-select', 'none')
      })
   },

  enableSelection: function(){
    if( $.browser.msie ){
      this.onselectstart = function(){ return true; }
      this.unselectable = "off"
    }
    $(this).css('-moz-user-select', 'text').css('-khtml-user-select', 'text')
  }

})

$(document).ready(function() {
    $('.unselectable').disableSelection()

})

$.error = function(){
// TODO implement this method
  if(console && console.warn){
    var message = "";
    for(var i=0; i<arguments.length; i++){
         message += arguments[i] + "\n"
    }
    console.warn( message )
  }
}

$.destroyArrayElement = function(value, sourceArray){
   return $.grep(sourceArray, function(val){ return val != value; });
}
