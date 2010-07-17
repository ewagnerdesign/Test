module Admin::FormHelper
  def swap_from_options(form_options)
    form_options.inject({}) {|res, val| res[val[1]] = val[0]; res}
  end
end
