require 'rubygems'
require 'spork'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'
  require 'capybara/rspec'
  require 'database_cleaner'

  RSpec.configure do |config|
    config.infer_base_class_for_anonymous_controllers = false

    config.order = 'random'
    config.include Devise::TestHelpers, :type => :controller

    #Database cleaner
    config.before(:suite) do
      DatabaseCleaner.strategy = :truncation
    end

    config.before(:each) do
      DatabaseCleaner.start
    end

    config.after(:each) do
      DatabaseCleaner.clean
    end
  end
end

Spork.each_run do
  FactoryGirl.reload
  I18n.backend.load_translations

  Dir["#{Rails.root}/app/**/*.rb"].each {|file| load file }
  load "#{Rails.root}/config/routes.rb"
end

RSpec.configure do |config|
  config.include Capybara::DSL
end