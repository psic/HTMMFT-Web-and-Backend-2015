#!/usr/bin/perl -w
use strict;
use warnings;
use DBI;

#Ce script initialise la base de donnee : Annee et Division

my $database="howto";
#my $hostname="88.167.71.144";
#my $hostname="192.168.30.15";
my $hostname="127.0.0.1";
#my $login = "football";
#my $mdp = "!M4n4g3r";

my $login = "root";
my $mdp = "cacapipi";
my $requeteDivision;
my $sthDivision;

my $dsn = "DBI:mysql:database=$database;host=$hostname";
my $dbh = DBI->connect($dsn, $login, $mdp) or die "Echec connexion";


	$requeteDivision = " INSERT INTO divisions (nom) 
	VALUES (?);";	
	$sthDivision = $dbh->prepare($requeteDivision);

	$sthDivision->execute('Nord');
#	$sthDivision->execute('Nord-Est');	
#	$sthDivision->execute('Nord-Ouest');  
#	$sthDivision->execute('Est');
#	$sthDivision->execute('Ouest');
#	$sthDivision->execute('Sud-Est');
#	$sthDivision->execute('Sud-Ouest');
#	$sthDivision->execute('Sud');
