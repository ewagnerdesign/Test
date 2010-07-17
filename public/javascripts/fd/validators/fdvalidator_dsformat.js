FDValidator.DSFormat = $.inherit(FDValidator.DSBase, {

  default_options : {
    headTitle: "Format",
    base: {
      childs:{},
      message: "Invalid format!"
    },
    default_child: {
       formatType: "digits"
    }
  },

  _buildOptionItem: function(index, title) {
    var itemName = ['childs',index,'formatType']
    return $('<li>').
      append(
          $('<h4>').text(title),
          this.labelTag( itemName, 'Type' ),
          this.selectFieldTag( itemName, FDValidator.Format.types )
      );
  }

}, {
  available_controls: ['dsinput']
});
