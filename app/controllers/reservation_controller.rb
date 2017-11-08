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
    @covoiturage = Covoiturage.where("member_id = ? AND trajet_id = ?", current_member.id, params[:trajet_id]).take
    @covoiturage.destroy
    redirect_to member_trajets_path
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