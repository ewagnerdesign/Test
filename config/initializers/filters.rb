class << ActiveRecord::Base
  def filter(filters = {}, exclusive = false)
    scope = scoped({})
    warn "The model has no Filters defined" unless self.const_defined?(:FILTERS)
    if (self.const_defined?(:FILTERS) && filters.kind_of?(Hash))
      filters.each_pair do |filter, params|
        filter = filter.to_sym
        warn "There is no #{filter} named scope included in the allowed filters list" unless self::FILTERS.include?(filter)
        result = scope.send(filter, params) if self::FILTERS.include?(filter) && scope.respond_to?(filter)
        scope = result if result.class == ActiveRecord::NamedScope::Scope
      end
    end
    scope
  end
end
