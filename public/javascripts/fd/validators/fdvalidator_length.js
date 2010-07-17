FDValidator.Length  = $.inherit(FDValidator, {

  default_options: {
      headTitle: "Length",
      base: {
        minimum: "",
        maximum: "",
        message: 'Length should be between {arg1} and {arg2}'
      },
      titleElements:{
        minimum: "min",
        maximum: "max"
      }
  },

  _buildBody: function() {
    return $([
      this.labelTag("minimum", "Minimum"),
      this.textFieldTag("minimum", this._util.prepareInt),
      '<br>',
      this.labelTag("maximum", "Maximum"),
      this.textFieldTag("maximum", this._util.prepareInt)
    ]);
  }
                                    
}, {
  available_controls: ['input', 'textarea', 'dstextarea', 'dsinputtext']
});

