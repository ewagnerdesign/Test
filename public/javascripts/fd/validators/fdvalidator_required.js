FDValidator.Required  = $.inherit(FDValidator, {

  default_options: {
      headTitle: "Required",
      base: {
        message: 'This field is required'
      }
  }
    

}, {
  available_controls: [
    'input', 'textarea', 'dropdown', 'dsdropdown',
    'radiobox', 'file', 'dateinput',
    'dsradiobox', 'dsinput', 'dstextarea', 'dsinputtext',
    'dsradiobox', 'dscheckbox'
  ]
});

