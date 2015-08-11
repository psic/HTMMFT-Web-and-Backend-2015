class UsersController < ApplicationController
  def index
  	@classement = Classement.find_by_sql(["SELECT equipes.nom as equipe, equipes.id as equipeID, points, victoire,defaite,nul,bp,bc, divisions.nom  FROM equipes,  classements, divisions,clubs
WHERE clubs.id = classements.club_id 
                                                                                AND equipes.club_id = clubs.id
                                                                                   AND clubs.division_id = divisions.id
                                                                                    AND divisions.id = (SELECT clubs.division_id FROM clubs, equipes
                                                                                     WHERE equipes.club_id = clubs.id
                                                                                      AND equipes.id = ?)  ORDER BY points DESC,(bp-bc) DESC",  current_team])

    

    if not current_user
	@user_session = UserSession.new
  end
  
  end
  
  def new
    @user = User.new
 #   @equipes_array = Equipe.find(:all,:include => [:saisons => :historiques] ,:joins => [[:saisons => :historiques], [:saisons => :division]])
	@equipes_array = Equipe.find_by_sql('SELECT equipes.nom AS equipe, equipes.id AS id, divisions.nom AS division
										FROM equipes, divisions,clubs
										WHERE clubs.division_id = divisions.id
										AND clubs.id = equipes.club_id
										AND equipes.id NOT
										IN (SELECT equipe_id FROM users )').map{|equipe| [equipe.division + ' / ' + equipe.equipe , equipe.id ]}
										
	@divisionN = Division.find_by_sql(["SELECT equipes.nom as equipe, equipes.id as equipeID, 
										users.id as userID, users.email , users.login 
										FROM equipes, divisions,clubs, users
										WHERE clubs.division_id = divisions.id
										AND clubs.id = equipes.club_id
										AND equipes.id = users.equipe_id
										AND divisions.nom ='Nord'"])
  
   #@divisionNE = Division.find_by_sql(["SELECT equipes.nom as equipe, equipes.id as equipeID, 
										#users.id as userID, users.email , users.login 
										#FROM equipes, historiques, saisons,users, divisions
										#WHERE historiques.saison_id = saisons.id
										#AND equipes.id = users.equipe_id
										#AND equipes.id = historiques.equipe_id
										#AND saisons.division_id = divisions.id
										#AND divisions.nom ='Nord-Est'"])
  
  #@divisionE = Division.find_by_sql(["SELECT equipes.nom as equipe, equipes.id as equipeID, 
										#users.id as userID, users.email , users.login 
										#FROM equipes, historiques, saisons,users, divisions
										#WHERE historiques.saison_id = saisons.id
										#AND equipes.id = users.equipe_id
										#AND equipes.id = historiques.equipe_id
										#AND saisons.division_id = divisions.id
										#AND divisions.nom ='Est'"])
  
  #@divisionSE = Division.find_by_sql(["SELECT equipes.nom as equipe, equipes.id as equipeID, 
										#users.id as userID, users.email , users.login 
										#FROM equipes, historiques, saisons,users, divisions
										#WHERE historiques.saison_id = saisons.id
										#AND equipes.id = users.equipe_id
										#AND equipes.id = historiques.equipe_id
										#AND saisons.division_id = divisions.id
										#AND divisions.nom ='Sud-Est'"])
  
  #@divisionS = Division.find_by_sql(["SELECT equipes.nom as equipe, equipes.id as equipeID, 
										#users.id as userID, users.email , users.login 
										#FROM equipes, historiques, saisons,users, divisions
										#WHERE historiques.saison_id = saisons.id
										#AND equipes.id = users.equipe_id
										#AND equipes.id = historiques.equipe_id
										#AND saisons.division_id = divisions.id
										#AND divisions.nom ='Sud'"])
  
  #@divisionSO = Division.find_by_sql(["SELECT equipes.nom as equipe, equipes.id as equipeID, 
										#users.id as userID, users.email , users.login 
										#FROM equipes, historiques, saisons,users, divisions
										#WHERE historiques.saison_id = saisons.id
										#AND equipes.id = users.equipe_id
										#AND equipes.id = historiques.equipe_id
										#AND saisons.division_id = divisions.id
										#AND divisions.nom ='Sud-Ouest'"])
  
  #@divisionO = Division.find_by_sql(["SELECT equipes.nom as equipe, equipes.id as equipeID, 
										#users.id as userID, users.email , users.login 
										#FROM equipes, historiques, saisons,users, divisions
										#WHERE historiques.saison_id = saisons.id
										#AND equipes.id = users.equipe_id
										#AND equipes.id = historiques.equipe_id
										#AND saisons.division_id = divisions.id
										#AND divisions.nom ='Ouest'"])
  
  #@divisionNO = Division.find_by_sql(["SELECT equipes.nom as equipe, equipes.id as equipeID, 
										#users.id as userID, users.email , users.login 
										#FROM equipes, historiques, saisons,users, divisions
										#WHERE historiques.saison_id = saisons.id
										#AND equipes.id = users.equipe_id
										#AND equipes.id = historiques.equipe_id
										#AND saisons.division_id = divisions.id
										#AND divisions.nom ='Nord-Ouest'"])									
 
	 if not current_user
	@user_session = UserSession.new
	end
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Utilisateur cree avec succes."
      redirect_to '/'
    else
      render :action => 'new'
    end
  end
  
  def user_params
    params.require(:user).permit(:login, :email, :password, :password_confirmation, :equipe_id)
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
 def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
     flash[:notice] = "Utilisateur mis a jour avec succes."
      redirect_to @user
    else
      render :action => 'edit'
    end
 end
 def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "Utilisateur detruit avec succes."
    redirect_to users_url
  end
end
