Factory.sequence :sdtm_answer_code do |n|
  "__sdtm_answer_#{n}_code"
end

Factory.define :sdtm_answer  do |sa|
  sa.code { Factory.next(:sdtm_answer_code) }
  sa.submission_value "submission_value"
  sa.cdisc_preferred_term "cdisc_preferred_term"
  sa.synonyms "synonyms"
  sa.definition "definition"
  sa.nci_preferred_term "nci_preferred_term"
  sa.read_only 1
  sa.sdtm_category {|s| s.association(:sdtm_category)}
end
