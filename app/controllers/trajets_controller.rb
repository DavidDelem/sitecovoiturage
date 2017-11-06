class TrajetsController < ApplicationController

  def index

    # Récupération des trajets CONDUCTEUR

    @trajetsConducteur = Trajet.where("member_id = ?", current_member.id).order("created_at DESC")

    @trajetsConducteur.each do |trajet|
      trajet.class_eval do
        attr_accessor :nb_places_reservees
      end
    end

    @trajetsConducteur.each do |trajet|
      nbPassagers = 0
      @covoiturages = Covoiturage.where("trajet_id = ?", trajet.id)

      @covoiturages.each do |covoiturage|
        nbPassagers += covoiturage.nb_places
      end
      trajet.nb_places_reservees = nbPassagers
    end

  end

  def show
    @trajet = Trajet.find(params[:id])
    @member = Member.find(@trajet.member_id)
  end

  def new
  end

  def create
     @trajet = Trajet.new(params.require(:trajet).permit(:horaire_depart, :ville_depart, :ville_destination, :nb_places_totales))
     @trajet.member_id = current_member.id
     @trajet.save
     redirect_to member_trajet_path(current_member.id, @trajet.id)
  end


  def destroy
    @trajet = Trajet.find(params[:id])
    @trajet.destroy

    redirect_to articles_path
  end
end
