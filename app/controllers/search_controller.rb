class SearchController < ApplicationController

  def index
    if(params.has_key?(:ville_depart) && params.has_key?(:ville_destination)) then
      @trajet = Trajet.where("ville_depart = ? AND ville_destination = ?", params[:ville_depart], params[:ville_destination])
    else
      @trajet = Trajet.all
    end
  end

end
