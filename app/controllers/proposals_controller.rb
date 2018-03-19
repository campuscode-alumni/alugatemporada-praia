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
    @proposal.phone = @user.phone
    @proposal.value = calculate_value @proposal
    if @proposal.save
      redirect_to property_path(@property.id)
    else
      render :new
    end
  end

  def show
    @proposal = Proposal.find(params[:id])



  end

  private
  def calculate_value proposal
    price = 0
    if proposal.valid?
      (proposal.start_date.to_date..proposal.end_date.to_date).each do |selected_date|
        proposal_range = proposal.property.price_ranges.where("start_date <= ? AND end_date >= ?", selected_date, selected_date )
        if proposal_range.any?
          price = price + proposal_range.first.daily_rate
        else
          price = price + proposal.property.daily_rate
        end
      end
    end
    price
  end
end
