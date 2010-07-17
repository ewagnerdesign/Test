
FDValidator.DSExclusion = $.inherit(FDValidator.DSCustomParamsBase, {

  default_options: {
    headTitle: "Exclusion",
    base: {
      childs: {},
      message: 'Value should be exclusion in {args}'
    },
    default_child: {
       params: {},
       count: 0
     }
  },

  default_param: "",

  _buildParamItemControl: function(childId, paramId) {
    return this.textFieldTag(['childs',childId,"params",paramId], this._util.prepareString)
  }


}, {
  available_controls: ['dsinput']
});
