FDValidator.Date  = $.inherit(FDValidator, {

  default_options: {
      headTitle: "Date format",
      base: {
        withoutHolidays: false,
        notFuture: false,
        message: 'Must be a valid data!'
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
  available_controls: ['input', 'textarea']
});

