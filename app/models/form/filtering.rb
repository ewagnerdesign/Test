class Form
  SEARCH_FIELDS = [:name, :description]

  CRF_LIST_SEARCH_CONDITIONS_FORM_ASSOCIATIONS = {
    :study_id     => "form_study_arm_visits_study_arm_visit_visit_study_id_",
    :study_arm_id => "form_study_arm_visits_study_arm_visit_study_arm_id_",
    :subject_id   => "form_study_arm_visits_study_arm_visit_study_arm_subjects_id_",
    :site_id      => "form_study_arm_visits_study_arm_visit_study_arm_subjects_site_id_",
    :visit_id     => "form_study_arm_visits_study_arm_visit_visit_id_"
  }

  CRF_LIST_SEARCH_CONDITIONS_FORM_INSTANCE_ASSOCIATIONS = {
    :study_id => "subject_study_id_",
    :study_arm_id => "subject_study_arm_id_",
    :subject_id => "subject_id_",
    :visit_id => "visit_id_"
  }

  CRF_LIST_SEARCH_CONDITIONS_INSTANCE_FILTERS = {
    "completed" => "submitted", "with_queries" => "form_field_values_queries_closed_not"
  }

  CRF_LIST_SEARCH_CONDITIONS_OPTIONS = {
    "all_cond" => {
      :order => "visits.study_id, study_arms.id, visits.id, subjects.id",
      :select => "forms.id, visits.id as crf_list_visit_id, subjects.id as crf_list_subject_id"
    },
    "completed" => {
      :order => "subjects.study_id, subjects.study_arm_id, visit_id, subject_id",
      :select => "form_instances.id as crf_list_form_instance_id",
      :group => "crf_list_form_instance_id"
    },
    "with_queries" => {
      :order => "subjects.study_id, subjects.study_arm_id, visit_id, subject_id",
      :select => "form_instances.id as crf_list_form_instance_id",
      :group => "crf_list_form_instance_id"
    }
  }

  def self.crf_list_search(options)
    if options[:show] == "all_cond"
      result = Form.noncumulative_forms.search(get_crf_list_search_conditions(options, true)).
        paginate(Form.get_crf_list_options(options))
    else
      result = FormInstance.search(get_crf_list_search_conditions(options)).
        paginate(Form.get_crf_list_options(options))
    end

    result
  end

  def self.unpack_crf_list_search_results(forms, options)
    result = []
    if options[:show] == "all_cond"
      forms.each do |f|
        visit = Visit.find(f.crf_list_visit_id)
        subject = Subject.find(f.crf_list_subject_id)
        form_instance = f.form_versions.last.form_instances.find_by_subject_id_and_visit_id(subject, visit)
        result << {
          :form => Form.find(f.id),
          :form_instance => form_instance,
          :visit => visit,
          :subject => subject }
      end
    else
      forms.each do |f|
        fi = FormInstance.find(f.crf_list_form_instance_id)
        result << {
          :form => fi.form_version.form,
          :form_instance => fi,
          :visit => fi.visit,
          :subject => fi.subject }
      end
    end

    result
  end

  private

  # search params to find forms list for CRF tab
  def self.get_crf_list_search_conditions(options, for_form = false)
    if for_form
      conditions = {}
      cond_array = CRF_LIST_SEARCH_CONDITIONS_FORM_ASSOCIATIONS
    else
      conditions = { CRF_LIST_SEARCH_CONDITIONS_INSTANCE_FILTERS[options[:show]] => true }
      cond_array = CRF_LIST_SEARCH_CONDITIONS_FORM_INSTANCE_ASSOCIATIONS
    end

    cond_array.each do |k,v|
      search_key = v + ((options[k].zero?) ? "not" : "is")
      conditions.merge!({ search_key => options[k] })
    end

    conditions
  end

  # options to paginate or all called after get_crf_list_search params applied
  def self.get_crf_list_options(options)
    search_options = CRF_LIST_SEARCH_CONDITIONS_OPTIONS[options[:show]]
    search_options.merge(:page => options[:page])
  end
end

