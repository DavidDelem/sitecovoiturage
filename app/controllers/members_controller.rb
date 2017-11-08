class MembersController < ApplicationController

  def show
    @member = Member.find(params[:id])
  end

  def preferences
    @member = Member.find(params[:member_id])
  end

  def updatepreferences
    @member = Member.find(params[:member_id])

    if @member.update(member_preferences)
      redirect_to member_preferences_path(@member)
    else
      redirect_to member_preferences_path(@member)
    end

  end

  private

  def member_preferences
    params.permit(:preference_discussion, :preference_cigarette, :preference_animaux, :preference_musique)
  end
end

