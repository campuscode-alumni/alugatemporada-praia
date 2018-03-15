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
    price_range = proposal.property.price_ranges.where(start_date: (start_date..end_date))
    if price_range.any?
      start_date_rang_days = price_range.start_date - proposal.start_date
      end_date_rang_days = price_range.end_date - proposal.end_date
      if start_date_rang_days < 0
        start_date_rang_days = 0
      end
      if end_date_rang_days < 0
        end_date_rang_days = 0
      end
    end
  end
end
