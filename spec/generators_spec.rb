# frozen_string_literal: true

require 'spec_helper'
require 'tmpdir'

require 'rails/generators'
require 'generators/basic_admin_authorization/default_authorization/default_authorization_generator'
require 'generators/basic_admin_authorization/authorization/authorization_generator'

RSpec.describe 'Generators' do
  before do
    @tmpdir = Dir.mktmpdir

    Dir.chdir(@tmpdir) do
      BasicAdminAuthorization::Generators::DefaultAuthorizationGenerator.new([], { quiet: true }).invoke_all
      BasicAdminAuthorization::Generators::AuthorizationGenerator.new(%w[Comment], { quiet: true }).invoke_all

      require './app/admin/authorizations/default_authorization'
      require './app/admin/authorizations/comment_authorization'
    end
  end

  after do
    FileUtils.remove_entry(@tmpdir)
  end

  describe 'DefaultAuthorization' do
    let(:default_authorization) { ActiveAdmin::Authorizations::DefaultAuthorization.new(User.new) }

    describe '#read' do
      it 'returns false' do
        expect(default_authorization.read).to be(false)
      end
    end

    describe '#create' do
      it 'returns false' do
        expect(default_authorization.create).to be(false)
      end
    end

    describe '#update' do
      it 'returns false' do
        expect(default_authorization.update).to be(false)
      end
    end

    describe '#destroy' do
      it 'returns false' do
        expect(default_authorization.destroy).to be(false)
      end
    end
  end

  describe 'CommentAuthorization', type: :class do
    let(:comment_authorization) { ActiveAdmin::Authorizations::CommentAuthorization.new(User.new) }

    describe 'class' do
      describe 'methods' do
        it 'responds to #read' do
          expect(comment_authorization).to respond_to(:read)
        end

        it 'responds to #create' do
          expect(comment_authorization).to respond_to(:create)
        end

        it 'responds to #update' do
          expect(comment_authorization).to respond_to(:update)
        end

        it 'responds to #destroy' do
          expect(comment_authorization).to respond_to(:destroy)
        end
      end
    end

    describe 'methods' do
      describe '#read' do
        it 'returns false' do
          expect(comment_authorization.read).to be(false)
        end
      end

      describe '#create' do
        it 'returns false' do
          expect(comment_authorization.create).to be(false)
        end
      end

      describe '#update' do
        it 'returns false' do
          expect(comment_authorization.update).to be(false)
        end
      end

      describe '#destroy' do
        it 'returns false' do
          expect(comment_authorization.destroy).to be(false)
        end
      end
    end
  end
end
