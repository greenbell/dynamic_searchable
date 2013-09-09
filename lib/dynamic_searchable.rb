# coding: utf-8
require 'active_support'

module DynamicSearchable
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

  autoload :ActiveRecord, 'dynamic_searchable/active_record'
end

ActiveSupport.on_load(:active_record) do
  ActiveRecord::Base.class_eval { include DynamicSearchable::ActiveRecord }
end
