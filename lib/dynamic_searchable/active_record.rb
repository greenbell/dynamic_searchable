module DynamicSearchable
  module ActiveRecord
    extend ActiveSupport::Concern

    included do
      class_attribute :searchable_scopes
      self.searchable_scopes ||= []
      class << self
        alias_method_chain :scope, :dynamic_searchable
      end
    end

    module ClassMethods
      def scope_with_dynamic_searchable(name, options={}, &block)
        self.searchable_scopes.push(name.to_sym) unless searchable_scopes.include?(name.to_sym)
        scope_without_dynamic_searchable name, options, &block
      end
    end
  end
end
