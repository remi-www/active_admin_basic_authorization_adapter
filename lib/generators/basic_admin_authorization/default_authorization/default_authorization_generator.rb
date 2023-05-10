# frozen_string_literal: true

module BasicAdminAuthorization
  module Generators
    class DefaultAuthorizationGenerator < Rails::Generators::Base
      source_root File.expand_path('templates', __dir__)

      def create_authorizations_file
        create_file 'app/admin/authorizations/default_authorization.rb', <<~FILE
          # frozen_string_literal: true

          module ActiveAdmin
            module Authorizations
              class DefaultAuthorization
                def initialize(user, record = nil)
                  @user = user
                  @record = record
                end

                def read
                  false
                end

                def create
                  false
                end

                def update
                  false
                end

                def destroy
                  false
                end
              end
            end
          end
        FILE
      end
    end
  end
end
