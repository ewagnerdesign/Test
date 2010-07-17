require 'spec_helper'

describe PermissionRole do
  #permission
  it { should have_db_column(:permission_id).of_type(:integer).with_options(:null => false)}
  it { should validate_presence_of(:permission_id)}
  it { should belong_to(:permission) }
  
  #role
  it { should have_db_column(:role_id).of_type(:integer).with_options(:null => false)}
  it { should validate_presence_of(:role_id)}
  it { should belong_to(:role) }

  it { should have_db_index([:permission_id, :role_id]).unique(true) }
end
