require 'spec_helper'

describe OldPassword do
  #user
  it { should have_db_column(:user_id).of_type(:integer).with_options(:null => false )}
  it { should validate_presence_of(:user)}
  it { should belong_to(:user) }
end
