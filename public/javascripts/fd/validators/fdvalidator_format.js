FDValidator.Format = $.inherit(FDValidator, {

  default_options : {
    headTitle: "Format",
    base: {
      formatType: "email",
      message: "Not valid format!"
    }
  },

  _buildBody: function() {
    return $([
      this.labelTag("formatType", "Type"),
      this.selectFieldTag('formatType', FDValidator.Format.types)
    ]);
  }

}, {
  available_controls: ['input', 'textarea', 'dstextarea', 'dsinputtext'],

  types: {
    digit: "Digits",
    numeric: "Numeric",
    words: "words & digits",
    email: "Email"
  }

});


