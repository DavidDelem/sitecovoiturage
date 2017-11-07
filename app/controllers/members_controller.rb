class MembersController < ApplicationController

  def show
    @member = Member.find(params[:id])
  end

  def preferences
    @member = Member.find(params[:member_id])
  end
end
