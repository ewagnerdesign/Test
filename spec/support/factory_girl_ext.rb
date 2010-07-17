class Factory
  class Proxy #:nodoc:
    class LoadOrCreate < Create #:nodoc:
      def initialize(klass)
        @instance = Factory.prepared_instance || super
      end

      def associate(name, factory, attributes)
        set(name, Factory.load_or_create(factory, attributes))
      end

      def association(factory, overrides = {})
        Factory.load_or_create(factory, overrides)
      end
    end
  end

  def self.find_by_overrides(klass, overrides = {})
    klass.find :first,
       :conditions => (overrides.inject({}) do |res, (key, value)|
          if value && value.is_a?(ActiveRecord::Base)
            res[key.to_s.foreign_key] =  value.id
          else
            res[key] = value
          end
          res
        end)
  end
  
  def self.prepared_instance
    return @prepared_instance
  end

  def self.load_or_create(name, overrides = {})
    factory = factory_by_name(name)
    @prepared_instance = self.find_by_overrides(factory.build_class, overrides)
    factory.run(Proxy::LoadOrCreate, overrides)
  end
end
