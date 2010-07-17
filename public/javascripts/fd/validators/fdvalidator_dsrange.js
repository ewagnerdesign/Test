FDValidator.DSRange = $.inherit(FDValidator.DSBase, {

  default_options: {
    headTitle: "Range",
    base: {
      childs:{},
      message: "Value should be between {arg1} and {arg2}."
    },
    default_child: {
       maximum: "",  minimum: ""
     }
  },

  _buildOptionItem: function(index, title) {
    return $('<li>').
      append(
          $('<h4>').text(title),
          this.labelTag( ['childs', index, 'minimum'], 'Minimum' ),
          this.textFieldTag(['childs', index,"minimum"], this._util.prepareFloat),
          '<br>',
           this.labelTag( ['childs', index, 'maximum'], 'Maximum' ),
           this.textFieldTag(['childs',index,"maximum"], this._util.prepareFloat)
    );
  }

}, {
  available_controls: ['dsinput']
});
