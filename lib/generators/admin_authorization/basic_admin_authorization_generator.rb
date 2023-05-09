# frozen_string_literal: true

class BasicAdminAuthorizationGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('templates', __dir__)
  class_option :admin_type, type: :string, desc: 'Admin type', default: false

  def create_authorizations_file
    authorization = options[:admin_type] || 'false'

    create_file "app/admin/authorizations/#{file_name}_authorization.rb", <<~FILE
      # frozen_string_literal: true

      module ActiveAdmin
        module Authorizations
          class #{class_name}Authorization < DefaultAuthorization
            def read
              #{authorization}
            end

            def create
              #{authorization}
            end

            def update
              #{authorization}
            end

            def destroy
              #{authorization}
            end

            # Add your custom member_actions here
          end
        end
      end
    FILE
  end
end
