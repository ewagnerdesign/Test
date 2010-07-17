module EcrfsHelper
#def form_column(record)
# link_to "Edit custom fields", :controller=> "ecrfs", :action => "form", :id => record.id
#end
#end

  def customform_form_column(record, input_name)
    record.html
  end

  def ecrf_form_link(form, ecrf, subject, visit)
    link_to h(form.name), (ecrf.nil?)? new_ecrf_path(:form_id => form.id, :subject_id => subject.id, :visit_id => visit.id) : ecrf_path(ecrf)
  end

  def ecrf_status_name(ecrf)
    if ecrf.nil?
      "Empty"
    else
      (ecrf.submitted?) ? "Submitted" : "Saved"
    end
  end

end
