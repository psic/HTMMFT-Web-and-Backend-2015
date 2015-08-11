#!/usr/bin/perl -w
use strict;
use warnings;
use DBI;

#Ce script g�n�re les joueurs pour toute les equipe (16x8) avec les contrat associ�, ainsi que des joueurs sans contrat

my $database="howto";
#my $hostname="88.167.71.144";
#my $hostname="192.168.30.15";
my $hostname="127.0.0.1";
#my $login = "football";
#my $mdp = "!M4n4g3r";

my $login = "root";
my $mdp = "cacapipi";


my $dsn = "DBI:mysql:database=$database;host=$hostname";
my $dbh = DBI->connect($dsn, $login, $mdp) or die "Echec connexion";
my @contenu;

open(NAME, "name.txt") || die "Erreur E/S : $!\n";
@contenu = <NAME>;
my @name;
foreach (@contenu) {
    push(@name, split(/ /, $_));   
   }

close (NAME);

open(FIRSTNAME, "name.txt") || die "Erreur E/S : $!\n";
@contenu = <FIRSTNAME>;
my @firstname;
foreach (@contenu) {
    push(@firstname, split(/ /, $_));   
   }

close (FIRSTNAME);

#my $fini = FALSE;
my $nbteam = 1;
my $nbjoueur = 1;
my $nbligue = 1;

#while ($fini)
#{
#  $requete = "SELECT * FROM laTable ";
#  $sth = $dbh->prepare($requete);
#  $sth->execute();
  
#  while($nbligue =< 4)
#  {
#    while($nbteam =< 16)
#    {
  my $requete;
  my $sth;


  my $joueurID;
  my $equipeID;
  my $nbequipe;
  my $nom;
  my $prenom;
  my $age; 
  my $xp;
  my $talent;
  my $tactique;
  my $technique;
  my $physique;
  my $vitesse;
  my $mental;
