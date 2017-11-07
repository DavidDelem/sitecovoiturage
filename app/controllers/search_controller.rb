class SearchController < ApplicationController

  def index

    @ville_depart = params[:ville_depart]
    @ville_destination = params[:ville_destination]
    @horaire_depart = params[:horaire_depart]

    if(params.has_key?(:ville_depart) && params.has_key?(:ville_destination)) then
      if(params.has_key?(:horaire_depart)) then
        @trajet = Trajet.where("ville_depart = ? AND ville_destination = ? AND horaire_depart >= ?", params[:ville_depart], params[:ville_destination], params[:horaire_depart])
      else
        @trajet = Trajet.where("ville_depart = ? AND ville_destination = ?", params[:ville_depart], params[:ville_destination])

      end
    else
      @trajet = Trajet.all
    end
  end

end
