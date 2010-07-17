class StudySiteUser < ActiveRecord::Base
  belongs_to :study
  belongs_to :site_user, :counter_cache=>true

  has_many :role_study_site_users, :dependent => :destroy
  has_many :roles, :through => :role_study_site_users

  validates_presence_of :study_id
  validates_presence_of :site_user_id


  named_scope :study_site_user, Proc do |study_id, site_id, user_id|
     {
       :joins=>:site_user,
           :conditions=>{
               :study_id=>study_id,
               :site_users => { :site_id=>site_id, :user_id=> user_id }
           },
        :limit=>1
      }
  end

end

