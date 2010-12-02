# coding: utf-8

module DynamicSearchable
  def search(params = {})
    return self.scoped if params.nil?
    params.reject{|k,v|v.blank?}.to_a.inject(self.scoped) do |base,param|
      base.send(param.first, param.last)
    end
  end
end
