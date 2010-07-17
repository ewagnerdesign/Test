# Permissions

# Site-level permissions:
Permission.seed(:name) { |s|
  s.name = 'Maintain Visits'
  s.description = 'Maintain Visits'
  s.category = Role::SITE_LEVEL
}

Permission.seed(:name) { |s|
  s.name = 'Approves Data as Final'
  s.description = 'Approves Data as Final'
  s.category = Role::SITE_LEVEL
}

Permission.seed(:name) { |s|
  s.name = 'Maintain Patients (Site)'
  s.description = 'Maintain Patients (Site)'
  s.category = Role::SITE_LEVEL
}

Permission.seed(:name) { |s|
  s.name = 'Answer Queries'
  s.description = 'Answer Queries'
  s.category = Role::SITE_LEVEL
}

Permission.seed(:name) { |s|
  s.name = 'Add user'
  s.description = 'Maintain Password Policies'
  s.category = Role::SITE_LEVEL
}

Permission.seed(:name) { |s|
  s.name = 'Delete user'
  s.description = 'Delete User or remove it from study '
  s.category = Role::SITE_LEVEL
}

Permission.seed(:name) { |s|
  s.name = 'Add site user'
  s.description = 'add site user'
  s.category = Role::SITE_LEVEL
}


# Study-level permissions:
Permission.seed(:name) { |s|
  s.name = 'View Reports'
  s.description = 'View Reports'
  s.category = Role::STUDY_LEVEL
}

Permission.seed(:name) { |s|
  s.name = 'Generate Reports'
  s.description = 'Generate Reports'
  s.category = Role::STUDY_LEVEL
}

Permission.seed(:name) { |s|
  s.name = 'Export Data'
  s.description = 'Export Data'
  s.category = Role::STUDY_LEVEL
}

Permission.seed(:name) { |s|
  s.name = 'View All Data'
  s.description = 'View All Data'
  s.category = Role::STUDY_LEVEL
}

Permission.seed(:name) { |s|
  s.name = 'Query Data'
  s.description = 'Query Data'
  s.category = Role::STUDY_LEVEL
}

Permission.seed(:name) { |s|
  s.name = 'Mark Data as Monitored'
  s.description = 'Mark Data as Monitored'
  s.category = Role::STUDY_LEVEL
}

Permission.seed(:name) { |s|
  s.name = 'Reports - View Site Progress'
  s.description = 'Reports - View Site Progress'
  s.category = Role::STUDY_LEVEL
}

Permission.seed(:name) { |s|
  s.name = 'Reports - Enrollment Reports'
  s.description = 'Reports - Enrollment Reports'
  s.category = Role::STUDY_LEVEL
}

Permission.seed(:name) { |s|
  s.name = 'View Schedules (Patients)'
  s.description = 'View Schedules (Patients)'
  s.category = Role::STUDY_LEVEL
}

Permission.seed(:name) { |s|
  s.name = 'Reports - CRA Activity'
  s.description = 'Reports - CRA Activity'
  s.category = Role::STUDY_LEVEL
}

Permission.seed(:name) { |s|
  s.name = 'Codes Data'
  s.description = 'Codes Data'
  s.category = Role::STUDY_LEVEL
}

Permission.seed(:name) { |s|
  s.name = 'Lock Database'
  s.description = 'Lock Database'
  s.category = Role::STUDY_LEVEL
}

Permission.seed(:name) { |s|
  s.name = 'Maintain Studies'
  s.description = 'Maintain Studies'
  s.category = Role::STUDY_LEVEL
}

Permission.seed(:name) { |s|
  s.name = 'Maintain Site'
  s.description = 'Maintain Site'
  s.category = Role::STUDY_LEVEL
}

Permission.seed(:name) { |s|
  s.name = 'Maintain CRF Schedules'
  s.description = 'Maintain CRF Schedules'
  s.category = Role::STUDY_LEVEL
}

Permission.seed(:name) { |s|
  s.name = 'Add CRF''s'
  s.description = 'Add CRF''s'
  s.category = Role::STUDY_LEVEL
}

Permission.seed(:name) { |s|
  s.name = 'Add Custom Fields'
  s.description = 'Add Custom Fields'
  s.category = Role::STUDY_LEVEL
}

Permission.seed(:name) { |s|
  s.name = 'Add CDASH/SDTM Data'
  s.description = 'Add CDASH/SDTM Data'
  s.category = Role::STUDY_LEVEL
}

#System-level permissions:
Permission.seed(:name) { |s|
  s.name = 'Add Roles'
  s.description = 'Add Roles'
  s.category = Role::SYSTEM_LEVEL
}

Permission.seed(:name) { |s|
  s.name = 'Delete Roles'
  s.description = 'Delete Roles'
  s.category = Role::SYSTEM_LEVEL
}

Permission.seed(:name) { |s|
  s.name = 'Monitor system for security (access logs/failed attempts)'
  s.description = 'Monitor system for security (access logs/failed attempts)'
  s.category = Role::SYSTEM_LEVEL
}

Permission.seed(:name) { |s|
  s.name = 'View Audit Logs/Reports'
  s.description = 'View Audit Logs/Reports'
  s.category = Role::SYSTEM_LEVEL
}

Permission.seed(:name) { |s|
  s.name = 'View Schedules (Patients)'
  s.description = 'View Schedules (Patients)'
  s.category = Role::SYSTEM_LEVEL
}

Permission.seed(:name) { |s|
  s.name = 'Maintain Password Policies'
  s.description = 'Maintain Password Policies'
  s.category = Role::SYSTEM_LEVEL
}


