class SearchController < ApplicationController

  def index

    @ville_depart = params[:ville_depart]
    @ville_destination = params[:ville_destination]

    if !params[:year] then
      @year_depart = DateTime.now.year
    else
      @year_depart = params[:year]
    end

    if !params[:month] then
      @month_depart = DateTime.now.month
    else
      @month_depart = params[:month]
    end

    if !params[:day] then
      @day_depart = DateTime.now.day
    else
      @day_depart = params[:day]
    end


    if params[:ville_depart] && params[:ville_destination] && !params[:ville_depart].empty? && !params[:ville_destination].empty? then
      date_depart_min = DateTime.new(@year_depart.to_i, @month_depart.to_i, @day_depart.to_i, 0 ,0 ,0)
      date_depart_max = DateTime.new(@year_depart.to_i, @month_depart.to_i, @day_depart.to_i, 23 ,59 ,59)

      @trajet = Trajet.where("ville_depart = ? AND ville_destination = ? AND horaire_depart BETWEEN ? AND ?", params[:ville_depart], params[:ville_destination], date_depart_min, date_depart_max)
      if @trajet.empty? then
        @error = "Pas de covoiturage trouvé"
      end
    else
      @trajet = nil;
      @error = "Ville de départ ou ville d'arrivée non renseignée"
    end
  end
end
