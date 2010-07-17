module Admin::RolesHelper
  def category_name(category)
    case category
      when Role::SITE_LEVEL
        "Site-Level"
      when Role::STUDY_LEVEL
        "Study-Level"
      when Role::SYSTEM_LEVEL
        "System-Level"
      when Role::SITE_STUDY_LEVEL
        'Site-Study-Level'
    end
  end
end
