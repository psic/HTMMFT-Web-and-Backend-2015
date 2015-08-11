#!/usr/bin/perl -w
use strict;
use warnings;
use DBI;

#Ce script g�n�re les clubs et les equipes

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


open(CITY, "city.txt") || die "Erreur E/S : $!\n";
my @contenu ;
my @city;
@contenu = <CITY>;
#print @data;
foreach (@contenu) {
    push(@city, split(/ /, $_));   
   }
close(CITY);

open(STADE, "stadium.txt") || die "Erreur E/S : $!\n";
my @stade;
@stade = <STADE>;
close (STADE);

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


  my $clubID;
  my $nbequipe;
  my $nbdivision;
  my $nom;
  my $prenom;
  my $couleur1;
  my $couleur2;
  my $stadium;
  my $capaciteStade;
  my $argent;
  my $centreFormation;
  my $club;
  my $president;
  my $nbjournee;
  my $i;

  my $requeteEquipe;
  my $requeteClub; 
  my $requeteClassement;
  my $sthEquipe;
  my $sthClub;
  my $sthClassement;
    
	$requeteEquipe = "INSERT INTO equipes (nom, club_id)
	VALUES (?,?); ";
	$sthEquipe = $dbh->prepare($requeteEquipe);

	$requeteClub = "INSERT INTO clubs (division_id,president,couleur1,couleur2,stade,capacite_stade, argent,centre_de_formation) 
	VALUES (1,?, ?, ?, ?, ?, ?, ?);";	 
	$sthClub = $dbh->prepare($requeteClub);

	$requeteClassement="INSERT INTO classements (club_id) VALUES (?);";
	$sthClassement=$dbh->prepare($requeteClassement);

   $clubID = 1; 
   
   $nbdivision = 1;
while ($nbdivision <= 1)
{
  $nbequipe = 1;

   while($nbequipe <= 16) 
    {

      $prenom = $firstname[int(rand(scalar @firstname))];
      $nom = $name[int(rand(scalar @name))];
      $president = $prenom .' '.  $nom;
      $couleur1 = int(rand(359)+1);
      do{
			$couleur2 = int(rand(359)+1);
		}while(abs($couleur1 - $couleur2) < 30 );
      $stadium = $stade[int(rand(scalar @stade))];
      $capaciteStade = int (rand (10000) + 5000);
      $argent = int (20000 - rand ($capaciteStade));
      $centreFormation = int (10 - (rand($argent)/5000)*2);
      $sthClub->execute($president,$couleur1,$couleur2,$stadium,$capaciteStade,$argent,$centreFormation);
      
      $club =  $city [int(rand(scalar @city))];
      $sthEquipe->execute($club,$clubID);

      $sthClassement->execute($clubID);
      $clubID = $clubID + 1;
      $nbequipe =$nbequipe + 1;
    }

  $nbdivision = $nbdivision + 1 ;
}
