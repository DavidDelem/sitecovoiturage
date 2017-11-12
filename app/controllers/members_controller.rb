class MembersController < ApplicationController

  def show
    @member = Member.find(params[:id])

    timeNow = DateTime.new(DateTime.now.year, DateTime.now.month, DateTime.now.day,  DateTime.now.hour, DateTime.now.min).utc
    @nbTrajet = @member.trajets.where("horaire_depart < ?", timeNow).count
    totalNotes = 0.0
    @member.trajets.each do |trajet|
      trajet.covoiturages.each do |covoiturage|
        totalNotes += covoiturage.note

      end
    end

    @moyenneNotes = totalNotes / @nbTrajet;
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

  def changeimage
    @member = Member.find(params[:member_id])
  end

  def upload
    @member = Member.find(params[:member_id])
    uploaded_io = params[:picture]
    newImgName = Time.now.to_i.to_s + uploaded_io.original_filename
    File.open(Rails.root.join('app', 'assets', 'images','profil', newImgName), 'wb') do |file|
      file.write(uploaded_io.read)
    end
    @member.update(image: newImgName)
    redirect_to member_changeimage_url(@member)
  end


  private

  def member_preferences
    params.permit(:preference_discussion, :preference_cigarette, :preference_animaux, :preference_musique)
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end

