-- Saisir la requ�te suivante : select nom from vt_equipe; Ex�cuter et commenter
--le r�sultat
select nom from prof.vt_sponsor;

select nom from vt_sponsor;
-- il manque prof devant vt_sponsor
Select Nom From prof.vt_Coureur;

select prenom from prof.vt_coureur;

select distinct prenom from prof.vt_coureur;

select * from prof.vt_coureur;
--renvoie la table
select nom ,annee_prem from prof.vt_coureur;
select nom as n,annee_prem b from prof.vt_coureur;

select nom as " Nom du sponsor " from prof.vt_sponsor;

select nom,prenom from prof.vt_sponsor;
--  prenom n'est un descripteur de vt_sponsor
select nom,prenom,annee_naissance from prof.vt_coureur;

select * from vt_etape;
-- il faut mettre prof devant vt_etape
select prenom,nom,annee_prem-annee_naissance as age_prem from prof.vt_coureur;
-- soustrait annee_naissance � annee_prem et attibut le descripteur de nom age_prem
select sysdate from dual;
-- table systeme et date actuelle
select date_etape from prof.vt_etape;

select sysdate-date_etape from dual;
-- date etape n'existe pas dans la table dual
select sysdate-date_etape from prof.vt_etape;

desc prof.vt_coureur; 
--descripteur

----------------------------------------------------------------------------------------
-- La projection et la restriction (lire le cours de 1.1 � 1.2 et tester les exemples)
----------------------------------------------------------------------------------------

/* 1) �tablir la liste des �tapes dont le n� est compris entre 5 et 10. Afficher le n� de l'�tape, 
la ville d�part, la ville arriv�e et la distance. */
select n_etape, ville_d, ville_a, distance from prof.vt_etape
where N_ETAPE > 4 
and N_ETAPE < 11;

/* 2) M�me requ�te que pr�c�demment mais pour l'ann�e 2024. */
select n_etape, ville_d, ville_a, distance from prof.vt_etape
where N_ETAPE > 4 
and N_ETAPE < 11 
and ANNEE = 2024;
/* 3) Afficher la liste des �tapes dont le n� est inf�rieur � 5 ou sup�rieur � 10 pour l'ann�e 2024 (2 solutions). */
select * from prof.vt_etape
where annee = 2024 
and (N_etape < 5 
or N_etape > 10);
/* 4) �tablir la liste des �tapes "prologue" (relire 1_Pres_TDF.pdf). Afficher le code pays d�part, 
le code pays arriv�e, la ville d�part, la ville arriv�e, la distance, la vitesse moyenne, ann�e et le type d'�tape.
 La liste affich�e sera pr�sent�e par ordre croissant de la distance. */
select code_cio_d, code_cio_a, ville_d, ville_a, distance, moyenne, annee, 
cat_code from prof.vt_etape 
where n_etape = 0
order by distance;
/* 5) Projeter les �tapes r�pondant � l'une ou l'autre des restrictions suivantes (une seule requ�te)�:
    � le premier caract�re de la ville de d�part est un 'B', 
    � le dernier caract�re de la ville de d�part est un 'A',
    � la ville de d�part contient un 'U'.
*/
select * from prof.vt_etape
where lower(ville_d) LIKE 'b%'
or upper(ville_d) LIKE '%A'
or upper(ville_d) LIKE '%U%';
/* 6) Projeter l'�tape courue le 14 juillet 2024 */
select * from prof.vt_etape
where to_char(date_etape,'dd/mm/yyyy') = '14/07/2024';
/* 7) Projeter le pr�nom, le nom et l��ge des coureurs ayant particip� � leur premier tour en 2024. */
select nom, prenom, to_char(sysdate,'yyyy')-annee_naissance from prof.vt_coureur
where annee_prem = 2024;
/* 8) Donner la liste des sponsors dont le nom abr�g� est vide avant 1986. */
select * from prof.vt_sponsor
where na_sponsor is null and annee_sponsor < 1986;
/* 9) Projeter par ordre alphab�tique croissant des pr�noms et par nom des coureurs d�croissant, 
la liste des coureurs dont le nom commence par un 'V'. */
select * from prof.vt_coureur
where nom like 'V%'
order by prenom, nom desc;
/* 10) Projeter la liste des nations d00es coureurs (app_nation) dont le pays d'origine
 a pour code�: "SUI", "JAP" ou "POL". */
select * from prof.vt_app_nation
where code_cio = 'SUI' 
or code_cio = 'JAP'
or code_cio = 'POL';
----------------------------------------------------------------------------------------
-- La jointure (lire le cours chap 1.3.1 et 1.3.5 et tester aide_jointures.pdf)
----------------------------------------------------------------------------------------
/* 11) Donner la liste des coureurs ayant particip� au Tour 2024. Afficher le nom, le pr�nom, 
le num�ro de dossard  le n�de l'�quipe et le num�ro de coureur. 
Utiliser au moins 2 m�thodes pour effectuer la jointure. */
select nom, prenom, n_dossard, n_equipe, n_coureur from prof.vt_coureur 
join prof.vt_parti_coureur using (n_coureur) 
where annee = 2024; 
-- Continuer � faire des copier-coller des questions avant d'y r�pondre	

/*11bis) M�me requ�te que pr�c�demment mais pour les dossards compris entre 1 et 9. 
Justifier le nombre de r�ponses.*/
select nom, prenom, n_dossard, n_equipe, prof.vt_coureur.n_coureur from prof.vt_coureur 
join prof.vt_parti_coureur on prof.vt_coureur.n_coureur = prof.vt_parti_coureur.n_coureur
where annee = 2024 and n_dossard > 0 and n_dossard < 10; 
-- il y a 8 r�sultats, car en 2024, les coureurs ont eu un dossard unique, et comme le
-- tdf est 1 fois par an, aucun autre couteur n'a eu le dossard comprisentre 1 et 9. 9-1 = 8 donc 8 resultats

/*11ter) (un peu difficile). M�me requ�te que pr�c�demment mais en projetant en 
compl�ment le nom du sponsor.*/
select cou.nom, prenom, n_dossard, pcou.n_equipe, cou.n_coureur, spo.nom 
from prof.vt_coureur cou 
join prof.vt_parti_coureur pcou on cou.n_coureur = pcou.n_coureur
join prof.vt_sponsor spo on pcou.n_sponsor = spo.n_sponsor
and pcou.n_equipe = spo.n_equipe
where annee = 2024 and n_dossard > 0 and n_dossard < 10; 

/*12) Donner la liste des coureurs dont les num�ros de dossard sont compris entre 25 et 27 et dont le nom contient soit
�OR�, soit �RO�. Afficher le nom, le pr�nom, le n� d��quipe, le n� de sponsor et l�ann�e du Tour de France. Le r�sultat
sera class� sur l�ann�e du Tour.*/
select cou.nom, cou.prenom, pcou.n_equipe, pcou.n_sponsor, pcou.annee 
from prof.vt_coureur cou
join prof.vt_parti_coureur pcou using(n_coureur)
where pcou.n_dossard > 24 and pcou.n_dossard < 28
and (upper(cou.nom) like '%OR%' or upper(cou.nom) like '%RO%')
order by(annee);

/*13) Donner la liste des coureurs consid�r�s comme jeunes (voir 1-Pres_TDF) pour le Tour 2024. Afficher le nom, le
pr�nom, le num�ro du sponsor et d'�quipe, class�s par ordre alphab�tique sur le nom du coureur*/


/* exoplus 1 */

Drop table Exoplus1A;
Drop table Exoplus1B;
create table Exoplus1A(numVille int, nom char(10));
create table Exoplus1B(numVille int, ville char(10));
insert into Exoplus1A values (1,'L�a');
insert into Exoplus1A values (1,'L�on');
insert into Exoplus1A values (10,'Bernard');
insert into Exoplus1A values (100,'Jacques');
insert into Exoplus1A values (999,'Sylvie');
insert into Exoplus1B values (1,'Caen');
insert into Exoplus1B values (10,'Paris');
insert into Exoplus1B values (98,'Bordeaux');
commit;

/*Req1 : Projeter la table Exoplus1A*/
select * from exoplus1a;

/*Req2 : Projeter la table Exoplus1B*/
select * from exoplus1b;

/*Req3 : Tester les requ�tes suivantes :*/
select * from exoplus1A,exoplus1B; 
/* �a multiplie le nombre de ligne d'exoplus 1A avec exoplus1B car la jointure n'est pas bonne*/
select e1.* from exoplus1A e1,exoplus1B e2;
/* �a multiplie le nombre de ligne d'exoplus 1A avec exoplus1B car la jointure n'est pas bonne et e1 et e2 correspondent au deux tables exoplus 1A ET exoplus 1B*/

/*Req4 : Faire une requ�te avec jointure utilisant la clause � where �*/
select e1.*,e2.ville from exoplus1A e1,exoplus1B e2
where e1.numville = e2.numville;

/*Req5 : Faire une requ�te avec jointure �join on�*/
select e1.*,e2.ville from exoplus1A e1
join exoplus1B e2 on e1.numville = e2.numville;

/*Req6 : Faire une requ�te avec jointure �join using�*/
select numville, nom, ville from exoplus1A e1
join exoplus1B e2 USING (numville);

/*Req7 : Faire une requ�te avec jointure � natural join�*/
select numville, nom, ville from exoplus1A e1
natural join exoplus1B e2;

