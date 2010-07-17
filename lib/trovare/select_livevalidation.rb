module ActionView
  module Helpers
    module FormOptionsHelper

      define_method "select_with_live_validations" do |object_name, method, choices, options, html_options|
        live = options.delete(:live)
        live = ActionView::live_validations if live.nil?
        send("select_without_live_validations", object_name, method, choices, options, html_options) +
          ( live ? live_validations_for(object_name, method) : '' )
      end
      alias_method_chain :select, :live_validations

      def live_validation(object_name, method)
        if validations = self.instance_variable_get("@#{object_name.to_s}").class.live_validations[method.to_sym] rescue false
          field_name = "#{object_name}_#{method}"
          initialize_validator(field_name) +
          validations.map do |type, configuration|
            live_validation_code(field_name, type, configuration)
          end.join(';') +
          if validations.include? :numericality
            ";$('##{field_name}').numeric();"
          else
            ''
          end
        else
          ''
        end
      end



      def initialize_validator(field_name)
        "var #{field_name} = new LiveValidation('#{field_name}', #{ActiveRecord::Validations::VALIDATION_INIT_OPTIONS.to_json});"
      end

      def live_validation_code(field_name, type, configuration)
        "#{field_name}.add(#{ActiveRecord::Validations::NEW_VALIDATION_METHODS[type]}" + ( configuration ? ", #{configuration.to_json}" : '') + ')'
      end

    end
  end
end
