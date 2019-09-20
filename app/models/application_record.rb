class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.effectless_scope(name, body)
    singleton_class.define_method(name) do |arg|
      if arg.present?
        body.call(arg)
      else
        all
      end
    end
  end
end
