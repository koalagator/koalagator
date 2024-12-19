# frozen_string_literal: true

module StripWhitespace
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def strip_whitespace!(*fields)
      before_validation do |record|
        fields.each do |field|
          setter = :"#{field}="
          value = record.send(field.to_sym)
          if value.respond_to?(:strip) && record.respond_to?(setter)
            record.send(setter, value.strip)
          end
        end
      end
    end
  end
end