/*Req8 : Faire une requ�te avec jointure � droite*/
select * from exoplus1a  
right join exoplus1b using (numville);

/*Req9 : Faire une requ�te avec jointure � gauche*/
select * from exoplus1a  
left join exoplus1b using (numville);

/*Req10 : Faire une requ�te avec jointure compl�te*/
select * from exoplus1a  
full join exoplus1b using (numville);

/* correction exoplus n�1*/

Drop table Exoplus1A;
Drop table Exoplus1B;

create table Exoplus1A(numVille int, nom char(10));
create table Exoplus1B(numVille int, ville char(10));

insert into Exoplus1A values (1,'L�a');
insert into Exoplus1A values (1,'L�on');
insert into Exoplus1A values (10,'Bernard');
insert into Exoplus1A values (100,'Jacques');
insert into Exoplus1A values (999,'Sylvie');

insert into Exoplus1B values (1,'Caen');
insert into Exoplus1B values (10,'Paris');
insert into Exoplus1B values (98,'Bordeaux');
commit;

--Req1 : Projeter la table exoplus1A
select nom from exoplus1A ;
select * from exoplus1A ;
select exoplus1A.* from exoplus1A;
select e1.* from exoplus1A e1;
-- 5 r�ponses

--Req2 : Projeter la table exoplus1B
select * from exoplus1B;
-- 3 r�ponses

--Req3 : Tester la requ�te suivante : select e1.* from exoplus1A e1,exoplus1B e2; 
--Justifier le r�sultat. A quoi correspondent e1 et e2 ?
select * from exoplus1A e1, exoplus1B e2;

select exoplus1B.* from exoplus1A , exoplus1B ;
select e1.* from exoplus1A e1, exoplus1B e2;
select e2.* from exoplus1A e1 cross join exoplus1B e2;
-- 15 r�ponses

--Req4 : Faire une requ�te avec jointure utilisant la clause ��where��
select * from exoplus1A e1, exoplus1B e2
where e1.numVille = e2.numVille;
-- 3 r�ponses

--Req5 : Faire une requ�te avec jointure �join on�
select  * from exoplus1A e1 
join exoplus1B e2 on  e1.numVille = e2.numVille;
-- 3 r�ponses -- 4 colonnes

--Req6 : Faire une requ�te avec jointure �join using�
select * from exoplus1a e1 
join exoplus1B e2 using (numVille);

select e1.numville from exoplus1a e1 
join exoplus1B e2 using (numVille);
-- 3 r�ponses -- 3 colonnes

--Req7 : Faire une requ�te avec jointure �join natural�
select * from exoplus1A natural join exoplus1B ;
-- 3 r�ponses -- 3 colonnes

--Req8 : Faire une requ�te avec jointure � droite
select * from exoplus1A e1 right join exoplus1B e2 on  e1.numVille = e2.numVille;
select * from exoplus1A e1,exoplus1B e2 where e1.numVille(+) = e2.numVille;
-- 4 r�ponses

--Req9 : Faire une requ�te avec jointure � gauche
select * from exoplus1A e1 left join exoplus1B e2 on  e1.numVille = e2.numVille;
select * from exoplus1A e1,exoplus1B e2 where e1.numVille = e2.numVille(+);
-- 5 r�ponses

--Req10 : Faire une requ�te avec jointure compl�te
select * from exoplus1A e1 full join exoplus1B e2 on  e1.numVille = e2.numVille;
-- 6 r�ponses

/*13) Donner la liste des coureurs consid�r�s comme jeunes (voir 1-Pres_TDF) pour le Tour 2024. Afficher le nom, le
pr�nom, le num�ro du sponsor et d'�quipe, class�s par ordre alphab�tique sur le nom du coureur.*/
select nom,prenom,n_sponsor,n_equipe from prof.vt_coureur
join prof.vt_parti_coureur using(n_coureur)
where jeune = 'o' and annee = 2024
order by(nom);


/*13 bis) Donner la liste des coureurs consid�r�s comme jeunes (voir 1-Pres_TDF) pour le Tour 2024. Afficher le nom, le
pr�nom et le nom du sponsor, class�s par ordre alphab�tique sur le nom du sponsor et sur le nom du coureur.*/
select cou.nom as nom_coureur,prenom,spo.nom as nom_sponsor,n_equipe from prof.vt_coureur cou
join prof.vt_parti_coureur using(n_coureur)
join prof.vt_sponsor spo using (n_equipe, n_sponsor)
where jeune = 'o' and annee = 2024
order by nom_sponsor, nom_coureur;


/*14) : Donner la liste des coureurs (pr�nom et nom) ayant particip� au tour 2024 et pour ceux ayant abandonn�, le type
d�abandon. Attention, les coureurs n�ayant pas abandonn� doivent �tre �galement projet�s.
Exemple avec une ancienne ann�e :*/
select nom, prenom, c_typeaban from prof.vt_coureur
join prof.vt_parti_coureur using(n_coureur)
left join prof.vt_abandon using(n_coureur, annee)
where annee = 2024;

/* exoplus n�2 */

drop table exoplus2;
create table exoplus2(num number(3), nom varchar2(20));
insert into exoplus2 values (1,'Julian');
insert into exoplus2 values (2,'Julian');
insert into exoplus2 values (3,'lance');
insert into exoplus2 values (4,'Romain');
insert into exoplus2 values (5,'Romain');
insert into exoplus2 values (6,'Romain');
insert into exoplus2 values (7,'Thibaut');
insert into exoplus2 values (8,'Thibaut');
commit;

/* Req1 : Projeter nom de la table Exoplus2. Justifier le nombre de lignes (8 lignes)*/
select nom from exoplus2;

/* Req2 : Faire un produit cart�sien avec 2 instances de �Exoplus2�. Projeter uniquement le nom. Justifier 
le nombre de lignes. (64 lignes) => Produit du nb de ligne de exo+2 par le bb de ligne de exo+2, donc 8*8 = 64*/
select ep21.nom from exoplus2 ep21, exoplus2 ep22;

/* Req3 : Faire une jointure sur le champ nom avec toujours 2 instances. Projeter uniquement le nom. 
Justifier le nombre de lignes. (18 lignes) comme il y a le tri, �a n'affiche que le produit cart�sien dont les noms correspondent*/
select ep21.nom from exoplus2 ep21, exoplus2 ep22
where ep21.nom = ep22.nom;

/* Req4 : Faire une jointure sur le champ nom en �liminant les projections des lignes sur elles-m�mes avec 
toujours 2 instances. Projeter uniquement le nom. Justifier le nombre de lignes. (10 lignes)*/
select ep21.nom from exoplus2 ep21, exoplus2 ep22
where ep21.nom = ep22.nom
and ep21.num <> ep22.num;

/*Req5 : Faire une auto-jointure sur le champ nom en �liminant l les projections des lignes sur elles-m�mes
et en �liminant les doublons. Projeter uniquement le nom. Justifier le nombre de lignes. (3 lignes)*/
select distinct ep21.nom from exoplus2 ep21, exoplus2 ep22
where ep21.nom = ep22.nom
and ep21.num <> ep22.num;


/* correction exoplus n�2 */

drop table exoplus2;
create table exoplus2(num number(3), nom varchar2(20));

insert into exoplus2 values (1,'Julian');
insert into exoplus2 values (2,'Julian');
insert into exoplus2 values (3,'Lance');
insert into exoplus2 values (4,'Romain');
insert into exoplus2 values (5,'Romain');
insert into exoplus2 values (6,'Romain');
insert into exoplus2 values (7,'Thibaut');
insert into exoplus2 values (8,'Thibaut');
commit;

-- Req1 : Projeter nom de la table exoplus2. Justifier le nombre de lignes  
select * from exoplus2; 
-- la table comporte 8 lignes
-- 8 lignes

-- Req2 : Faire un produit cart�sien avec 2 instances de exoplus2.
-- Projeter uniquement le nom. Justifier le nombre de lignes.
select e2.nom from exoplus2 e1,exoplus2 e2; 
select * from exoplus2 e1,exoplus2 e2; 
select * from exoplus2 e1 cross join exoplus2 e2; 
-- C'est un produit cartesien donc  8*8 = 64
-- 64 lignes


-- Req3 : Faire une jointure sur le champ nom avec toujours 2 instances. 
-- Projeter uniquement le nom. Justifier le nombre de lignes.
select e1.nom from exoplus2 e1,exoplus2 e2 
where e1.nom = e2.nom; 

select e1.nom from exoplus2 e1
join exoplus2 e2 on e1.nom = e2.nom; 

select nom from exoplus2 e1
join exoplus2 e2 using(nom); 
-- 1 lance, 2 (julian + Thibaut) , 3 Romain
-- 1x1^2 + 2x2^2 + 1x3^2 = 1 + 8 + 9 = 18
-- 18 lignes

-- Req4 : Faire une jointure sur le champ nom en �liminant les projections 
-- des lignes sur elles-m�mes avec toujours 2 instances. 
-- Projeter uniquement le nom. Justifier le nombre de lignes.
select e1.nom from exoplus2 e1
join exoplus2 e2 on e1.nom = e2.nom
where e1.num <> e2.num; 
-- tout le monde a le m�me nom que lui-m�me. Je retire 8 r�ponses car la table comporte 8 lignes.
-- 10 lignes

