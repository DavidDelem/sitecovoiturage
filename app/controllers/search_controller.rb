class SearchController < ApplicationController

  def index

    @ville_depart = params[:ville_depart]
    @ville_destination = params[:ville_destination]
    @year_depart = params[:year]
    @month_depart = params[:month]
    @day_depart = params[:day]

    if(params[:ville_depart].present? && params[:ville_destination].present?) then

      date_depart = DateTime.new(params["year"].to_i, params["month"].to_i, params["day"].to_i, 0 ,0 ,0)
      puts date_depart
      @trajet = Trajet.where("ville_depart = ? AND ville_destination = ? AND horaire_depart >= ?", params[:ville_depart], params[:ville_destination], date_depart)
    else
      @trajet = Trajet.all
    end
  end

  private

end
