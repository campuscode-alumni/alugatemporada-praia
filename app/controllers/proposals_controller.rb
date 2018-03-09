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

    @proposal = Proposal.new(proposal_params)
    @proposal.property = @property
    if @proposal.save
      redirect_to property_path(@property.id)
    else
      render :new
    end
    
  end
end