-- Req5 : Faire une auto-jointure sur le champ nom en �liminant l les
-- projections des lignes sur elles-m�mes et en �liminant les doublons. 
-- Projeter uniquement le nom. Justifier le nombre de lignes.
select distinct e1.nom
from exoplus2 e1
join exoplus2 e2 on e1.nom = e2.nom
where e1.num <> e2.num;
-- 3 personnes ont des homonymes 
-- 3 lignes

/*15) Donner la liste alphab�tique, class�e sur le nom et le pr�nom, des coureurs ayant des homonymes (m�me nom).*/
select distinct cou1.nom, cou1.prenom from prof.vt_coureur cou1, prof.vt_coureur cou2
where cou1.nom = cou2.nom
and cou1.n_coureur <> cou2.n_coureur
order by cou1.nom, cou1.prenom;

/*16) Donner la liste des villes ayant �t� plusieurs fois ville d�arriv�e (ville_a). Afficher le n� �tape, le n� comp, la ville
d�part, la ville arriv�e et l'ann�e du Tour de France.*/
select distinct et1.n_etape, et1.ville_a, et1.ville_d, et1.n_comp, et1.annee from prof.vt_etape et1, prof.vt_etape et2
where et1.ville_a = et2.ville_a
and (et1.n_etape <> et2.n_etape or et1.n_comp <> et2.n_comp or et1.annee <> et2.annee);

/*16bis) M�me question mais sans afficher l'ann�e. => Parce que si on ne met pas l'ann�e, on n'affiche plus plusieurs fois celles qui ont le m�me n etape, n comp mais pas la m�me annee, cad que si on a le meme n etape, n comp, comme on s'en fiche de l'annee, on le met qu'une fois*/
select distinct et1.n_etape, et1.ville_a, et1.ville_d, et1.n_comp from prof.vt_etape et1, prof.vt_etape et2
where et1.ville_a = et2.ville_a
and (et1.n_etape <> et2.n_etape or et1.n_comp <> et2.n_comp or et1.annee <> et2.annee);

/*17) Donner la liste des diff�rents types d'abandon, m�me les types pour lesquels il n'existe aucun abandon. */
select distinct ab.c_typeaban, ty.c_typeaban, libelle from prof.vt_typeaban ty
left join prof.vt_abandon ab on ab.c_typeaban = ty.c_typeaban;

/*18) Donner la liste des coureurs des �quipes "Astana", "Cofidis" et " Movistar" (v�rifier les noms exacts) ayant
abandonn� dans le Tour 2024. Afficher le nom, le pr�nom, le type d'abandon et les directeurs d'�quipe.
Attention : Chercher le nom exact des �quipes.*/
select * from prof.vt_abandon aba
join prof.vt_coureur cou on cou.n_coureur = aba.n_coureur
join prof.vt_parti_coureur pcou on pcou.annee = aba.annee and pcou.n_coureur = aba.n_coureur
join prof.vt_sponsor spo on spo.n_equipe = pcou.n_equipe and spo.n_sponsor = pcou.n_sponsor
where aba.annee =2024 and (spo.nom = 'ASTANA QAZAQSTAN TEAM' or spo.nom = 'COFIDIS,SOLUTIONS CREDITS' or spo.nom = 'MOVISTAR TEAM');

/*19) Projeter le type d'abandon n'ayant aucun abandon correspondant.*/
select c_typeaban from prof.vt_typeaban
minus
select c_typeaban from prof.vt_abandon;

/*19bis) M�me question mais en affichant �galement le libell�.*/
select c_typeaban, libelle from prof.vt_typeaban
minus
select c_typeaban, libelle from prof.vt_abandon join prof.vt_typeaban using(c_typeaban);

/*20) Projeter les villes ayant �t� ville de d�part et d'arriv�e*/
select  ville_d from prof.vt_etape
intersect
select ville_a from prof.vt_etape;

/*21) Projeter le n� des coureurs ayant termin� le Tour 2024*/
select n_coureur from prof.vt_parti_coureur where annee = 2024
minus
select n_coureur from prof.vt_abandon where annee = 2024;

/*22) Projeter le n� de coureur pour les coureurs ayant particip� � tous les "Tour de France" depuis 10 ans.*/
select n_coureur from prof.vt_parti_coureur where annee = 2015
intersect
select n_coureur from prof.vt_parti_coureur where annee = 2016
intersect
select n_coureur from prof.vt_parti_coureur where annee = 2017
intersect
select n_coureur from prof.vt_parti_coureur where annee = 2018
intersect
select n_coureur from prof.vt_parti_coureur where annee = 2019
intersect
select n_coureur from prof.vt_parti_coureur where annee = 2020
intersect
select n_coureur from prof.vt_parti_coureur where annee = 2021
intersect
select n_coureur from prof.vt_parti_coureur where annee = 2022
intersect
select n_coureur from prof.vt_parti_coureur where annee = 2023
intersect
select n_coureur from prof.vt_parti_coureur where annee = 2024
;
/*23)Afficher le n� d'�quipe et le n� de sponsor des sponsors class�s dans les 10 premiers mais n'ayant jamais
particip� au tour(1) ainsi que les sponsors class�s au-del� des 20 premiers et qui ont particip� au tour(2). (utiliser
vt_ordrequi).*/
select n_equipe, n_sponsor, nom from prof.vt_ordrequi
join prof.vt_sponsor using(n_equipe, n_sponsor)where numero_ordre <= 10;

/*Correction 23)*/
(
  select n_equipe, n_sponsor from prof.vt_ordrequi 
  where numero_ordre<=10
  minus
  select n_equipe, n_sponsor from prof.vt_parti_equipe
)
union
(
  select n_equipe, n_sponsor from prof.vt_ordrequi 
  where numero_ordre>20
  intersect
  select n_equipe, n_sponsor from prof.vt_parti_equipe
);

(
  select n_equipe, n_sponsor,nom from prof.vt_ordrequi 
  join prof.vt_sponsor using(n_equipe,n_sponsor)
  where numero_ordre<=10
  minus
  select n_equipe, n_sponsor,nom  from prof.vt_parti_equipe
  join prof.vt_sponsor using(n_equipe,n_sponsor)
)
union
(
  select n_equipe, n_sponsor,nom from prof.vt_ordrequi 
  join prof.vt_sponsor using(n_equipe,n_sponsor)
  where numero_ordre>20
  intersect
  select n_equipe, n_sponsor,nom  from prof.vt_parti_equipe
  join prof.vt_sponsor using(n_equipe,n_sponsor)
);

/*exoplus n�3*/

Drop table Exoplus3A;
Drop table Exoplus3B;
Drop table Exoplus3C;
create table Exoplus3A (num number(3), nom varchar2(10), section varchar2(1) );
create table Exoplus3B (num number(3), nom varchar2(10), section varchar2(1));
create table Exoplus3C (numSection number(3), section varchar2(1), libelle varchar2(100));
insert into Exoplus3A values (1,'Robert','A');
insert into Exoplus3A values (2,'Simone','A');
insert into Exoplus3A values (3,'Robert','A');
insert into Exoplus3A values (4,'Fabienne','A');
insert into Exoplus3A values (5,'Christelle','A');
insert into Exoplus3A values (6,'Laurent','A');
insert into Exoplus3A values (7,'Robert','A');
insert into Exoplus3A values (8,'Robert','A');
insert into Exoplus3A values (9,'Simone','A');
insert into Exoplus3B values (1,'Robert','B');
insert into Exoplus3B values (2,'Robert','B');
insert into Exoplus3B values (3,'Laurent','B');
insert into Exoplus3B values (4,'Philippe','B');
insert into Exoplus3B values (5,'Sylvian','B');
insert into Exoplus3B values (6,'Laurent','B');
insert into Exoplus3B values (7,'Christelle','B');
insert into Exoplus3B values (8,'Christelle','B');
insert into Exoplus3C values (1,'A','Sport');
insert into Exoplus3C values (2,'B','Musique');
insert into Exoplus3C values (3,'C','Th�atre');
commit;

select nom from Exoplus3A;
/*renvoi les 9 noms de exoplus3a*/

select nom from Exoplus3A
union
select nom from Exoplus3A;
/*5 lignes car l'union fait automatiquement un distinct sur les deux tables*/

select nom from Exoplus3A
intersect
select nom from Exoplus3A;
/* 5 lignes car l'intersect fait automatiquement un distinct et il prend tous ceux qui sont dans les deux tables*/

select nom from Exoplus3A
minus
select nom from Exoplus3A;
/* 0 lignes car le minus va enlever tout du premier select avec le deuxi�me */

select * from Exoplus3A
intersect
select * from Exoplus3B;
/*0 Comme on s�lectionne depuis deux tables diff�rentes et qu'on regarde celles qui sont dans les deux, il y en a aucune (deni�re colonne pas la m�me)*/

select num,nom from Exoplus3A
intersect
select num,nom from Exoplus3B;
/*2 On ne s'occupe plus de la derni�re colonne et on regarde ceux qui sont identiques en les distinctant*/

select nom from Exoplus3A
intersect
select nom from Exoplus3B;
/*3 On ne s'occupe plus de la derni�re colonne ni du num�ro et on regarde ceux qui sont identiques en les distinctant*/

