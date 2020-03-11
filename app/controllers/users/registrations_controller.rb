# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  before_filter :set_default_response_format

  private
  def set_default_response_format
    request.format = :json
  end
end
