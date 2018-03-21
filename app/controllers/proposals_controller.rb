class ProposalsController < ApplicationController
  def new
    @proposal = Proposal.new
    @property = Property.find params[:property_id]
  end

  def create

    @property = Property.find params[:property_id]
    @user = current_user

    proposal_params = params.require(:proposal).permit(:name, :email, :phone,
    :rent_purpose, :maximum_guests, :start_date, :end_date, :petfriendly,
    :smoking_allowed, :proposal_details)

    @proposal = Proposal.new(proposal_params)
    @proposal.property = @property
    @proposal.user_id = @user.id

    if @proposal.save
      redirect_to property_path(@property.id)
    else
      render :new
    end
  end

  def show
    @proposal = Proposal.find(params[:id])

  end

  def accept
    @proposal = Proposal.find(params[:id])
    @property = Property.find(params[:property_id])
    @proposal.accepted!
    reject_other_proposals(@proposal, @property)
    flash[:notice] = "Proposta aceita com sucesso!"
    redirect_to @property
  end

  private

  def reject_other_proposals(accepted_proposal, property)
    property.proposals.pending.each do | proposal |
      if (proposal.start_date <= accepted_proposal.start_date && proposal.end_date >= accepted_proposal.start_date) ||
         (proposal.start_date <= accepted_proposal.end_date && proposal.end_date >= accepted_proposal.end_date) ||
         (proposal.start_date <= accepted_proposal.start_date && proposal.end_date >= accepted_proposal.end_date) ||
         (proposal.start_date >= accepted_proposal.start_date && proposal.end_date <= accepted_proposal.end_date) 
        proposal.rejected!
      end
    end
  end

end