select num, nom from Exoplus3A
intersect
select nom from Exoplus3B;
/* On ne peut faire un intersect que sur le m�me nombre de colonnes et de m�me type*/

select num from Exoplus3A
intersect
select nom from Exoplus3B;
/* On ne peut faire un intersect que sur le m�me nombre de colonnes et de m�me type*/

select * from Exoplus3A
union
select * from Exoplus3B;
/* 17 Montre les deux ensemble*/

select num,nom from Exoplus3A
union
select num,nom from Exoplus3B;
/* 15 Montre les deux ensemble sans s'occuper de la section en distinguant ceux qui ont le m�me num et le m�me nom*/

select nom from Exoplus3A
union
select nom from Exoplus3B;
/*7 Montre les deux ensemble en ne s'occupant que des noms et en les distinguants*/

select nom from Exoplus3A
union all
select nom from Exoplus3B;
/*17 Car union all enl�ve le distinct*/

select * from Exoplus3A
minus
select * from Exoplus3B;
/*9 N'affiche pas la table B car on l'enl�ve � A, mais aucun de B n'est dans A, pas de changements*/

select num,nom from Exoplus3A
minus
select num,nom from Exoplus3B;
/*7 M�me chose sauf qu'on enl�ve ceux qui ont le m�me num et le m�me nom sans s'occuper maintenant de la section*/

select nom from Exoplus3A
minus
select nom from Exoplus3B;
/*2 M�me chose sauf qu'on enl�ve ceux qui ont le m�me nom sans s'occuper maintenant de la section*/

select section, libelle from Exoplus3C
minus
select section, libelle from Exoplus3B join Exoplus3C Using(section)
minus
select section, libelle from Exoplus3A join Exoplus3C Using(section);

select 3+4,'Monsieur' ,nom as sonnom from prof.vt_coureur where n_coureur<150;
/*Une colonne avec 'Monsieur' dedans*/

select 'Monsieur ' || nom from prof.vt_coureur where n_coureur<150;
/*M�me chose mais joint dans la colonne d'apr�s*/

select nom,'toto' from prof.vt_coureur where n_coureur<150
union
select nom,'titi' from prof.vt_coureur where n_coureur<150;
/*toto*/

select nom,'toto' as res1 from prof.vt_coureur where n_coureur<150
union
select nom,'titi' as res2 from prof.vt_coureur where n_coureur<150;
/*RES1 car alias et res2 va se retrouver dans res1*/

select nom,'toto' as res from prof.vt_coureur where n_coureur<150
union
select nom,'titi' as res from prof.vt_coureur where n_coureur<150;
/*Permet de changer le nom de la colonne de toto et titi*/

select nom from prof.vt_coureur
union
select date_etape from prof.vt_etape;
/*erreur car pas m�me type*/

select nom from prof.vt_coureur
union
select to_char(date_etape) from prof.vt_etape;
/*Permet de changer le type de la date en texte, ce qui le rend compatible avec le type de nom*/

select upper(nom) from prof.vt_coureur
intersect
select upper(to_char(prenom)) from prof.vt_coureur;
/*Faire en sorte qu'on puisse comparer sans se soucier des majuscules et minuscules*/

select upper(nom) from prof.vt_coureur where upper(nom) like '%AR%'
intersect
select upper(to_char(prenom)) from prof.vt_coureur;
/*Prend les oms et pr�noms qui sont identiques et qui ont AR*/

select upper(nom),n_coureur from prof.vt_coureur
intersect
select upper(to_char(prenom)),n_coureur from prof.vt_coureur;
/*Il n'y a aps de coureurs portant le m�me num�ro qui ot*/

select n_equipe,n_sponsor,nom from prof.vt_sponsor
union
select n_equipe,n_sponsor,nom from prof.vt_parti_coureur;
/*erreur car le nom de colonne "nom" est pr�sent � la fois dans parti_coureur et dans sponsor"*/

select n_equipe,n_sponsor,nom from prof.vt_sponsor
minus
select n_equipe,n_sponsor,nom from prof.vt_parti_coureur
join vt_sponsor using(n_equipe,n_sponsor);

/*24) [Important] Donner la liste des �tapes 8 � 12 du Tour 2024 en affichant dans la m�me colonne la distance et la
moyenne (sur deux lignes diff�rentes). Afficher le n� de l'�tape, la ville d�part, la ville arriv�e, les cha�nes de
caract�res "distance" et "moyenne" dans une colonne nomm�e "libell�" et les valeurs de distance et de moyenne
dans une colonne nomm�e "r�sultat".*/
select n_etape, ville_d, ville_a, 'la distance est :' as libelle, distance as resultat from prof.vt_etape
where annee = 2024 and n_etape > 7 and n_etape < 13
union
select n_etape, ville_d, ville_a, 'la moyenne est :' as libelle, moyenne as resultat from prof.vt_etape
where annee = 2024 and n_etape > 7 and n_etape < 13 order by n_etape;

/*25) Tester une vue "v_aban_25" permettant d'afficher la liste des jeunes coureurs (ann�e, n�_�quipe, n� de sponsor, n�
de coureur et n� de dossard) ayant abandonn� quelle que soit l'ann�e.*/

CREATE OR REPLACE VIEW v_aban_25 as
SELECT par.annee, n_equipe, n_sponsor, par.n_coureur, n_dossard
FROM vt_parti_coureur par
join vt_abandon aba on aba.n_coureur = par.n_coureur and aba.annee = par.annee
where jeune = 'o';

/*26) Tester et commenter les requ�tes suivantes :*/

-- a
desc v_aban_25;
-- Montre les attributs de la vue v_aban_25 cr��s avec ceux s�lectionn�s dans la requ�te associ�e � la vue

