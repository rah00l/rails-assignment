class ApplicationController < ActionController::API
	before_action :authenticate_tenant
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  include Response
  include ExceptionHandler

private
  def authenticate_tenant
    tenant_api_key = request.headers['X-TENANT-API-KEY']
    if tenant_api_key
      @tenant = Tenant.find_by api_key: tenant_api_key
      #Unauthorize if a tenant object is not returned
      if @tenant.nil?
        return unauthorize
      end
    else
      return unauthorize
    end
  end

  def unauthorize
    head status: :unauthorized
    return false
  end
end
