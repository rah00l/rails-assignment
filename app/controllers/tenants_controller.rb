class TenantsController < ApplicationController
  # GET /tenants/:id
  def show
    tenant = Tenant.find(params[:id])
    @tenant = tenant.to_json(include: { users: { include:
                                        { questions:
                                          { include: { answers: { only: :body } } } }
                                  } })
    json_response(@tenant)
  end
end