-- b.Lancer l'ex�cution de la vue cr��e pr�c�demment en classant les coureurs sur le n� de coureur
select * from v_aban_25 order by n_coureur;
select * from v_aban_25 order by 4;
-- Fait la m�me chose (tri la vue par la 4e colonne, soit la colonne n_coureur
select * from v_aban_25 where rownum < 5 order by n_coureur; 
-- Prend 4 lignes dans la table et els tri

--c. Tester les requ�tes suivantes
select * from user_views;
select * from all_views where owner like 'ETU1%' ;
select * from all_users;

--d. Afficher 
select * from user_catalog; 
select distinct table_type from user_catalog; 
select * from user_objects; 
select distinct object_type from user_objects; 
PURGE recyclebin;

--e.Renommer la vue cr��e pr�c�demment par "v_aban_jeune"
drop view v_aban_jeune;
rename v_aban_25 to v_aban_jeune;
select * from v_aban_jeune;

/*27) En utilisant la vue cr��e pr�c�demment, donner la liste des jeunes coureurs ayant abandonn� le Tour en 2024.
Afficher le nom, le pr�nom, le n� de dossard et le nom de l'�quipe (sponsor).*/

select cou.nom, prenom, n_dossard, spo.nom from v_aban_jeune
join vt_coureur cou using (n_coureur)
join vt_sponsor spo using (n_equipe, n_sponsor)
where annee = 2024;

/*28) Sauvegarder les requ�tes 13 et 14 sous forme de vues "v_req13" et v_req14".*/

create or replace view v_req13 as select nom,prenom,n_sponsor,n_equipe from prof.vt_coureur
join prof.vt_parti_coureur using(n_coureur)
where jeune = 'o' and annee = 2024
order by(nom);

create or replace view v_req14 as select nom, prenom, c_typeaban from prof.vt_coureur
join prof.vt_parti_coureur using(n_coureur)
left join prof.vt_abandon using(n_coureur, annee)
where annee = 2024;

/*29) R�-ex�cuter les requ�tes 13 et 14, ind�pendamment, en utilisant la vue cr��e pr�c�demment.*/

select * from v_req13;
select * from v_req14;

/*30) Afficher toutes les colonnes de la vue v_req13 en compl�tant la projection par le nom du sponsor. Le r�sultat sera
class� sur le nom de l��quipe (sponsor) et le nom du coureur.
*/

select req.nom, prenom, n_sponsor, n_equipe, spo.nom as nom_sponsor from v_req13 req
join vt_sponsor spo using(n_sponsor, n_equipe)
order by spo.nom, req.nom;

-- nom des coureurs qui ont particip�s
select nom from vt_coureur where n_coureur in
(
 select n_coureur from vt_parti_coureur
);

/* on selectionne les noms des coureurs qui sont parti*/

-- coureurs qui n'ont jamais abandonn�
select * from vt_parti_coureur where n_coureur not in
(
 select n_coureur from vt_abandon
);
/* on prend tous ceux qui ne sont pas dans abandon*/

select * from vt_parti_coureur where annee = 2008 and(n_coureur,annee) not
in
(
 select n_coureur,annee from vt_abandon
);

/*31) Afficher les coureurs ayant abandonn� en 2024 class�s par annee de naissance.*/
select * from vt_coureur where n_coureur in
(
select n_coureur from vt_abandon where annee=2024
)
order by annee_naissance;

/*32) Afficher les coureurs n'ayant pas particip� � un tour de France au 21? si�cle.*/
select * from vt_coureur where n_coureur not in
(
select n_coureur from vt_parti_coureur where annee > 2000
);

/*33) Afficher le nom et pr�nom coureurs ayant appartenu l'�quipe AG2R-CITROEN TEAM.*/
select nom,prenom from vt_coureur where n_coureur in
(
    select n_coureur from vt_parti_coureur where (n_equipe,n_sponsor) in
    (
        select n_equipe,n_sponsor from vt_sponsor where nom = 'AG2R-CITROEN TEAM'
    )
);

/*34) M�me question en projetant en plus la nationalit� (code_cio) du coureur*/
select nom,prenom,code_cio from vt_coureur
join vt_app_nation using(n_coureur)
where n_coureur in
(
    select n_coureur from vt_parti_coureur where (n_equipe,n_sponsor) in
    (
        select n_equipe,n_sponsor from vt_sponsor where nom = 'AG2R-CITROEN TEAM'
    )
);
/*35) Afficher les coureurs n'ayant pas abandonn� en 2024.*/
select n_coureur from vt_parti_coureur where n_coureur not in
(
select n_coureur from vt_abandon where annee = 2024
)
and annee = 2024;

/*36) plut�t difficile Afficher la liste des coureurs (tous les champs) n'ayant pas pris le d�part d'un Tour de France (l'absence
au d�part du Tour est consid�r� comme un abandon).*/
select * from vt_parti_coureur where (n_coureur, annee) not in
(
    select n_coureur, annee from vt_temps
)
and (n_coureur,annee) in
(
    select n_coureur, annee from vt_abandon where c_typeaban = 'NP'
);

Drop table exoplus4A;
Drop table exoplus4B;
create table exoplus4A(es4a_num int, es4a_nom char(20));
create table exoplus4B(es4b_num int, es4b_ville char(20));
insert into exoplus4A values (1,'Robert');
insert into exoplus4A values (2,'Sylvian');
insert into exoplus4A values (2,'Laurent');
insert into exoplus4A values (4,'Christelle');
insert into exoplus4A values (4,'Philippe');
insert into exoplus4A values (4,'Philippe');
insert into exoplus4A values (6,'Fabienne');
insert into exoplus4B values (1,'Caen');
insert into exoplus4B values (2,'Ifs');
insert into exoplus4B values (3,'Troarn');
insert into exoplus4B values (4,'Fleury');
commit;

/*1) Ex�cuter et commenter la requ�te suivante : justifier les r�sultats. => Toutes les personnes qui portent le num�ro 4 est �gal au num�ro 4 dans la table des villes dont le nom est 'Fleury', en gros tous ceux dont le numero correspond � la ville de fleury*/
select * from exoplus4A where es4a_num = 
(
 select es4b_num from exoplus4B where es4b_ville='Fleury'
);

/*2) Ex�cuter et commenter la requ�te suivante : justifier les r�sultats => M�me chose pour flers, mais flers n'est pas dans la table, donc il n'y a personne qui a le num de flers.*/
select * from exoplus4A where es4a_num = 
(
 select es4b_num from exoplus4B where es4b_ville ='Flers'
);

/*3) Ex�cuter et commenter la requ�te suivante : justifier les r�sultats. =>1 ligne peut �tre = � 3 autres, mais 3 lignes ne peuvent pas �tre = � 1, il faut utiliser in*/
select * from exoplus4b where es4b_num = 
(
 select es4a_num from exoplus4A where es4a_nom ='Philippe'
);

/*4) Ex�cuter et commenter la requ�te suivante : justifier les r�sultats. => affiche les gens qui sont dns n'importe quelle ville*/
select * from exoplus4A where
es4a_num = any
(select es4b_num from exoplus4B );

/*5) Ex�cuter et commenter la requ�te suivante : justifier les r�sultats. => Personne n'est dans toutes les villes*/
select * from exoplus4A where
es4a_num = all 
(select es4b_num from exoplus4B );

/*6) Ex�cuter et commenter la requ�te suivante : justifier les r�sultats. => Affiche les personnes qui ne sont pas dans n'importe quelle ville qui s'appelle fleury*/
select * from exoplus4A where
es4a_num != any
(
 select es4b_num from exoplus4B where es4b_ville ='Fleury' 
);

/*7) Ex�cuter et commenter la requ�te suivante?: justifier les r�sultats. => Affiche les personnes qui ne sont pas dans toutes les villes, donc qui sont dans aucune*/
select * from exoplus4A where
es4a_num != all 
(
 select es4b_num from exoplus4B 
);

/*8) Ex�cuter et commenter la requ�te suivante. Comparer l� � la requ�te 4. => L� c'est ceux qui sont dans une ville, on se soucie de savoir s'ils sont dans une au moins, alors qu'� la question 4, on tente de savoir s'ils sont dans n'iporte quelles des villes*/
select * from exoplus4A where
es4a_num in 
(
 select es4b_num from exoplus4B
);

/*9) Ex�cuter et commenter la requ�te suivante. Comparer la � la requ�te 7. => M�me chose, mais l�, on dit qui n'est pas dans une ville, alors qu'avant c'�tait qui est dans pas toutes les villes*/
select * from exoplus4A where
es4a_num not in 
(
 select es4b_num from exoplus4B
);

/*10) Ex�cuter et commenter la requ�te suivante. Comparer l� � la requ�te 6. => M�me chose, affiche les personnes qui ne sont pas dans fleury*/
select * from exoplus4A where
es4a_num not in 
(
 select es4b_num from exoplus4B where es4b_ville ='Fleury' 
);

/*11) R�aliser l'�quivalent de la requ�te 7 sans utiliser les sous-requ�tes.*/
select es4a_num,es4a_nom from exoplus4A
minus
select es4b_num,es4a_nom from exoplus4B join exoplus4A on es4b_num = es4a_num;

/*12) R�aliser l'�quivalent de la requ�te 8 sans utiliser les sous-requ�tes*/
select es4a_num,es4a_nom from exoplus4A
intersect all
select es4b_num,es4a_nom from exoplus4B join exoplus4A on es4b_num = es4a_num;

/*13) Afficher de deux fa�ons diff�rentes les villes dans lesquelles vivent des personnes de la table exoplus4A.*/
select distinct es4b_num,es4b_ville from exoplus4B join exoplus4A on es4a_num=es4b_num;

select es4b_num, es4b_ville from exoplus4B
intersect
select es4a_num, es4b_ville from exoplus4A join exoplus4B on es4a_num=es4b_num;

/*37) Projeter par ordre alphab�tique des noms, les coureurs arriv�s entre la 1�re et la 20� places dans l'�tape 1 du Tour
2024.*/
select * from vt_coureur where n_coureur in
(
    select n_coureur from vt_parti_coureur where (n_coureur, annee) in
    (
        select n_coureur, annee from vt_temps where rang_arrivee < 21 and n_etape = 1 and annee = 2024
    )
)
order by nom;

/*38) Projeter la liste des coureurs (nom,pr�nom) ainsi que le nom du sponsor ayant gagn� une ou plusieurs �tapes du
tour 2005.*/

select co.nom as
nom_coureur,prenom,sp.nom as
nom_sponsor
from vt_coureur co
join vt_parti_coureur using(n_coureur)
join vt_sponsor sp using(n_equipe, n_sponsor)
where (n_coureur, annee) in
(
    select n_coureur, annee from vt_temps where annee=2005 and rang_arrivee=1
);

/*38 bis) M�me question mais, on demande de projeter le nom des sponsors uniquement. Bien respecter les r�gles d'or !*/

select nom from vt_sponsor where (n_equipe, n_sponsor) in
(
    select n_equipe, n_sponsor from vt_parti_coureur where (n_coureur, annee) in
    (
        select n_coureur, annee from vt_temps where annee=2005 and rang_arrivee=1
    )
);

/*39) Projeter le sponsor dont le coureur a remport� l'�tape dont la ville de d�part est {BORDEAUX | GAP | CAEN}
La requ�te devra contenir 3 sous-requ�tes imbriqu�es.*/

select nom from vt_sponsor where (n_equipe, n_sponsor) in
(
    select n_equipe, n_sponsor from vt_parti_coureur where (n_coureur, annee) in
    (
        select n_coureur, annee from vt_temps where rang_arrivee=1 and (annee, n_etape, n_comp) in
        (
            select annee, n_etape, n_comp from vt_etape where upper(ville_d)='BORDEAUX' 
            or upper(ville_d)='CAEN' or upper(ville_d)='GAP'
        )
    )
);

/*40) Projeter les �tapes du Tour 2024 dont la distance est la plus longue (pas de fonction d'agr�gat).*/
select * from vt_etape where annee=2024 and distance >= all 
(
    select distance from vt_etape where annee=2024
);

/*41) Projeter les �tapes de plus faible moyenne non vide en 2024. (pas de fonction d'agr�gat) */
select * from vt_etape where annee=2024 and moyenne <= all 
(
    select moyenne from vt_etape where annee=2024
);
        /*exoplus n�5*/
        desc dual;
        /*affiche le type*/
-- dummy = factice
--1.1
select 1 un,2,3,4 from dual;
/*affiche les attribut en renommant la premi�re colonne 1 en un*/
--1.2
select user from dual;
/*affiche l'utilisateur*/
--1.3
select ' create user ETU1_'||level ||';' valeur from dual connect by level <= 90;
/*cr�er des utilisateurs dont le d�but commence par ETU1_ avec � la fin un nombre allant de 1 � 90, 90 fois*/
--1.4
select 'chateau' exemple from dual;
/*cr�er une colonne exemple avec une ligne comportant la chaine de caract�re 'chateaux'*/
--1.5
select 'Monsieur ' || nom as exemple from vt_coureur;
/*affiche la colonne nom avec la chaine de caract�re monsieur devant l'attribut*/
--1.6
select 'chat'||'eau' exemple from dual;
/*cr�er une colonne exemple comportant deux chaine de caract�re fusionn�e*/
select prenom||' '||nom exemple from vt_coureur where prenom like 'Rob%' or prenom like '%ert';
/* affiche une colonne exemple comportant prenom et le nom avec un espace rajouter au milieu dont le nom comporte les prem�re lettres rob ou les derni�re lettre ert*/
--1.7
--1.8
select 1 + 3 from dual;
/*cr�er une colonne avec le r�sultat de 1+3*/
--1.9
select 1 + 3 as resultat from dual;
/*pareil sauf que l'on renomme la colonne r�sultat*/
--1.10
select 1 - 3 as r�sultat from dual;
/*pareil que la 1.10*/
--1.11
select 1 / 0 as r�sultat from dual;
/* affiche une erreur car il est impossible de diviser par 0*/
--1.12
select annee,ville_d,ville_a,moyenne from vt_etape where moyenne is null;
/*affiche les �tapes n'ayant aucune distance moyenne*/
select annee,ville_d,ville_a,nvl(moyenne,0) as moy from vt_etape where moyenne is null;
/*pareil sauf que l'on modifie la moyenne pour qu'elle affiche 0*/
select annee,ville_d,ville_a,nvl(to_char(moyenne),'INCONNUE') as moy
from vt_etape where moyenne is null;
/*pareil sauf que l'on remplace la moyenne par inconnue*/
select annee,ville_d,ville_a,nvl(to_char(moyenne),'inconnue') as moy from vt_etape where annee=1996;
/*affiche inconnue seulement lorsque l'�tape n'a pas de distance moyenne*/ 
select 10 +10+10+ null as r�sultat from dual;
/*affiche rien */
select 10+10+10 + nvl(null,9) as r�sultat from dual;
/*affiche le r�sultat plus 9*/

--2.1.
select sysdate+10.1 as dater from dual;
/*affiche la date dans 10 jours*/
select to_char(sysdate+10.1,'dd/mm/yyyy hh24:mi:ss') from dual;
/*pareil avec l'heure en plus*/
select to_date('2010','yyyy') from dual;
/*affiche le 1er novembre 2010*/
select to_char(sysdate,'dd/mm/yyyy HH24:mi:ss') from dual;
/*affiche l'heure et la date actuel*/
select to_char(sysdate,'dd/mm/yy') from dual;
/*affiche la date sous forme de chaine de caract�re*/
select to_char(sysdate,'dd') from dual;
/*affiche le jour actuel*/
--2.2
select to_char(date_etape,'dd/mm/yyyy HH:mi:ss') from vt_etape;
/*affiche une erreur car date_etape est mal orthographi� sinon affiche les dates des diff�rentes �tapes*/
select date_etape from vt_etape ;
/*pareil mais n'affiche pas l'heure*/
--2.3
select to_char(date_etape,'YYYY') +1 from vt_etape;
/*affiche les ann�es en rajoutant 1 ans de plus*/
--2.4
select to_date('15/10/1985','DD/MM/YYYY') from dual;
/*cr�er une colonne et convertit la chaine de caract�re en date*/
select to_date('10-15-1985','MM-DD-YYYY') from dual;
/*pareil mais en pla�ant le mois avant le jour (date anglaise)*/
select to_char(to_date('10-15-1985','MM-DD-YYYY'),'dd/MM/YYYY') from dual;
/*cr�er une colonne avec une chaine de caract�re qui est convertit en date anglaise puis est convertit en chaine de caract�re en inversant le jour et le mois*/
select to_date('2005','yyyy') from dual;
/*cr�er une date avec l'ann�e 2005*/
select sysdate - to_char(date_etape,'dd/mm/yyyy') from vt_etape ;
/*on ne peut pas soustraire une chaine de caract�re � une date*/
select sysdate - date_etape from vt_etape where annee=2017;
/*affiche le nombre de jour s�parant aujourd'hui est la date �tape lors de l'ann�e 2017*/
select sysdate - to_date('01/04/1985','dd/mm/yyyy') from dual ;
/*affiche le nombre de jour entre aujourd'hui et le 01/04/1985*/
select round(( sysdate - to_date('01/04/1985','dd/mm/yyyy'))/365,3) as age from dual ;
/*pareil sauf que l'on convertit les jour en ann�es*/
select to_char(sysdate,'year') from dual ;
/*affiche la date en lettre*/
select to_char(sysdate,'month') from dual ;
/*affiche le mois en lettre*/
select to_char(sysdate,'day') from dual ;
/*affiche le jour de la semaine*/
drop table essaiDate;
create table essaiDate
(
date1 date,
date2 timestamp
);
insert into essaiDate values (sysdate,sysdate);
select * from essaiDate;
--2.5
select date_etape from vt_etape where n_etape=1 and annee=2017;
/*affiche la date de la prmi�re �tape du tour de france de 2017*/
--2.6
select date_etape from vt_etape where n_etape=21 and annee=2017;
/*affiche la date de la 21eme �tape du tour de france de 2017*/
select
(
(select date_etape from vt_etape where n_etape=20 and annee=2009)
-
(select date_etape from vt_etape where n_etape=1 and annee=2009)
)
as nbJours from dual;
/*affiche le nombre de jours entre l'�tape 1 et l'�tape 20*/
select
(
(select to_number(to_char(date_etape,'DD')) from vt_etape where n_etape=20 and annee=2009)
-
(select to_number(to_char(date_etape,'DD')) from vt_etape where n_etape=1 and annee=2009)
)
as nbJours from dual;
/*convertit le nombre de jours entre les deux �tape*/

select
(
(select date_etape from vt_etape where annee=2024 and n_etape >= all(select n_etape from vt_etape where annee=2024))
-
(select date_etape from vt_etape where annee=2024 and n_etape <= all(select n_etape from vt_etape where annee=2024))
-
(select jour_repos from vt_annee where annee=2024)
)+1
as nbJours from dual;

/*43) Difficile Donner la liste des coureurs arriv�s premiers � une �tape en 2017. Le pays d'origine du coureur doit �tre le
m�me que celui de la ville de d�part de l'�tape o� le coureur a gagn�. Afficher les caract�ristiques de "coureur". Traiter
la r�ponse sous la forme d�une requ�te principale et de 3 sous-requ�tes imbriqu�es. Expliquer pourquoi la
synchronisation est obligatoire. Voir sch�mas des solutions 1 et 2 ci-dessous*/

select * from vt_coureur cou 
where n_coureur in
(
    select n_coureur from vt_app_nation 
    where code_cio in 
    
    (
        select code_cio_d from vt_etape 
        where (annee,n_etape,n_comp) in 
        (
            select annee,n_etape,n_comp from vt_temps_2017 tp
            where rang_arrivee =1
            and tp.n_coureur = cou.n_coureur
        )
    )
);

/*44) Donner la liste des coureurs ayant gagn� au moins une �tape en 2024. Utiliser une requ�te synchronis�e avec
exists.*/

select * from vt_coureur cou
where exists
(
    select * from vt_temps where rang_arrivee=1 and annee=2024 and cou.n_coureur = n_coureur
);

/*45) Projeter les 5 premiers coureurs par liste alphab�tique invers�e des noms (aucun rapport avec les requ�tes
synchronis�es).*/

select nom from vt_coureur
order by nom desc
fetch first 5 rows only;

/*46) Pour chaque �tape de 1988, projeter le num�ro, la distance et le type d'�tape en clair sachant que :*/

select n_etape, distance, cat_code,
decode(cat_code, 'PRO', 'prologue', 'CMI', 'contre la montre', 'CME', 'contre la montre en equipe', 'ETA', 'etape en ligne','bizarre') as type_etape from vt_etape
where annee=1988;

/*47) Projeter les pr�noms des coureurs contenant des caract�res comme '�' ou '�' ou '�' ou '�'. Afficher le pr�nom sous
forme de texte (classique) et sous forme hexad�cimale (avec dump).*/

select prenom, dump(to_char(prenom),16) from vt_coureur;
select prenom, dump(prenom, 16) from vt_coureur;
select prenom, dump(prenom, 10) from vt_coureur;

select distinct prenom, dump(prenom, 16), dump(to_char(prenom),16) from vt_coureur
where prenom like '%�%' or  prenom like '%i%' or  prenom like '%�%' or  prenom like '%�%'
order by prenom;


/*48) Projeter les �tapes disput�es en dehors de juillet*/
select annee, ville_d, ville_a, date_etape
from vt_etape where to_char(date_etape, 'MM') <> 07;

/* exoplus 6 */

Select * from vt_etape;
/* affiche toute les colonne de la table etape*/
Select n_etape from vt_etape;
/*affiche le num�ro de l'�tape*/
Select moyenne from vt_etape;
/*affiche la distance moyenne de chaque �tape*/
Select count(*) from vt_etape;
/*affiche le nombre de ligne dans la table*/
Select count(*) as nb from vt_etape;
/*idem mais change le nom de la colonne*/
Select count(n_etape) as nb from vt_etape;
/*idem mais en comptant las ligne de n_�tape, nombre d'�tape sur plusieur ann�e*/
Select count (moyenne) as nb from vt_etape;
/*compte le nombre de moyenne en excluant les valeurs nul*/
Select max(total_seconde) as maxi, min(total_seconde) as mini,
round(avg(total_seconde),4) as moyenne from vt_temps;
/*affiche la moyenne maximum, minimum et la moyenne de la moyenne arroundie 4 chiffres apr�s la virgule*/
Select sum(total_seconde) as somme,count(total_seconde) as nombre from vt_temps;
/*affiche la somme de toutes les secondes, compte le nombre de ligne de la colonne total_seconde */
Select sum(total_seconde) as somme,count(*) as nombre from vt_temps;
/* idem sauf compte le nombre de ligne dans la table */
select n_coureur from VT_PARTI_COUREUR order by n_coureur;
/*produit cart�sien du nombre de coureur*/
select count(*) from VT_PARTI_COUREUR ;
/*compte le nombre de ligne dans la table coureur*/
select count(*),n_coureur from VT_PARTI_COUREUR order by n_coureur;
/*ne fonctionne pas car n_coureur n'a pas le m�me nombre de ligne que la table, count affiche qu'une ligne*/
select n_coureur, count(*) as nb from VT_PARTI_COUREUR
group by n_coureur
order by nb desc;
/* affiche le nombre de coureur qui ont participer par rang d'arriv�  */
select n_coureur,n_equipe,count(*) as nb
from VT_PARTI_COUREUR
group by n_coureur
order by nb,n_equipe desc;
/*ne fonctionne pas car group ne possède pas le même nombre de colonne que select*/
select n_coureur,n_equipe,count(*) as nb_tours from VT_PARTI_COUREUR
group by n_equipe ,n_coureur
order by 1,2 desc;
/*affiche le numéro coureur avec le numéro équipe avec le nombre de tour effectuer*/
/* 2)*/
select n_coureur from vt_temps order by n_coureur desc;
/*ordonne le numéro de coureur par ordre décroissant*/
select distinct n_coureur from vt_temps order by n_coureur desc;
/*ordonne le numéro de coureur par ordre décroissant un seul numéro*/
select count(*) from vt_temps ;
/*compte le nombre de ligne*/
select n_coureur from vt_temps where n_coureur > 1760;
/*ordonne le numéro de coureur par ordre décroissant tant que le n_coureur > 1760*/
select n_coureur from vt_temps having n_coureur > 1760;
/*manque group by*/
select n_coureur from vt_temps where n_coureur > 1760 group by n_coureur ;
select n_coureur from vt_temps having n_coureur > 1760 group by n_coureur ;
select count(*) from vt_temps where n_coureur > 1760 ;
select count(*) from vt_temps having n_coureur > 1760 ;
select count(*) from vt_temps where n_coureur > 1760 group by n_coureur ;
select count(*) from vt_temps having n_coureur > 1760 group by n_coureur ;select count(*) as nb from vt_temps where count(*) > 300
group by n_coureur ;
select count(*) from vt_temps having count(*) > 300 group by n_coureur ;
select n_coureur from vt_temps having count(*) > 300 group by n_coureur ;
select sum(total_seconde),avg(total_seconde) from vt_temps having max(total_seconde) > 31000;
/*3)*/
select n_coureur,n_equipe,count(*) as nb_par from VT_PARTI_COUREUR
group by n_coureur,n_equipe
where count(*) > 12
order by n_coureur;
select n_coureur,n_equipe,count(*) as nb_par from VT_PARTI_COUREUR
group by n_coureur,n_equipe
where nb_par > 12
order by n_coureur;
select n_coureur from VT_PARTI_COUREUR
group by n_coureur
having count(*) >12
order by n_coureur;
select n_coureur from VT_PARTI_COUREUR
group by n_coureur
having count(*) = 18;
select n_coureur from VT_PARTI_COUREUR
group by n_coureur
having count(*) =
(
select max(count(n_coureur)) from VT_PARTI_COUREUR
group by n_coureur
);
/*4)*/
select annee, cat_code, count(*) as nb_km from vt_etape
group by rollup (annee,cat_code)
order by annee desc,nb_km desc;
select annee, cat_code, count(*) as nb_km from vt_etape
group by cube (annee,cat_code)
order by annee desc,nb_km desc;
/*mettre un alias pour count(*)*/
/*quand on utilise une fonction d'agrégation on met les colonnes simple dans le group by*/
/*ne pas utiliser un where avec une foction d'agrégation */

/*49 a) Nombre total de coureurs dans la base de données*/
select count(*) as nb_coureur from vt_coureur;

/*49 b) On veut le même nombre de réponses que précédemment mais à partir de l’objet " parti_coureur "*/
select count(*) as nb_coureurs from
(
    select count(count(*)) as nb from vt_parti_coureur
);

/*50) Donner le nom et prénom du coureur ayant le nom le plus long (voir fonction length).*/
select nom, prenom from VT_COUREUR
where length(nom) =
(
select max(length(nom)) from VT_COUREUR
);

/*51) Afficher le nombre de coureurs ayant terminé le Tour 2024 (ceux qui n’ont pas abandonné par exemple)*/

select count(*) as nb from vt_parti_coureur where annee=2024
and n_coureur not in
(
    select n_coureur from vt_abandon
    where annee=2024
);

/*52) Donner le temps maximum, le temps minimum et le temps moyen de la première étape de 2024. Arrondir pour la
moyenne.*/
select max(total_seconde) as maxi, min(total_seconde) as mini, round(avg(total_seconde),2) as moyenne from vt_temps 
where annee=2024 and n_etape =
(
    select min(n_etape) from vt_temps where annee =2024
);
/*solution 3*/

select max(total_seconde) || ' s ' as temps_maximum,
min(total_seconde) || ' s ' as temps_minimum,
round(avg(total_seconde), 2) || ' s ' as temps_moyen
from vt_temps t where annee= 2024 and n_etape = 
(
    select min(n_etape) from vt_etape where annee= t.annee
);




/*53) Afficher pour chacun des Tours : l'ann�e, le dernier jour, le 1er jour, le nombre de jours entre le dernier jour et le
1er jour, le nombre d'�tapes, le nombre de jours de repos.*/

select annee, max(n_etape+1)-min(n_etape) as nb_etape, max(date_etape)-min(date_etape) as nb_jour, min(date_etape) as date_de_debut, max(date_etape) as date_fin, jour_repos 
from vt_etape
join vt_annee using (annee)
group by annee, jour_repos;

/*54) Projeter en heures, le temps maximum et le temps minimum pass� sur un v�lo dans une �tape du Tour 2024. On
souhaite un affichage du type*/

select round(max(total_seconde/3600),2) || 'h' as heure_max, to_char(min(total_seconde/3600),'999990D00') || 'h' as heure_min from vt_temps
where annee =2024;

/*55)  Afficher le nombre de types distincts d'abandons constat�s*/

select count(*) as nb from 
(
    select distinct count(*), c_typeaban from vt_abandon
    group by c_typeaban;
);

select count(count(*)) as nb 
from vt_abandon group by c_typeaban;

/*56) Afficher l'ann�e, le n� d'�tape, le type d'abandon et le nombre d�abandons par type pour l�ann�e 2024. Le r�sultat
projet� sera class� par ordre croissant sur le num�ro d'�tape.*/

select * from vt_abandon;
select * from vt_typeaban;

select distinct annee, n_etape, c_typeaban, count(c_typeaban) as nb_type_abandon from vt_abandon
where annee =2024
group by annee, n_etape, c_typeaban;

/*57 a) Important Afficher les types d�abandon, le nombre d�abandons par type, le total des abandons pour l�ann�e 2024. 
Toutes les solutions sont demand�es. */

/* solution 1 */

create or replace view vt_nb_aban_total ( abandon_total)
as select count(c_typeaban) 
from vt_abandon
where annee =2024;

create or replace view vt_nb_aban (type_abandon, nb_abandon)
as select c_typeaban, count(c_typeaban) 
from vt_abandon
where annee =2024
group by c_typeaban;

select * from vt_nb_aban_total cross join vt_nb_aban;

/* solution 2 */

select c_typeaban, count(c_typeaban), abandon_total 
from vt_abandon cross join vt_nb_aban_total
where annee =2024
group by c_typeaban, abandon_total;

/* solution 3 */
select c_typeaban, count(c_typeaban), nb_total
from vt_abandon cross join (select count(c_typeaban) as nb_total from vt_abandon where annee =2024)
where annee =2024
group by c_typeaban, nb_total;

/* solution 4 */

select c_typeaban, count(c_typeaban), (select count(c_typeaban) as nb_total from vt_abandon where annee =2024) as nb_total
from vt_abandon 
where annee =2024
group by c_typeaban;

/*58) Afficher les noms et pr�noms des coureurs avec leur nombre de participations pour ceux ayant particip� plus de 10
fois au tour. Trier par ordre d�croissant de participations.*/

select nom, prenom, count(*) as nb from vt_coureur
join vt_parti_coureur using (n_coureur)
having count(*) > 10
group by nom, prenom
order by nb desc;

/*59) Afficher les noms et pr�noms des coureurs poss�dant le record du nombre de victoires d'�tapes au tour de France*/

select nom, prenom, count(*) as nb from vt_coureur
join vt_temps using (n_coureur)
where rang_arrivee = 1
having count(*) = (select max(count(*)) as nombre from vt_coureur
join vt_temps using (n_coureur)
where rang_arrivee=1
group by nom, prenom)
group by nom, prenom
order by nb desc;

select max(count(*)) as nombre from vt_coureur
join vt_temps using (n_coureur)
where rang_arrivee=1
group by nom, prenom;

select nom, prenom, count(*) as nb from vt_coureur
join vt_temps using (n_coureur)
where rang_arrivee = 1
group by nom, prenom;

select n_coureur, count(*) from vt_temps
group by n_coureur;

/*60) Donner la liste des coureurs ayant r�alis� pour l�avant-derni�re �tape du Tour 2024 un temps inf�rieur � la
moyenne des temps de l�avant-derni�re �tape du Tour 2024. Afficher les donn�es avec le n� de ligne (rownum) � la
projection, toutes les caract�ristiques de "coureur" et le temps r�alis�. Le r�sultat sera tri� en ordre croissant sur le
temps d�arriv�e.*/

select * from vt_coureur
join vt_temps using( n_coureur);

/*avant derni�re �tape*/

/*moyenne*/


create or replace view vt_temps_2024 (annee_2024) as
select annee from vt_temps 
where annee = 2024;

select nom, prenom, total_seconde from vt_coureur
join vt_temps using( n_coureur);

select co.*, total_seconde from vt_coureur co
join vt_temps_2024 tp on tp.n_coureur = co.n_coureur
where n_etape = 20;


select rownum, co.*, total_seconde from vt_coureur co
join vt_temps_2024 tp on tp.n_coureur = co.n_coureur
where n_etape =
(
    select max(n_etape)-1 from vt_temps_2024
    )
    and total_seconde <
    (
    select avg(total_seconde) from vt_temps_2024 where to_number(n_etape) =
        (
             select max(to_number(n_etape)) from vt_etape where annee = 2024
         )
     )
    order by total_seconde
);
/*61a) Donner la liste des sponsors (n_equipe, n_sponsor et nom) et le nombre de coureurs par �quipe ayant particip�
au Tour 1998. En faire une vue nomm�e v61_depart*/

