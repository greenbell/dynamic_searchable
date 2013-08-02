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
      if searchable_scopes.include?(param.first.to_sym)
        base.send(param.first, param.last)
      else
        base
      end
    end
  end

  def scope_with_dynamic_searchable(name, options={}, &block)
    self.searchable_scopes.push name.to_sym
    scope_without_dynamic_searchable name, options, &block
  end
end
