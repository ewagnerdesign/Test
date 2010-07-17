FDValidator.SelectCount  = $.inherit(FDValidator, {

  default_options: {
      headTitle: "Select Count",
      base: {
        minimum: "",
        maximum: "",
        message: "Number of selected values must be within {arg1} and {arg2}."
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
  available_controls: ['checkbox', 'dscheckbox']
});
