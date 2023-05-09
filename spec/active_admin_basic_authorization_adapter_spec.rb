# frozen_string_literal: true

require 'spec_helper'
require 'active_admin_basic_authorization_adapter'

module ActiveAdmin
  class Page
    attr_reader :name

    def initialize(name)
      @name = name
    end
  end

  module Resource
  end

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

      def default_authorized_method
        true
      end

      def default_unauthorized_method
        false
      end
    end

    class AClassAuthorization < DefaultAuthorization
      def authorized_method
        true
      end

      def unauthorized_method
        false
      end
    end

    class APageAuthorization < DefaultAuthorization
      def authorized_method
        true
      end

      def unauthorized_method
        false
      end

      def admin_only
        @user.admin
      end
    end

    class CommentAuthorization < DefaultAuthorization
      def authorized_method
        true
      end

      def unauthorized_method
        false
      end

      def authorized_record_only
        @record.is_authorized
      end
    end
  end
end

RSpec.describe ActiveAdminBasicAuthorizationAdapter do
  describe '#authorized?' do
    let(:admin_user) { User.new(admin: true) }
    let(:not_admin_user) { User.new(admin: false) }

    context 'when the subject is neither a class nor an active_admin_page nor an active record class' do
      let(:resource) { ActiveAdmin::Page.new(name: 'A Page') }
      let(:active_admin_basic_authorization_adapter) do
        described_class.new(resource, admin_user)
      end
      let(:authorization_subject) { 'not a class, not an active_admin_page, not an active record class, but a string' }

      it 'Returns nil' do
        expect(active_admin_basic_authorization_adapter.authorized?(:read, authorization_subject)).to be_nil
      end
    end

    context 'when subject is a class' do
      let(:resource) { ActiveAdmin::Page.new('A Page') }
      let(:active_admin_basic_authorization_adapter) do
        described_class.new(resource, admin_user)
      end

      context 'when there is no authorization class' do
        let(:authorization_subject) { ARandomClass }

        context 'when the called method does not exist in default authorization' do
          let(:authorization_method) do
            active_admin_basic_authorization_adapter.authorized?(:unknow_method, authorization_subject)
          end

          it 'Returns false' do
            expect(authorization_method).to be(false)
          end
        end

        context 'when the called method exists in default authorization' do
          context 'when the default authorization method returns true' do
            let(:authorization_method) do
              active_admin_basic_authorization_adapter.authorized?(:default_authorized_method, authorization_subject)
            end

            it 'Returns true' do
              expect(authorization_method).to be(true)
            end
          end

          context 'when the default authorization method returns false' do
            let(:authorization_method) do
              active_admin_basic_authorization_adapter.authorized?(:default_unauthorized_method, authorization_subject)
            end

            it 'Returns false' do
              expect(authorization_method).to be(false)
            end
          end
        end
      end

      context 'when there is an authorization class' do
        let(:authorization_subject) { AClass }

        context 'when the called method does not exist in authorization class' do
          let(:authorization_method) do
            active_admin_basic_authorization_adapter.authorized?(:unknow_method, authorization_subject)
          end

          it 'returns false' do
            expect(authorization_method).to be(false)
          end
        end

        context 'when the called method exists in authorization class' do
          context 'when the authorization method returns true' do
            let(:authorization_method) do
              active_admin_basic_authorization_adapter.authorized?(:authorized_method, authorization_subject)
            end

            it 'Returns true' do
              expect(authorization_method).to be(true)
            end
          end

          context 'when the authorization method returns false' do
            let(:authorization_method) do
              active_admin_basic_authorization_adapter.authorized?(:unauthorized_method, authorization_subject)
            end

            it 'Returns false' do
              expect(authorization_method).to be(false)
            end
          end
        end
      end
    end

    context 'when subject is an active_admin page' do
      let(:resource) { ActiveAdmin::Page.new('A Page') }
      let(:active_admin_basic_authorization_adapter) do
        described_class.new(resource, admin_user)
      end

      context 'when there is no authorization class' do
        let(:authorization_subject) { ActiveAdmin::Page.new('A Page without authorization') }

        context 'when the called method does not exist in default authorization' do
          it 'Returns false' do
            expect(active_admin_basic_authorization_adapter.authorized?(:unknow_method,
                                                                        authorization_subject)).to be(false)
          end
        end

        context 'when the called method exists in default authorization' do
          context 'when the default authorization method returns true' do
            let(:authorization_method) do
              active_admin_basic_authorization_adapter.authorized?(:default_authorized_method, authorization_subject)
            end

            it 'Returns true' do
              expect(authorization_method).to be(true)
            end
          end

          context 'when the default authorization method returns false' do
            let(:authorization_method) do
              active_admin_basic_authorization_adapter.authorized?(:default_unauthorized_method, authorization_subject)
            end

            it 'Returns false' do
              expect(authorization_method).to be(false)
            end
          end
        end
      end

      context 'when there is an authorization class' do
        let(:authorization_subject) { ActiveAdmin::Page.new('A Page') }

        context 'when the called method does not exist in authorization' do
          it 'Returns false' do
            expect(active_admin_basic_authorization_adapter.authorized?(:unknow_method,
                                                                        authorization_subject)).to be(false)
          end
        end

        context 'when the called method exists in authorization' do
          context 'when the authorization method returns true' do
            let(:admin_user_active_admin_basic_authorization_adapter) do
              described_class.new(resource, admin_user)
            end

            let(:authorization_method) do
              admin_user_active_admin_basic_authorization_adapter.authorized?(:admin_only, authorization_subject)
            end

            it 'Returns true' do
              expect(authorization_method).to be(true)
            end
          end

          context 'when the authorization method returns false' do
            let(:admin_user_active_admin_basic_authorization_adapter) do
              described_class.new(resource, not_admin_user)
            end

            let(:authorization_method) do
              admin_user_active_admin_basic_authorization_adapter.authorized?(:admin_only, authorization_subject)
            end

            it 'Returns false' do
              expect(authorization_method).to be(false)
            end
          end
        end
      end
    end

    context 'when subject is an active_record model' do
      let(:resource) { ActiveAdmin::Page.new('A Page') }
      let(:active_admin_basic_authorization_adapter) do
        described_class.new(resource, admin_user)
      end

      context 'when there is no authorization class' do
        let(:authorization_subject) { NoComment.new }

        context 'when the called method does not exist in default authorization' do
          it 'Returns false' do
            expect(active_admin_basic_authorization_adapter.authorized?(:unknow_method,
                                                                        authorization_subject)).to be(false)
          end
        end

        context 'when the called method exists in default authorization' do
          context 'when the default authorization method returns true' do
            let(:authorization_method) do
              active_admin_basic_authorization_adapter.authorized?(:default_authorized_method, authorization_subject)
            end

            it 'Returns true' do
              expect(authorization_method).to be(true)
            end
          end

          context 'when the default authorization method returns false' do
            let(:authorization_method) do
              active_admin_basic_authorization_adapter.authorized?(:default_unauthorized_method, authorization_subject)
            end

            it 'Returns false' do
              expect(authorization_method).to be(false)
            end
          end
        end
      end

      context 'when there is an authorization class' do
        let(:authorization_subject) { Comment.new(is_authorized: true) }
        let(:authorization_subject_unauthorized) { Comment.new(is_authorized: false) }

        context 'when the called method does not exist in authorization' do
          it 'Returns false' do
            expect(active_admin_basic_authorization_adapter.authorized?(:unknow_method,
                                                                        authorization_subject)).to be(false)
          end
        end

        context 'when the called method exists in authorization' do
          context 'when the authorization method returns true' do
            let(:authorization_method) do
              active_admin_basic_authorization_adapter.authorized?(:authorized_record_only, authorization_subject)
            end

            it 'Returns true' do
              expect(authorization_method).to be(true)
            end
          end

          context 'when the authorization method returns false' do
            let(:authorization_method) do
              active_admin_basic_authorization_adapter.authorized?(:authorized_record_only,
                                                                   authorization_subject_unauthorized)
            end

            it 'Returns false' do
              expect(authorization_method).to be(false)
            end
          end
        end
      end
    end
  end
end
