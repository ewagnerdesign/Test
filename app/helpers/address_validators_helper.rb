module AddressValidatorsHelper
  module Address
    def self.included(base)
      base.instance_eval do
        validates_presence_of :address_1
        validates_length_of :address_1, :maximum=>255
        validates_length_of :address_2, :maximum=>255, :allow_blank => true
        validates_presence_of :city
        validates_length_of :city, :maximum=>45
        validates_presence_of :state_cd
        validates_length_of :state_cd, :in => 2..2
        validates_presence_of :zip
        validates_length_of :zip, :in => 5..5

        define_method (:compact_phones) { 
          self.phone = phone.gsub(/[^0-9]/, "") unless phone.nil?
          self.fax = fax.gsub(/[^0-9]/, "") unless fax.nil?
          self.ext = ext.gsub(/[^0-9]/, "") unless ext.nil?
        }
      end
    end
  end
end
