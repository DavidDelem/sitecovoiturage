class SearchController < ApplicationController

  def index

    @ville_depart = params[:ville_depart]
    @ville_destination = params[:ville_destination]
    @year_depart = params[:year]
    @month_depart = params[:month]
    @day_depart = params[:day]

    if(params[:ville_depart].present? && params[:ville_destination].present?) then
      if !params["year"] && !params["month"] && !params["day"] then
        date_depart_min = DateTime.now.beginning_of_day
        date_depart_max = DateTime.now.at_end_of_day.localtime

        @year_depart = DateTime.now.year
        @month_depart = DateTime.now.month
        @day_depart = DateTime.now.day

      else
        date_depart_min = DateTime.new(params["year"].to_i, params["month"].to_i, params["day"].to_i, 0 ,0 ,0)
        date_depart_max = DateTime.new(params["year"].to_i, params["month"].to_i, params["day"].to_i, 23 ,59 ,59)
      end
      @trajet = Trajet.where("ville_depart = ? AND ville_destination = ? AND horaire_depart BETWEEN ? AND ?", params[:ville_depart], params[:ville_destination], date_depart_min, date_depart_max)
    else
      @trajet = Trajet.all
    end
  end

  private

end
