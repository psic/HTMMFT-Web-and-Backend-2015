class TransfertsController < ApplicationController
  def show
	@login = Equipe.find_by_sql(["SELECT users.login as login, users.email as email FROM users
								 WHERE users.equipe_id = ?",current_team]);
    #@joueurs = Joueur.find(:all, :include => [:equipes => :contrats], 
	#					:conditions => ["equipes.id = ?", current_team], :order=>"numero")
	@club = Club.find(params[:id])
	   @joueurs = Joueur.find_by_sql (["SELECT joueurs. * , count( stats.id_joueur ) AS nbmatch, avg( stats.note ) AS avgnote, (
										SELECT stats.note AS lastnote
										FROM stats, joueurs
										WHERE stats.id_joueur = joueurs.id
										ORDER BY stats.id DESC
										LIMIT 1
										) AS lastnote
										FROM joueurs
										LEFT OUTER JOIN stats ON joueurs.id = stats.id_joueur, equipes
										WHERE equipes.id = ?
										AND equipes.id = joueurs.equipe_id
										GROUP BY joueurs.id
										ORDER BY joueurs.numero",current_team])	
	
	  
  
  #@liste_club = Equipe.find_by_sql(["SELECT '25 Joueurs libres au hasard' as equipe, '0' as id UNION(SELECT CONCAT ( equipes.nom, ' / ', divisions.nom ) AS equipe, equipes.id AS id
										#FROM equipes, divisions
										#WHERE equipes.id = historiques.equipe_id
										#AND historiques.saison_id = saisons.id
										#AND divisions.id = saisons.division_id)"])
										
	@transferts = Joueur.find_by_sql (["SELECT joueurs. *, '0' as nbmatch, '0' as avgnote, '0' as lastnote
									FROM joueurs
									WHERE joueurs.equipe_id = 0
									ORDER BY RAND()
									LIMIT 25 "])
  	
  if not current_user
	@user_session = UserSession.new
  end
  
		if request.xhr?
		  # respond to Ajax request
			render :layout => false
		 else
				@classement = Classement.find_by_sql(["SELECT equipes.nom as equipe, equipes.id as equipeID, points, victoire,defaite,nul,bp,bc, nb_journee, divisions.nom, divisions.id as divID  
										FROM equipes, classements, divisions, clubs
										WHERE clubs.id = classements.club_id 
										AND equipes.club_id = clubs.id
										AND clubs.division_id = divisions.id
										AND divisions.id = (SELECT clubs.division_id FROM clubs, equipes
										WHERE equipes.club_id = clubs.id
										AND equipes.id = ?)  ORDER BY points DESC,(bp-bc) DESC",  current_team])
										
	@agenda = Equipe.find_by_sql(["SELECT equipe1.nom AS equipe1Nom, equipe2.nom equipe2Nom, matchs.score1, matchs.score2,
									matchs.num_journee,matchs.id, matchs.equipe1_id as equipe1ID , matchs.equipe2_id  as equipe2ID
									FROM equipes AS equipe1, equipes AS equipe2, matchs, annees
									WHERE matchs.num_journee = annees.journee
									AND equipe2.id = matchs.equipe2_id
									AND equipe1.id = matchs.equipe1_id"])

	@calendrier = Equipe.find_by_sql(["SELECT equipe1.nom AS equipe1Nom, matchs.score1, matchs.score2, equipe2.nom  AS equipe2Nom, 
									matchs.num_journee,matchs.id,  equipe1.id as equipe1ID , equipe2.id  as equipe2ID  
									FROM equipes AS equipe1, equipes AS equipe2, matchs
									WHERE equipe2.id = matchs.equipe2_id
									AND equipe1.id = matchs.equipe1_id
									AND (equipe1.id = ?
									OR	equipe2.id = ?)
									",  current_team ,  current_team])
		 end
  
  end

def valider
j1_vente=  params[:"j_1_vente"]
j2_vente=  params[:"j_2_vente"]
j_achat= params[:"j_achat"]
# supprimer de la tactique si les joueurs y sont
@pos_j1=Equipe.find_by_sql(["SELECT id, id_tactique,num_joueur_tactique from posistions WHERER id_joueur = ?",j1_vente])
j1_pos = @pos_j1[0].id
j1_tact = @pos_j1[0].id_tactique
num_j1 = @pos_j1[0].num_joueur_tactique
if j1_pos != nil
	@tact = Equipe.find_by_sql(["SELECT * FROM tactiques WHERE",j1_pos])
	Equipe.connection.execute(["UPDATE tactique SET position_j#{num_j1}_id pos = NULL WHERE id = ?", j1_tact])
end

@pos_j2=Equipe.find_by_sql(["SELECT id, id_tactique,num_joueur_tactique from posistions WHERER id_joueur = ?",j2_vente])
j2_pos = @pos_j1[0].id
j2_tact = @pos_j1[0].id_tactique
num_j2 = @pos_j1[0].num_joueur_tactique
if j2_pos != nil
	@tact = Equipe.find_by_sql(["SELECT * FROM tactiques WHERE",j2_pos])
	Equipe.connection.execute(["UPDATE tactique SET position_j#{num_j2}_id pos = NULL WHERE id = ?", j2_tact])
end


Equipe.connection.execute("UPDATE joueurs SET equipe_id = 0, numero = 0 WHERE id = #{j1_vente}")
Equipe.connection.execute("UPDATE joueurs SET equipe_id = 0, numero = 0 WHERE id = #{j2_vente}")
# le numéro à gérer get max numéro, update +1
@max_equipe = Equipe.find_by_sql(["SELECT MAX(numero) as max from joueurs where joueurs.equipe_id= ?", current_team])
max = @max_equipe[0].max
max = max + 1

Equipe.connection.execute("UPDATE joueurs SET equipe_id = #{current_team}, numero =#{max} WHERE id = #{j_achat}")
redirect_to '/'
end



def update_transfert
 # @versions = Version.where(project_id => params[:project_id])
	
	if params[:club_id] == '0'
	@joueurs = Joueur.find_by_sql (["SELECT joueurs. *, '0' as nbmatch, '0' as avgnote, '0' as lastnote
									FROM joueurs
									LEFT OUTER JOIN contrats ON contrats.joueur_id = joueurs.id
									WHERE contrats.id IS NULL
									ORDER BY RAND()
									LIMIT 25 "])
  
  else
	@joueurs = Joueur.find_by_sql (["SELECT joueurs. * , count( stats.id_joueur ) AS nbmatch, avg( stats.note ) AS avgnote, (
										SELECT stats.note AS lastnote
										FROM stats, joueurs
										WHERE stats.id_joueur = joueurs.id
										ORDER BY stats.id DESC
										LIMIT 1
										) AS lastnote
										FROM joueurs
										LEFT OUTER JOIN stats ON joueurs.id = stats.id_joueur, equipes, contrats
										WHERE equipes.id = ?
										AND equipes.id = contrats.equipe_id
										AND contrats.joueur_id = joueurs.id
										GROUP BY joueurs.id
										ORDER BY joueurs.numero",params[:club_id]])	
     	
  
  end
  render :partial => "transfert_div", :object => @joueurs
end

end