# frozen_string_literal: true

require 'active_admin/authorization_adapter'

class ActiveAdminBasicAuthorizationAdapter < ActiveAdmin::AuthorizationAdapter
  def authorized?(action, subject = nil)
    return unless should_ask_authorization(subject)

    set_record(subject)
    set_authorization_class(subject)
    @authorization_class.new(user, @record).send(action)
  rescue NameError
    begin
      ActiveAdmin::Authorizations::DefaultAuthorization.new(user, @record).send(action)
    rescue StandardError
      false
    end
  end

  def should_ask_authorization(subject)
    subject.is_a?(Class) ||
      subject.instance_of?(ActiveAdmin::Page) ||
      subject.is_a?(ActiveRecord::Base)
  end

  def set_record(subject)
    @record = subject.is_a?(ActiveRecord::Base) ? subject : nil
  end

  def set_authorization_class(subject)
    @author_class_name = if subject.is_a?(ActiveRecord::Base)
                           subject.class.name
                         else
                           subject.name.gsub(' ', '')
                         end
    @authorization_class = "ActiveAdmin::Authorizations::#{@author_class_name}Authorization".constantize
  end
end
