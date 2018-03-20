class ProposalsController < ApplicationController
  def new
    @proposal = Proposal.new
    @property = Property.find params[:property_id]
  end

  def create
    @property = Property.find params[:property_id]

    proposal_params = params.require(:proposal).permit(:name, :email, :phone,
    :rent_purpose, :maximum_guests, :start_date, :end_date, :petfriendly,
    :smoking_allowed, :proposal_details)

    @proposal = @property.proposals.new(proposal_params)
    @proposal.user = current_user

    if @proposal.save
      redirect_to property_path @property
    else
      render :new
    end
  end

  def show
    @proposal = Proposal.find(params[:id])
  end

  def reject
    proposal = Proposal.find(params[:proposal_id])
    if proposal.rejected!
      flash[:notice] = 'Proposta rejeitada com sucesso'
      redirect_to property_path(proposal.property)
    else
      flash[:notice] = "Não foi possível rejeitar a proposta #{proposal.id}"
      render :show
    end
  end
end
