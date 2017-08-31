class WelcomeController < ApplicationController
	skip_before_action :authenticate_tenant, only: [:index]

  def index
    @tenants = Tenant.all
  end
end
