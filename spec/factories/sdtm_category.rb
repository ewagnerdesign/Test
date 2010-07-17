Factory.sequence :sdtm_category_code do |n|
  "__sdtm_category_#{(10000 - n).to_s.rjust(5, '0')}_code"
end

Factory.sequence :sdtm_category_name do |n|
  "__sdtm_category_#{(10000 - n).to_s.rjust(5, '0')}_name"
end

Factory.define :sdtm_category  do |sc|
  sc.code { Factory.next(:sdtm_category_code) }
  sc.extensible 1
  sc.name { Factory.next(:sdtm_category_name) }
  sc.submission_value "submission_value"
  sc.cdisc_preferred_term "cdisc_preferred_term"
  sc.synonyms "synonyms"
  sc.definition "definition"
  sc.nci_preferred_term "nci_preferred_term"
  sc.read_only 0
end

Factory.define :sdtm_category_read_only, :parent => :sdtm_category do |sc|
  sc.read_only 1
end
