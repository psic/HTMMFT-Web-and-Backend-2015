class ClubsController < ApplicationController
  def show
   # @club = Club.find(params[:id],:include => [ :equipe])
  
   
    @club = Club.find(params[:id])
    @couleur = Club.find_by_sql(["SELECT clubs.couleur1 as couleur1, clubs.couleur2 as couleur2 FROM equipes, clubs
								WHERE equipes.club_id = clubs.id
								AND equipes.id = ?", params[:id]])
	@login = Equipe.find_by_sql(["SELECT users.login as login, users.email as email FROM users
								 WHERE users.equipe_id = ?",current_team]);
									
	@topbut = Joueur.find_by_sql(["SELECT joueurs.id, joueurs.nom, joueurs.prenom, joueurs.numero, SUM(stats.`but`) as buts, AVG(stats.`but`) as avgbuts, COUNT(stats.id) as count from stats,  equipes, joueurs
									WHERE  equipes.id = joueurs.equipe_id
									AND equipes.club_id = ?
									AND stats.id_joueur = joueurs.id
									GROUP BY joueurs.id
									ORDER BY buts DESC
									LIMIT 0 , 10",params[:id]])
	
	@toptir = Joueur.find_by_sql(["SELECT joueurs.id, joueurs.nom, joueurs.prenom, joueurs.numero, SUM(stats.`tir+`) as buts, AVG(stats.`tir+`) as avgbuts, COUNT(stats.id) as count from stats,  equipes, joueurs
									WHERE  equipes.id = joueurs.equipe_id
									AND equipes.club_id = ?
									AND stats.id_joueur = joueurs.id
									GROUP BY joueurs.id
									ORDER BY avgbuts DESC
									LIMIT 0 , 10",params[:id]])
									
	@nultir = Joueur.find_by_sql(["SELECT joueurs.id, joueurs.nom, joueurs.prenom, joueurs.numero, SUM(stats.`tir-`) as buts, AVG(stats.`tir-`) as avgbuts, COUNT(stats.id) as count from stats,  equipes, joueurs
									WHERE  equipes.id = joueurs.equipe_id
									AND equipes.club_id = ?
									AND stats.id_joueur = joueurs.id
									GROUP BY stats.id_joueur
									ORDER BY avgbuts DESC
									LIMIT 0 , 10",params[:id]])
		
									
	@topballon = Joueur.find_by_sql(["SELECT joueurs.id, joueurs.nom, joueurs.prenom, joueurs.numero, SUM(stats.`ballon+`) as ballon, AVG(stats.`ballon+`) as avgballon, COUNT(stats.id) as count from stats,  equipes, joueurs
									WHERE  equipes.id = joueurs.equipe_id
									AND equipes.club_id = ?
									AND stats.id_joueur = joueurs.id
									GROUP BY joueurs.id
									ORDER BY avgballon DESC
									LIMIT 0 , 10",params[:id]])
									
	@nulballon = Joueur.find_by_sql(["SELECT joueurs.id, joueurs.nom, joueurs.prenom, joueurs.numero, SUM(stats.`ballon-`) as ballon, AVG(stats.`ballon-`) as avgballon, COUNT(stats.id) as count from stats,  equipes, joueurs
									WHERE  equipes.id = joueurs.equipe_id
									AND equipes.club_id = ?
									AND stats.id_joueur = joueurs.id
									GROUP BY joueurs.id
									ORDER BY avgballon DESC
									LIMIT 0 , 10",params[:id]])
									
	@toppasse = Joueur.find_by_sql(["SELECT joueurs.id, joueurs.nom, joueurs.prenom, joueurs.numero, SUM(stats.`passe+`) as passe, AVG(stats.`passe+`) as avgpasse, COUNT(stats.id) as count from stats,  equipes, joueurs
									WHERE  equipes.id = joueurs.equipe_id
									AND equipes.club_id = ?
									AND stats.id_joueur = joueurs.id
									GROUP BY joueurs.id
									ORDER BY avgpasse DESC
									LIMIT 0 , 10",params[:id]])

	@nulpasse = Joueur.find_by_sql(["SELECT joueurs.id, joueurs.nom, joueurs.prenom, joueurs.numero, SUM(stats.`passe-`) as passe, AVG(stats.`passe-`) as avgpasse, COUNT(stats.id) as count from stats,  equipes, joueurs 
									WHERE  equipes.id = joueurs.equipe_id
									AND equipes.club_id = ?
									AND stats.id_joueur = joueurs.id
									GROUP BY joueurs.id
									ORDER BY avgpasse DESC
									LIMIT 0 , 10",params[:id]])
									
	@toptackle = Joueur.find_by_sql(["SELECT joueurs.id, joueurs.nom, joueurs.prenom, joueurs.numero, SUM(stats.`tackle+`) as tackle, AVG(stats.`tackle+`) as avgtackle, COUNT(stats.id) as count from stats,  equipes, joueurs
									WHERE  equipes.id = joueurs.equipe_id
									AND equipes.club_id = ?
									AND stats.id_joueur = joueurs.id
									GROUP BY joueurs.id
									ORDER BY avgtackle DESC
									LIMIT 0 , 10",params[:id]])

	@nultackle = Joueur.find_by_sql(["SELECT joueurs.id, joueurs.nom, joueurs.prenom, joueurs.numero, SUM(stats.`tackle-`) as tackle, AVG(stats.`tackle-`) as avgtackle, COUNT(stats.id) as count from stats,  equipes, joueurs
									WHERE  equipes.id = joueurs.equipe_id
									AND equipes.club_id = ?
									AND stats.id_joueur = joueurs.id
									GROUP BY joueurs.id
									ORDER BY avgtackle DESC
									LIMIT 0 , 10",params[:id]])
									
	@topdrible = Joueur.find_by_sql(["SELECT joueurs.id, joueurs.nom, joueurs.prenom, joueurs.numero, SUM(stats.`drible+`) as drible, AVG(stats.`drible+`) as avgdrible, COUNT(stats.id) as count from stats,  equipes, joueurs
									WHERE  equipes.id = joueurs.equipe_id
									AND equipes.club_id = ?
									AND stats.id_joueur = joueurs.id
									GROUP BY joueurs.id
									ORDER BY avgdrible DESC
									LIMIT 0 , 10",params[:id]])

	@nuldrible = Joueur.find_by_sql(["SELECT joueurs.id, joueurs.nom, joueurs.prenom, joueurs.numero, SUM(stats.`drible-`) as drible, AVG(stats.`drible-`) as avgdrible, COUNT(stats.id) as count from stats,  equipes, joueurs
									WHERE  equipes.id = joueurs.equipe_id
									AND equipes.club_id = ?
									AND stats.id_joueur = joueurs.id
									GROUP BY joueurs.id
									ORDER BY avgdrible DESC
									LIMIT 0 , 10",params[:id]])
    

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
										AND equipes.id = ?)  ORDER BY points DESC,(bp-bc) DESC",  params[:id]])
										
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
									OR	equipe2.id = ?)",  params[:id] ,  params[:id]])
	
		 	
		end
	
	end
		
  def index
    @clubs = Club.all
  end
  
  
  
end