create or replace view v61_depart as
select n_equipe, count(*) as nb_depart, n_sponsor, nom from vt_parti_coureur
join vt_sponsor using (n_equipe, n_sponsor)
where annee = 1998
group by n_equipe, n_sponsor, nom;

/*61b) Donner la liste des sponsors (n_equipe, n_sponsor et nom) et le nombre de coureurs par �quipe ayant termin� le
Tour 1998. En faire une vue nomm�e v61_arrivee.*/

create or replace view v61_arrivee as
select n_equipe, count(*) as nb_arrives, n_sponsor, nom from vt_parti_coureur
join vt_sponsor using (n_equipe, n_sponsor)
where annee = 1998 and n_coureur not in
(
    select n_coureur from vt_abandon
    where annee = 1998
)
group by n_equipe, n_sponsor, nom;

select * from v61_arrivee;
/*61c) M�me requ�te que pr�c�demment pour les coureurs n'ayant pas termin� le Tour 1998. En faire une vue nomm�e
v61_abandon*/

create or replace view v61_abandon as
select n_equipe, count(*) as nb_abandon, n_sponsor, nom from vt_parti_coureur
join vt_sponsor using (n_equipe, n_sponsor)
where annee = 1998 and n_coureur in
(
    select n_coureur from vt_abandon
    where annee= 1998
)
group by n_equipe, n_sponsor, nom;

