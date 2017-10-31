class TrajetsController < ApplicationController

  def show
    @trajet = Trajet.find(params[:id])
  end

  def new
  end

  def create
     @trajet = Trajet.new(params.require(:trajet).permit(:horaire_depart, :ville_depart, :ville_destination, :nb_places_totales))
     @trajet.member_id = current_member.id
     @trajet.save
     redirect_to @trajet
  end


  def destroy
    @trajet = Trajet.find(params[:id])
    @trajet.destroy

    redirect_to articles_path
  end
end
