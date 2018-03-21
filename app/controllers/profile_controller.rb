class ProfileController < ApplicationController
  def show
    @owner = current_owner
  end
  def edit
    @owner = current_owner
  end
end
