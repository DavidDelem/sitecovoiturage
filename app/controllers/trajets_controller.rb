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
      @reservation = Reservation.where("member_id = ? AND trajet_id = ?", current_member.id, trajet.id).take
      trajet.nb_places_reservees = @reservation.nb_places
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
      @reservations = Reservation.where("trajet_id = ?", trajet.id)

      @reservations.each do |reservation|
        nbPassagers += reservation.nb_places
      end
      trajet.nb_places_reservees = nbPassagers
    end

  end

  def show
    @trajet = Trajet.find(params[:id])
    @member = Member.find(@trajet.member_id) # innutile, utiliser current_member

    nbPlacesReservees = 0
    @reservations = Reservation.where("trajet_id = ?", @trajet.id)
    @reservations.each do |reservation|
      nbPlacesReservees += reservation.nb_places
    end

    @nbPlacesRestantes = @trajet.nb_places_totales - nbPlacesReservees
  end

  def new
  end

  def create
     @trajet = Trajet.new(params.require(:trajet).permit(:horaire_depart, :ville_depart, :ville_destination, :nb_places_totales, :prix, :dimension_valise))
     @trajet.member_id = current_member.id
     @trajet.save
     redirect_to member_trajet_path(current_member.id, @trajet.id)
  end

  def destroy
    @trajet = Trajet.find(params[:id])
    @trajet.destroy
    redirect_to member_trajets_path
  end

end
