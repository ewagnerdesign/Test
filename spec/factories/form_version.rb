Factory.define :form_version do |t|
  t.form { |a| a.association :form }
  t.sequence(:name) { |n| "name#{n}" }
  t.metadata File.read(File.dirname(__FILE__) + "/../fixtures/form_base.json")
  t.html "html"
end

Factory.define :form_version_validator, :parent => :form_version do |t|
  t.metadata File.read("#{Rails.root}/spec/fixtures/form_validator.json")
end

Factory.define :form_version_metadata do |t|
  t.sequence(:name) { |n| "name#{n}" }
  t.metadata File.read(File.dirname(__FILE__) + "/../fixtures/form_base.json")
  t.html "html"
end

