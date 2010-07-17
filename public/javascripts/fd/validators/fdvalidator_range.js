FDValidator.Range  = $.inherit(FDValidator, {

  default_options: {
      headTitle: "Range",
      base: {
        minimum: "",
        maximum: "",
        message: "Value should be between {arg1} and {arg2}."
      }
  },

  _buildBody: function() {
    return $([
      this.labelTag("minimum", "Minimum"),
      this.textFieldTag("minimum", this._util.prepareFloat),
      '<br>',
      this.labelTag("maximum", "Maximum"),
      this.textFieldTag("maximum", this._util.prepareFloat)
    ]);
  }

}, {
  available_controls: ['input', 'textarea', 'dstextarea', 'dsinputtext']
});