#  my totalEquipe = 7700;
  my $total = 0;
  my $totalEquipe = 0;
  my $off;
  my $def;
  my $dr;
  my $gch;
  my $ctr;
  my $xppos;
  my $moisFin;
  my $salaire;
  my $numero = 0;

  my $agemoy = 0; 
  my $xpmoy = 0;
  my $talentmoy = 0;
  my $tactiquemoy = 0;
  my $techniquemoy = 0;
  my $physiquemoy = 0;
  my $vitessemoy = 0;
  my $mentalmoy = 0;
 
  $nbequipe = 1;
  $joueurID = 1;
  $equipeID = 1;
   
  my $requeteJoueur;
  my $sthJoueur;

	$requeteJoueur = "INSERT INTO joueurs (equipe_id, nom, prenom, age, xp, talent, tactique, technique, physique, vitesse, mental, off, def,drt,ctr, gch,numero) VALUES (?,?, ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?); ";
	$sthJoueur = $dbh->prepare($requeteJoueur);

   while($nbequipe <= 16) 
    {
	

      while($totalEquipe <= 7800)
      {
	print "Joueur : $nbjoueur / $joueurID \n";
	$prenom = $firstname[int(rand(scalar @firstname))];
	$nom = $name[int(rand(scalar @name))];
	$age = 15 + int(rand(20));
	$xp = ($age -14) + int(rand($age ** 2)/12.5);
	$talent = int(rand(99) + 1);
	$tactique = int(rand(95) + 5);
	$technique = int(rand(95) + 5);
	$physique = int(rand(97) + 3);
	$vitesse = int(rand(94 - $age) - $age + 36);
	$talent =  int(rand(99) + 1);
	$mental = int(rand(98) + 2);

	$agemoy = $agemoy + $age; 
	$xpmoy = $xpmoy + $xp;
	$talentmoy = $talentmoy +$talent;
	$tactiquemoy = $tactiquemoy + $tactique;
	$techniquemoy = $techniquemoy + $technique;
	$physiquemoy = $physiquemoy + $physique;
	$vitessemoy = $vitessemoy + $vitesse;
	$mentalmoy = $mentalmoy + $mental;	
	
	$total = $talent + $tactique + $technique + $physique + $vitesse + $talent + $mental;
	$totalEquipe = $totalEquipe + $total;
      
	$xppos = int(50 + (rand($xp ** 2)/ $xp));


#Gardien
	if ($nbjoueur <= 3){
	  $dr = 0;
	  $gch = 0;
	  $ctr = 100;
	  $off = 0;
	  $def = $xppos;
	  if ($numero == 12){
			$numero = 16;
		}
	  if ($numero == 1){
			$numero = 12;
		}
	  if ($numero == 0){
			$numero = 1;
		}	  
	}
	
#Def
	if ($nbjoueur >3 && $nbjoueur <= 10){
	  $dr = int(rand($xppos));
	  $gch = int(rand(100 - $dr))+2;
	  $ctr = int(rand(200-$dr-$gch)/2)+2;
	  $def = 30 + int(rand(20) + ($xppos/2));
	  $off = int(rand(100-$def));
	   if ($numero == 14){
			$numero = 15;
		}
	   if ($numero == 13){
			$numero = 14;
		}
	  if ($numero == 5){
			$numero = 13;
		}
	  if ($numero == 4){
			$numero = 5;
		}
	  if ($numero == 3){
			$numero = 4;
		}
	  if ($numero == 2){
			$numero = 3;
		}
	  if ($numero == 16){
			$numero = 2;
		}
	}

#Milieu
	if ($nbjoueur >10 && $nbjoueur <= 17){
	  $dr = int(rand($xppos));
	  $gch = int(rand(100 - $dr))+2;
	  $ctr = int(rand(200-$dr-$gch)/2)+2;
	  $def = 10 + int(rand(30) + ($xppos/2));
	  $off = 10 + int(rand(30) + ($xppos/2));
	   if ($numero == 18){
			$numero = 19;
		}
	   if ($numero == 17){
			$numero = 18;
		}
	  if ($numero == 10){
			$numero = 17;
		}
	  if ($numero == 8){
			$numero = 10;
		}
	  if ($numero == 7){
			$numero = 8;
		}
	  if ($numero == 6){
			$numero = 7;
		}
	  if ($numero == 15){
			$numero = 6;
		}
	}

#Attaquant
       if ($nbjoueur > 17){
	  $dr = int(rand($xppos));
	  $gch = int(rand(100 - $dr))+2;
	  $ctr = int(rand(200-$dr-$gch)/2);
	  $off = 30 + int(rand(20) + ($xppos/2));
	  $def = int(rand(100-$off))+2;
	  if ($numero >= 24){
			$numero = $numero +1;
		}
	   if ($numero == 23){
			$numero = 24;
		}
	   if ($numero == 22){
			$numero = 23;
		}
	  if ($numero == 21){
			$numero = 22;
		}
	  if ($numero == 20){
			$numero = 21;
		}
	  if ($numero == 11){
			$numero = 20;
		}
	  if ($numero == 9){
			$numero = 11;
		}
	  if ($numero == 19){
			$numero = 9;
		}
      }
   
  if ($xp > 100){
    $xp = 100;
  }
  if ($talent > 100){
    $talent = 100;
  }
  if ($tactique > 100){
    $tactique = 100;
  }
  if ($technique > 100){
    $technique = 100;
  }
  if ($physique > 100){
    $physique = 100;
  }
  if ($vitesse > 100){
    $vitesse = 100;
  }
  if ($mental > 100){
    $mental = 100;
  }
  if ($off > 100){
    $off = 100;
  }
  if ($def > 100){
    $def = 100;
  }
  if ($dr > 100){
    $dr = 100;
  }
  if ($gch > 100){
    $gch = 100;
  }
  if ($ctr > 100){
    $ctr = 100;
  }
  
   if ($xp < 0){
    $xp = 0;
  }
  if ($talent < 0){
    $talent = 0;
  }
  if ($tactique < 0){
    $tactique = 0;
  }
  if ($technique < 0){
    $technique = 0;
  }
  if ($physique < 0){
    $physique = 0;
  }
  if ($vitesse < 0){
    $vitesse = 0;
  }
  if ($mental < 0){
    $mental = 0;
  }
  if ($off < 0){
    $off = 0;
  }
  if ($def < 0){
    $def = 0;
  }
  if ($dr < 0){
    $dr = 0;
  }
  if ($gch < 0){
    $gch = 0;
  }
  if ($ctr < 0){
    $ctr = 0;
  }
   
	print "Nom : $prenom $nom, $age ans \n";
	print "xp : $xp \n";
	print "$dr / $ctr / $gch \n";
	print "$def / $off \n";
	print "talent : $talent \n";
	print "tactique : $tactique \n";
	print "technique : $technique \n";
	print "physique : $physique \n";
	print "vitesse : $vitesse \n";
	print "mental : $mental \n";
	print "Total : $total / $totalEquipe \n";
	
	print "----------------------------------------------------- \n";
	#$requeteJoueur = "INSERT INTO Joueurs (Nom, Prenom, Age, Xp, Talent, Tactique, Technique, Physique, Vitesse, Mental, Off, Def,Drt,Ctr, Gch, Liste_Transfert,Liste_Pret)
	#VALUES ('$nom', '$prenom',$age,$xp,$talent,$tactique,$technique,$physique,$vitesse,$mental,$off,$def,$dr,$ctr,$gch,0,0); ";
	#$sthJoueur = $dbh->prepare($requeteJoueur);
	$sthJoueur->execute($equipeID,$nom, $prenom,$age,$xp,$talent,$tactique,$technique,$physique,$vitesse,$mental,$off,$def,$dr,$ctr,$gch,$numero);

  

	$nbjoueur = $nbjoueur +1;
	$joueurID = $joueurID + 1;
  } 
	
	$agemoy = int($agemoy / ($nbjoueur -1)); 
	$xpmoy = int($xpmoy / ($nbjoueur -1));
	$talentmoy = int($talentmoy / ($nbjoueur -1));
	$tactiquemoy = int($tactiquemoy / ($nbjoueur -1));
	$techniquemoy = int($techniquemoy / ($nbjoueur -1));
	$physiquemoy = int($physiquemoy / ($nbjoueur -1));
	$vitessemoy = int($vitessemoy / ($nbjoueur -1));
	$mentalmoy = int($mentalmoy / ($nbjoueur -1));	
	
      print "Total Equipe : $totalEquipe \n";
      print "moyenne : \n";
      print "age : $agemoy \n";
      print "xp : $xpmoy \n";
      print "talent : $talentmoy \n";
      print "tactique : $tactiquemoy \n";
      print "technique : $techniquemoy \n";
      print "physique : $physiquemoy \n";
      print "vitesse : $vitessemoy \n";
      print "mental : $mentalmoy \n";
#      $nbteam = $nbteam + 1;
#      $nbjoueur = 1;
 #   }
#   $nbligue = $nbligue + 1; 
  #}
 # }
  $nbequipe = $nbequipe + 1;
  $equipeID = $equipeID + 1;
  $totalEquipe = 0;
  $nbjoueur = 1;
  $agemoy = 0;
  $xpmoy = 0;
  $talentmoy = 0;
  $tactiquemoy = 0;
  $techniquemoy = 0;
  $physiquemoy = 0;
  $vitessemoy = 0;
  $total = 0;
  $numero = 0;
}



