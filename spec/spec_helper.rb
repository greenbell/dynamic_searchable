# coding: utf-8

require 'rubygems'
require 'bundler'

ENV['BUNDLER_GEMFILE'] = File.expand_path("../../Gemfile", __FILE__)
Bundler.setup
Bundler.require

require 'active_record'
require 'database_cleaner'

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")
ActiveRecord::Schema.verbose = false
ActiveRecord::Schema.define(:version => 1) do
  create_table :articles do |t|
    t.string :subject
    t.text   :body
  end
end

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start

    class ::Article < ActiveRecord::Base
      scope :by_id, lambda{ |num| where(:id => num) }
      extend DynamicSearchable

      scope :by_subject, lambda { |str| where("subject like ?", "%#{str}%") }
      scope :by_body,    lambda { |str| where("body like ?", "%#{str}%") }
    end
  end

  config.after(:each) do
    Object.send(:remove_const, :Article)
    DatabaseCleaner.clean
  end
end
