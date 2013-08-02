# coding: utf-8

module DynamicSearchable
  def self.extended(base)
    base.instance_eval do
      class_attribute :searchable_scopes
      self.searchable_scopes ||= []
      class << self
        alias_method_chain :scope, :dynamic_searchable
      end
    end
  end

  def search(params = {})
    return self.scoped if params.nil?
    params.reject{|k,v|v.blank?}.to_a.inject(self.scoped) do |base,param|
      base.send(param.first, param.last) if searchable_scopes.include?(param.first)
    end
  end

  def scope_with_dynamic_searchable(name, options={}, &block)
    self.searchable_scopes.push name
    scope_without_dynamic_searchable name, options, &block
  end
end
