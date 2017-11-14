class ReservationController < ApplicationController

  def show
    @trajet = Trajet.find(params[:trajet])
    @nb_places = 0

    if(params.has_key?(:nb_places))
      @nb_places = params[:nb_places]
      @tarif_total = @nb_places.to_i * @trajet.prix
    end
  end

  def delete
    @reservation = Reservation.where("member_id = ? AND trajet_id = ?", current_member.id, params[:trajet_id]).take
    @reservation.destroy
    redirect_to member_trajets_path(current_member.id)
  end

  def paiement
    if(params.has_key?(:nb_places) && params.has_key?(:trajet))
      @trajet = Trajet.find(params[:trajet])
      @nb_places = params[:nb_places]
      @tarif_total = @nb_places.to_i * @trajet.prix
    end
  end

  def confirmation
    if(params.has_key?(:nb_places) && params.has_key?(:trajet))
      @trajet = Trajet.find(params[:trajet])

      # Contrôle du nombre de places restantes par rapport au nombre de places demandées
      nbPlacesReservees = 0
      @reservations = Reservation.where("trajet_id = ?", @trajet.id)
      @reservations.each do |reservation|
        nbPlacesReservees  += reservation.nb_places
      end
      nbPlacesRestantes = @trajet.nb_places_totales - nbPlacesReservees;

      if(params[:nb_places].to_i <= nbPlacesRestantes)
        @reservation = Reservation.create({ :trajet_id => @trajet.id, :member_id => current_member.id, :nb_places => params[:nb_places] })
        @reservation.save
      end
    end
  end

  def avis
    @member = params[:member_id]
    @trajer = params[:trajet_id]
  end

  def avisupdate
    @reservation =  Reservation.where("trajet_id = ? AND member_id = ?", params[:trajet_id], params[:member_id])

    if @reservation.update(reservation_avis)
      redirect_to member_trajets_path(current_member.id)
    else
      redirect_to member_trajets_path(current_member.id)
    end
  end

  def reservation_avis
    params.permit(:avis, :note)
  end

end