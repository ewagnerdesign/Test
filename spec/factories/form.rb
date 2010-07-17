Factory.define :form do |t|
  t.sequence(:name){ |n| "name#{n}" }
  t.metadata File.read(File.dirname(__FILE__) + "/../fixtures/form_base.json")
end

Factory.define :form_with_parent, :parent => :form do |t|
  t.parent {|p| p.association(:form)}
end

Factory.define :form_validator, :parent => :form do |t|
  t.metadata File.read("#{Rails.root}/spec/fixtures/form_validator.json")
end

Factory.define :form_metadata do |t|
  t.sequence(:name) { |n| "name#{n}" }
  t.metadata File.read(File.dirname(__FILE__) + "/../fixtures/form_base.json")
end

Factory.define :form_cumulative, :parent => :form do |t|
  t.cumulative true
end