/*61d) Utiliser les 3 vues pour obtenir le r�sultat suivant. Bien distinguer les d�parts, les arriv�es et les abandons.
Exemple :*/

select n_equipe, n_sponsor, nb_depart from v61_depart
union
select n_equipe, n_sponsor, nb_arrives from v61_arrivee
union
select n_equipe, n_sponsor, nb_abandon from v61_abandon;

/*61e) M�me question mais avec l'affichage suivant*/
select n_equipe, n_sponsor, nom, nb_depart, nvl(nb_arrives,0), nvl(nb_abandon, 0) from v61_depart
join v61_arrivee using( n_equipe, n_sponsor, nom)
join v61_abandon using(n_equipe, n_sponsor, nom)
order by 3;

/*61f) Quelle�s sont la ou les �quipes comportant le plus de coureurs � la fin du Tour 1998. Il est possible de r�utiliser la
vue v61_arrivee.*/

select n_equipe, n_sponsor, nom, nb_arrives from v61_arrivee
where nb_arrives =
(
    select max(nb_arrives) from v61_arrivee
)
order by nom desc;

/*62a) Afficher le n� du coureur, le nom, le pr�nom, la somme des � total_seconde � et la diff�rence (colonne r�f�renc�e
dans l�objet vt_temps_difference contenant l�ensemble des bonifications et p�nalit�s concernant certains coureurs pour
certaines ann�es) pour les coureurs n�ayant pas abandonn� en 2024.*/

