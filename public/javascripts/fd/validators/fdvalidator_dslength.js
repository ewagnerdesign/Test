FDValidator.DSLength = $.inherit(FDValidator.DSBase, {
  
  default_options: {
    headTitle: "Length",
    base: {
      childs:{},
      message: 'Length should be between {arg1} and {arg2}'
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
          this.textFieldTag(['childs', index,"minimum"], this._util.prepareInt),
          '<br>',
           this.labelTag( ['childs', index, 'maximum'], 'Maximum' ),
           this.textFieldTag(['childs',index,"maximum"], this._util.prepareInt)
    );
  }

}, {
  available_controls: ['dsinput']
});
