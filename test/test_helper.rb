ENV["RAILS_ENV"] = "test"
require File.join(File.dirname(__FILE__), 'rails_app', 'config', 'environment')

require 'test_help'
require 'mocha'
require File.join(File.dirname(__FILE__), '..', 'lib', 'devise', 'models', 'invitable')
require File.join(File.dirname(__FILE__), '..', 'lib', 'devise', 'controllers', 'url_helpers')
ActionView::Base.send :include, Devise::Controllers::UrlHelpers

path = File.join(File.dirname(__FILE__), '..', 'app', 'views')
ActionController::Base.view_paths << path
DeviseMailer.view_paths << path

ActionMailer::Base.delivery_method = :test
ActionMailer::Base.perform_deliveries = false
ActionMailer::Base.default_url_options[:host] = 'test.com'

ActiveRecord::Migration.verbose = false
ActiveRecord::Base.logger = Logger.new(nil)

ActiveRecord::Schema.define(:version => 1) do
  create_table :users do |t|
    t.authenticatable :null => true
    t.string :username
    t.confirmable
    t.invitable

    t.timestamps
  end
end
class User
  devise :authenticatable, :invitable
end
ActionController::Routing::Routes.draw do |map|
  map.devise_for :users
end
require File.join(File.dirname(__FILE__), '..', 'app', 'controllers', 'invitations_controller')

class ActiveSupport::TestCase
  self.use_transactional_fixtures = true
  self.use_instantiated_fixtures  = false
end