select n_coureur, nom, prenom, sum(total_seconde)as temps, difference from vt_coureur
join vt_temps using(n_coureur)
left join vt_temps_difference using (n_coureur, annee)
where annee = 2024 and (n_coureur, annee) not in
(
    select n_coureur, annee from vt_abandon
)
group by n_coureur, nom, prenom, difference
order by temps;

/*62b) Donner le temps total r�alis� par les coureurs du Tour 2005 n'ayant pas abandonn� (quel que soit le type
d�abandon). Afficher le n� du coureur, le nom, le pr�nom et le temps total r�alis� en secondes (total_seconde +
diff�rence) (renommer la colonne par "temps total").*/

select * from vt_abandon
join vt_coureur using(n_coureur)
join vt_typeaban using (c_typeaban)
where annee = 2005;




select to_char(n_coureur) as n_coureur, nom, prenom, sum(total_seconde)+ nvl(difference, 0)  as temps_total from vt_coureur
join vt_temps using(n_coureur)
join vt_parti_coureur using (n_coureur, annee)
left join vt_temps_difference using (n_coureur, annee)
where annee = 2005 and valide ='O' and (n_coureur, annee) not in
(
    select n_coureur, annee from vt_abandon
)
group by n_coureur, nom, prenom, difference
union
select '-', substr(nom,1,2) || '-' ,  substr(prenom, 1,2) || '-',(sum(total_seconde)+ nvl(difference, 0) ) from vt_coureur
join vt_temps using(n_coureur)
join vt_parti_coureur using ( n_coureur, annee)
left join vt_temps_difference using (n_coureur, annee)
where annee = 2005 and valide ='R' and (n_coureur, annee) not in
(
    select n_coureur, annee from vt_abandon
)
group by n_coureur, nom, prenom, difference
order by temps_total;

create or replace view vt_valide as
select *  from vt_parti_coureur
where annee= 2005 and upper(valide) = 'R';

select * from vt_valide;

/*63) Afficher la liste des sponsors actuels des �quipes encore existantes.*/


select n_equipe, n_sponsor from vt_sponsor;

select n_equipe, max(n_sponsor), nom from vt_equipe
join vt_sponsor using(n_equipe)
where annee_disparition is null
group by n_equipe, nom
order by n_equipe asc;

/*64) Difficile Afficher les propri�t�s du dernier sponsor pour les �quipes ayant eu plus de 6 sponsors. Afficher
�galement le nombre de d�nominations que cette �quipe a connue. Rappel : max <> count.. Il est conseill� de faire une
vue max_nb_sponsors contenant pour chaque �quipe, le nombre de sponsors*/
create or replace view vt_nb_sponsor as
select n_equipe, max(n_sponsor)as max_sponsor from vt_sponsor
group by n_equipe
order by n_equipe;



select n_equipe, max_sponsor from vt_nb_sponsor
where max_sponsor >6
order by n_equipe;

/*65) Difficile Afficher le premier sponsor et le dernier sponsor (actuel) des �quipes encore existantes.*/

create or replace view max_sponsor as
select n_equipe, min(n_sponsor) as premier_sponsor from vt_sponsor
group by n_equipe
order by n_equipe;
create or replace view min_sponsor as
select n_equipe, max(n_sponsor) as dernier_sponsor from vt_sponsor
group by n_equipe
order by n_equipe;

create or replace view min_sponsor as
select n_equipe, nom as premier_nom from vt_equipe
join vt_sponsor using(n_equipe)
where annee_disparition is null
and (n_equipe, n_sponsor) in
(
    select n_equipe, min(n_sponsor)
    from vt_sponsor
    group by n_equipe
);

create or replace view max_sponsor as
select n_equipe, nom as dernier_nom from vt_equipe
join vt_sponsor using(n_equipe)
where annee_disparition is null
and (n_equipe, n_sponsor) in
(
    select n_equipe, max(n_sponsor)
    from vt_sponsor
    group by n_equipe
);


select n_equipe, dernier_nom, premier_nom from max_sponsor
join min_sponsor using(n_equipe);

/*66) Afficher les �quipes ayant succ�d� � l'�quipe 14 en respectant l�arborescence ci-dessous. (voir cours 1.10 Les
requ�tes hi�rarchiques)*/

select distinct level, n_equipe, lpad('-',4*level-4, '-')||'->' || n_eq_successeur as n_successeur
from vt_equ_succede 
start with n_equipe=14
connect by prior n_successeur = n_equipe
order by level;