class ProposalsController < ApplicationController
  def new
    @proposal = Proposal.new
  end
end
