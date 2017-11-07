class TrajetsController < ApplicationController

  def index
    # Récupération des trajets PASSAGER

    @trajetsPassager = current_member.trajets_passager

    @trajetsPassager.each do |trajet|
      trajet.class_eval do
        attr_accessor :nb_places_reservees
      end
    end
    @trajetsPassager.each do |trajet|
      @covoiturage = Covoiturage.where("member_id = ? AND trajet_id = ?", current_member.id, trajet.id).take
      trajet.nb_places_reservees = @covoiturage.nb_places
    end

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

  def reservation
    @trajet = Trajet.find(params[:trajet])
    @nb_places = 0

    if(params.has_key?(:nb_places))
      @nb_places = params[:nb_places]
    end
  end

  def confirmation
    if(params.has_key?(:nb_places) && params.has_key?(:trajet))
      @trajet = Trajet.find(params[:trajet])

      # Contrôle du nombre de places restantes par rapport au nombre de places demandées
      nbPlacesReservees = 0
      @covoiturages = Covoiturage.where("trajet_id = ?", @trajet.id)
      @covoiturages.each do |covoiturage|
        nbPlacesReservees  += covoiturage.nb_places
      end
      nbPlacesRestantes = @trajet.nb_places_totales - nbPlacesReservees;

      if(params[:nb_places].to_i <= nbPlacesRestantes)
        @covoiturage = Covoiturage.create({ :trajet_id => @trajet.id, :member_id => current_member.id, :nb_places => params[:nb_places] })
        @covoiturage.save
      end
    end
  end
end
