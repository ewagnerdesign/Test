Factory.sequence :cdash_question_variable_name do |n|
  "__cdash_question_#{n}_variable_name"
end

Factory.define :cdash_question do |cq|
  cq.data_collection_field "data_collection_field"
  cq.domain {|d| d.association(:domain) }
  cq.number 1
  cq.variable_name { Factory.next(:cdash_question_variable_name) }
  cq.definition "definition"
  cq.completion_instructions "completion_instructions"
  cq.sponsor_info "sponsor_info"
  cq.core "core"
  cq.sdtm_category {|sc| sc.association(:sdtm_category) }

end