# Joueur sans contrat

my $nbjoueurSC = 0;
$nbjoueur = 1;

print "\n *************************************\n Joueur SANS CONTRAT \n ****************************** \n";

  while($nbjoueurSC <= 100)
      {
	print "Joueur : $nbjoueurSC / $joueurID \n";
	$prenom = $firstname[int(rand(scalar @firstname))];
	$nom = $name[int(rand(scalar @name))];
	$age = 15 + int(rand(20));
	$xp = ($age -14) + int(rand($age ** 2)/12.5);
	$talent = int(rand(99) + 1);
	$tactique = int(rand(95) + 5);
	$technique = int(rand(95) + 5);
	$physique = int(rand(97) + 3);
	$vitesse = int(rand(94 - $age) - $age + 36);
	$talent =  int(rand(99) + 1);
	$mental = int(rand(98) + 2);
	
	$total = $talent + $tactique + $technique + $physique + $vitesse + $talent + $mental;
      
	$xppos = int(50 + (rand($xp ** 2)/ $xp));


#Gardien
	if ($nbjoueur <= 3){
	  $dr = 0;
	  $gch = 0;
	  $ctr = 100;
	  $off = 0;
	  $def = $xppos;
	}
	
#Def
	if ($nbjoueur >3 && $nbjoueur <= 10){
	  $dr = int(rand($xppos));
	  $gch = int(rand(100 - $dr))+2;
	  $ctr = int(rand(200-$dr-$gch)/2)+2;
	  $def = 30 + int(rand(20) + ($xppos/2));
	  $off = int(rand(100-$def));
	}

#Milieu
	if ($nbjoueur >10 && $nbjoueur <= 17){
	  $dr = int(rand($xppos));
	  $gch = int(rand(100 - $dr))+2;
	  $ctr = int(rand(200-$dr-$gch)/2)+2;
	  $def = 10 + int(rand(30) + ($xppos/2));
	  $off = 10 + int(rand(30) + ($xppos/2));
	}

#Attaquant
       if ($nbjoueur > 17){
	  $dr = int(rand($xppos));
	  $gch = int(rand(100 - $dr))+2;
	  $ctr = int(rand(200-$dr-$gch)/2);
	  $off = 30 + int(rand(20) + ($xppos/2));
	  $def = int(rand(100-$off))+2;
      }
   
    if ($nbjoueur > 22)
    {
      $nbjoueur = 0;
    }

  if ($xp > 100){
    $xp = 100;
  }
  if ($talent > 100){
    $talent = 100;
  }
  if ($tactique > 100){
    $tactique = 100;
  }
  if ($technique > 100){
    $technique = 100;
  }
  if ($physique > 100){
    $physique = 100;
  }
  if ($vitesse > 100){
    $vitesse = 100;
  }
  if ($mental > 100){
    $mental = 100;
  }
  if ($off > 100){
    $off = 100;
  }
  if ($def > 100){
    $def = 100;
  }
  if ($dr > 100){
    $dr = 100;
  }
  if ($gch > 100){
    $gch = 100;
  }
  if ($ctr > 100){
    $ctr = 100;
  }
  
  if ($xp < 0){
    $xp = 0;
  }
  if ($talent < 0){
    $talent = 0;
  }
  if ($tactique < 0){
    $tactique = 0;
  }
  if ($technique < 0){
    $technique = 0;
  }
  if ($physique < 0){
    $physique = 0;
  }
  if ($vitesse < 0){
    $vitesse = 0;
  }
  if ($mental < 0){
    $mental = 0;
  }
  if ($off < 0){
    $off = 0;
  }
  if ($def < 0){
    $def = 0;
  }
  if ($dr < 0){
    $dr = 0;
  }
  if ($gch < 0){
    $gch = 0;
  }
  if ($ctr < 0){
    $ctr = 0;
  }
  
	print "Nom : $prenom $nom, $age ans \n";
	print "xp : $xp \n";
	print "$dr / $ctr / $gch \n";
	print "$def / $off \n";
	print "talent : $talent \n";
	print "tactique : $tactique \n";
	print "technique : $technique \n";
	print "physique : $physique \n";
	print "vitesse : $vitesse \n";
	print "mental : $mental \n";
	print "Total : $total \n";
	
	print "----------------------------------------------------- \n";
	#$requeteJoueur = "INSERT INTO Joueur (Nom, Prenom, Age, Xp, Talent, Tactique, Technique, Physique, Vitesse, Mental, Off, Def,Drt,Ctr, Gch, Liste_Transfert,Liste_Pret)
	#VALUES ('$nom', '$prenom',$age,$xp,$talent,$tactique,$technique,$physique,$vitesse,$mental,$off,$def,$dr,$ctr,$gch,0,0); ";
	#$sthJoueur = $dbh->prepare($requeteJoueur);
	$sthJoueur->execute(0,$nom, $prenom,$age,$xp,$talent,$tactique,$technique,$physique,$vitesse,$mental,$off,$def,$dr,$ctr,$gch,0);

	$nbjoueurSC = $nbjoueurSC +1;
	$joueurID = $joueurID + 1;
	$nbjoueur = $nbjoueur +1;
  } 
	
