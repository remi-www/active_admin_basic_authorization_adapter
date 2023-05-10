# frozen_string_literal: true

require 'rack'
require 'rack/test'
require 'rack/logger'
require 'pry'
require 'active_support'
require 'active_support/core_ext'
require 'active_model/naming'
require 'rails'
require 'rails/rack'
require 'active_admin/authorization_adapter'

module ActiveRecord
  class Base
    def initialize
      'Active Record Base'
    end
  end
end

class NoComment < ActiveRecord::Base
  extend ActiveModel::Naming
end

class Comment < ActiveRecord::Base
  extend ActiveModel::Naming
  attr_accessor :is_authorized

  def initialize(is_authorized: false)
    @is_authorized = is_authorized
  end
end

class User < ActiveRecord::Base
  extend ActiveModel::Naming
  attr_accessor :admin

  def initialize(admin: false)
    @admin = admin
  end
end

class ARandomClass
  def initialize
    'A random class'
  end
end

class AClass
  def initialize
    'A class'
  end
end
