-- -----------------------------------------------------------------------------
--             G�n�ration d'une base de donn�es pour
--                      Oracle Version 10g
--                     (21/9/2023 9:51:56)
-- -----------------------------------------------------------------------------
--      Nom de la base : MLR1
--      Projet : cnc
--      Auteur : E.Porcq
--      Date de derni�re modification : 21/9/2023 9:51:28
-- -----------------------------------------------------------------------------

DROP TABLE CNC_STATUT CASCADE CONSTRAINTS;
DROP TABLE CNC_LOT CASCADE CONSTRAINTS;
DROP TABLE CNC_CEPAGE CASCADE CONSTRAINTS;
DROP TABLE CNC_CRU CASCADE CONSTRAINTS;
DROP TABLE CNC_CAMION CASCADE CONSTRAINTS;
DROP TABLE CNC_PARCELLE CASCADE CONSTRAINTS;
DROP TABLE CNC_COOPERATEUR CASCADE CONSTRAINTS;
DROP TABLE CNC_LIVREUR CASCADE CONSTRAINTS;
DROP TABLE CNC_APPORT CASCADE CONSTRAINTS;
DROP TABLE CNC_INDEPENDANT CASCADE CONSTRAINTS;
DROP TABLE CNC_CLASSER CASCADE CONSTRAINTS;
DROP TABLE CNC_SITUER CASCADE CONSTRAINTS;
DROP TABLE CNC_ASSURER CASCADE CONSTRAINTS;
DROP TABLE CNC_PESER CASCADE CONSTRAINTS;

CREATE TABLE CNC_STATUT
(
    STA_CODE VARCHAR2(16)  NOT NULL,
    STA_LIBELLE VARCHAR2(64)  NULL,
    CONSTRAINT PK_CNC_STATUT PRIMARY KEY (STA_CODE)  
);

CREATE TABLE CNC_LOT
(
    APP_NUM NUMBER(4)  NOT NULL,
    LOT_NUM NUMBER(4)  NOT NULL,
    CRU_CODE_INSEE CHAR(32)  NOT NULL,
    CEP_CODE NUMBER(1)  NOT NULL,
    CONSTRAINT PK_CNC_LOT PRIMARY KEY (APP_NUM, LOT_NUM)  
);

CREATE  INDEX I_FK_CNC_LOT_CNC_APPORT
     ON CNC_LOT (APP_NUM ASC);

CREATE  INDEX I_FK_CNC_LOT_CNC_CRU
     ON CNC_LOT (CRU_CODE_INSEE ASC);

CREATE  INDEX I_FK_CNC_LOT_CNC_CEPAGE
     ON CNC_LOT (CEP_CODE ASC);

CREATE TABLE CNC_CEPAGE
(
    CEP_CODE NUMBER(1)  NOT NULL,
    CEP_LIBELLE VARCHAR2(32)  NULL,
    CONSTRAINT PK_CNC_CEPAGE PRIMARY KEY (CEP_CODE)  
);

CREATE TABLE CNC_CRU
(
    CRU_CODE_INSEE CHAR(32)  NOT NULL,
    CRU_COMMUNE VARCHAR2(32)  NULL,
    CONSTRAINT PK_CNC_CRU PRIMARY KEY (CRU_CODE_INSEE)  
);

CREATE TABLE CNC_CAMION
(
    CAM_IMMAT VARCHAR2(12)  NOT NULL,
    CAM_CAPA_PALETTES NUMBER(3)  NULL,
    CONSTRAINT PK_CNC_CAMION PRIMARY KEY (CAM_IMMAT)  
);

CREATE TABLE CNC_PARCELLE
(
    PAR_NUM NUMBER(2)  NOT NULL,
    LIV_CODE NUMBER(4)  NOT NULL,
    PAR_SURFACE NUMBER(5,2)  NULL,
    CONSTRAINT PK_CNC_PARCELLE PRIMARY KEY (PAR_NUM)  
);

CREATE  INDEX I_FK_CNC_PARCELLE_CNC_COOPERAT
     ON CNC_PARCELLE (LIV_CODE ASC);

CREATE TABLE CNC_COOPERATEUR
(
    LIV_CODE NUMBER(4)  NOT NULL,
    COO_POURCENTAGE NUMBER(4,1)  NULL,
    CONSTRAINT PK_CNC_COOPERATEUR PRIMARY KEY (LIV_CODE)  
);

CREATE TABLE CNC_LIVREUR
(
    LIV_CODE NUMBER(4)  NOT NULL,
    LIV_NOM VARCHAR2(32)  NULL,
    LIV_PRENOM VARCHAR2(32)  NULL,
    LIV_ADRESSE VARCHAR2(32)  NULL,
    LIV_VILLE VARCHAR2(32)  NULL,
    LIVE_CP CHAR(5)  NULL,
    CONSTRAINT PK_CNC_LIVREUR PRIMARY KEY (LIV_CODE)  
);

CREATE TABLE CNC_APPORT
(
    APP_NUM NUMBER(4)  NOT NULL,
    CAM_IMMAT VARCHAR2(12)  NOT NULL,
    APP_DATE_ARRIVEE DATE  NULL,
    CONSTRAINT PK_CNC_APPORT PRIMARY KEY (APP_NUM)  
);

CREATE  INDEX I_FK_CNC_APPORT_CNC_CAMION
     ON CNC_APPORT (CAM_IMMAT ASC);

CREATE TABLE CNC_INDEPENDANT
(
    LIV_CODE NUMBER(4)  NOT NULL,
    STA_CODE VARCHAR2(16)  NOT NULL,
    CONSTRAINT PK_CNC_INDEPENDANT PRIMARY KEY (LIV_CODE)  
);

CREATE  INDEX I_FK_CNC_INDEPENDANT_CNC_STATU
     ON CNC_INDEPENDANT (STA_CODE ASC)
;

CREATE TABLE CNC_CLASSER
(
    ANNEE NUMBER(4)  NOT NULL,
    CRU_CODE_INSEE CHAR(32)  NOT NULL,
    CLA_CLASSEMENT CHAR(32)  NULL,
    CONSTRAINT PK_CNC_CLASSER PRIMARY KEY (ANNEE, CRU_CODE_INSEE)  
);

CREATE  INDEX I_FK_CNC_CLASSER_CNC_CRU
     ON CNC_CLASSER (CRU_CODE_INSEE ASC);

CREATE TABLE CNC_SITUER
(
    CRU_CODE_INSEE CHAR(32)  NOT NULL,
    PAR_NUM NUMBER(2)  NOT NULL,
    CONSTRAINT PK_CNC_SITUER PRIMARY KEY (CRU_CODE_INSEE, PAR_NUM)  
);

CREATE  INDEX I_FK_CNC_SITUER_CNC_CRU
     ON CNC_SITUER (CRU_CODE_INSEE ASC);

CREATE  INDEX I_FK_CNC_SITUER_CNC_PARCELLE
     ON CNC_SITUER (PAR_NUM ASC);

CREATE TABLE CNC_ASSURER
(
    LIV_CODE NUMBER(4)  NOT NULL,
    APP_NUM NUMBER(4)  NOT NULL,
    LOT_NUM NUMBER(4)  NOT NULL,
    ASS_FRACTION CHAR(32)  NULL,
    CONSTRAINT PK_CNC_ASSURER PRIMARY KEY (LIV_CODE, APP_NUM, LOT_NUM)  
);

CREATE  INDEX I_FK_CNC_ASSURER_CNC_LIVREUR
     ON CNC_ASSURER (LIV_CODE ASC);

CREATE  INDEX I_FK_CNC_ASSURER_CNC_LOT
     ON CNC_ASSURER (APP_NUM ASC, LOT_NUM ASC);

CREATE TABLE CNC_PESER
(
    PAL_NUM NUMBER(3)  NOT NULL,
    APP_NUM NUMBER(4)  NOT NULL,
    LOT_NUM NUMBER(4)  NOT NULL,
    PES_POIDS NUMBER(4,1)  NULL,
    PES_NB_CAISSE CHAR(32)  NULL,
    CONSTRAINT PK_CNC_PESER PRIMARY KEY (PAL_NUM, APP_NUM, LOT_NUM)  
);

CREATE  INDEX I_FK_CNC_PESER_CNC_LOT
     ON CNC_PESER (APP_NUM ASC, LOT_NUM ASC)
;

ALTER TABLE CNC_LOT ADD (
     CONSTRAINT FK_CNC_LOT_CNC_APPORT
          FOREIGN KEY (APP_NUM)
               REFERENCES CNC_APPORT (APP_NUM));

ALTER TABLE CNC_LOT ADD (
     CONSTRAINT FK_CNC_LOT_CNC_CRU
          FOREIGN KEY (CRU_CODE_INSEE)
               REFERENCES CNC_CRU (CRU_CODE_INSEE));

ALTER TABLE CNC_LOT ADD (
     CONSTRAINT FK_CNC_LOT_CNC_CEPAGE
          FOREIGN KEY (CEP_CODE)
               REFERENCES CNC_CEPAGE (CEP_CODE));

ALTER TABLE CNC_PARCELLE ADD (
     CONSTRAINT FK_CNC_PARCELLE_CNC_COOPERATEU
          FOREIGN KEY (LIV_CODE)
               REFERENCES CNC_COOPERATEUR (LIV_CODE));

ALTER TABLE CNC_COOPERATEUR ADD (
     CONSTRAINT FK_CNC_COOPERATEUR_CNC_LIVREUR
          FOREIGN KEY (LIV_CODE)
               REFERENCES CNC_LIVREUR (LIV_CODE));

ALTER TABLE CNC_APPORT ADD (
     CONSTRAINT FK_CNC_APPORT_CNC_CAMION
          FOREIGN KEY (CAM_IMMAT)
               REFERENCES CNC_CAMION (CAM_IMMAT));

ALTER TABLE CNC_INDEPENDANT ADD (
     CONSTRAINT FK_CNC_INDEPENDANT_CNC_STATUT
          FOREIGN KEY (STA_CODE)
               REFERENCES CNC_STATUT (STA_CODE));

ALTER TABLE CNC_INDEPENDANT ADD (
     CONSTRAINT FK_CNC_INDEPENDANT_CNC_LIVREUR
          FOREIGN KEY (LIV_CODE)
               REFERENCES CNC_LIVREUR (LIV_CODE));

ALTER TABLE CNC_CLASSER ADD (
     CONSTRAINT FK_CNC_CLASSER_CNC_CRU
          FOREIGN KEY (CRU_CODE_INSEE)
               REFERENCES CNC_CRU (CRU_CODE_INSEE));

ALTER TABLE CNC_SITUER ADD (
     CONSTRAINT FK_CNC_SITUER_CNC_CRU
          FOREIGN KEY (CRU_CODE_INSEE)
               REFERENCES CNC_CRU (CRU_CODE_INSEE));

ALTER TABLE CNC_SITUER ADD (
     CONSTRAINT FK_CNC_SITUER_CNC_PARCELLE
          FOREIGN KEY (PAR_NUM)
               REFERENCES CNC_PARCELLE (PAR_NUM));

ALTER TABLE CNC_ASSURER ADD (
     CONSTRAINT FK_CNC_ASSURER_CNC_LIVREUR
          FOREIGN KEY (LIV_CODE)
               REFERENCES CNC_LIVREUR (LIV_CODE));

ALTER TABLE CNC_ASSURER ADD (
     CONSTRAINT FK_CNC_ASSURER_CNC_LOT
          FOREIGN KEY (APP_NUM, LOT_NUM)
               REFERENCES CNC_LOT (APP_NUM, LOT_NUM));

ALTER TABLE CNC_PESER ADD (
     CONSTRAINT FK_CNC_PESER_CNC_LOT
          FOREIGN KEY (APP_NUM, LOT_NUM)
               REFERENCES CNC_LOT (APP_NUM, LOT_NUM));


-- -----------------------------------------------------------------------------
--                FIN DE GENERATION
-- -----------------------------------------------------------------------------
insert into cnc_cepage values (1,'Chardonnay');
insert into cnc_cepage values (2,'Pinot noir');
insert into cnc_cepage values (3,'Pinot meunier');
insert into cnc_cepage values (4,'Cabernet Sauvignon');
insert into cnc_cepage values (6,'Aligot�');
insert into cnc_cepage values (7,'Syrah');
insert into cnc_cepage values (8,'grenache noir');
insert into cnc_cepage values (9,'gamay');

insert into cnc_cru values ('14341','Ifs');
insert into cnc_cru values ('61169','Flers');
insert into cnc_cru values ('14712','Saline');
insert into cnc_cru values ('14092','Bourgu�bus');
insert into cnc_cru values ('14482','Ouezy');
insert into cnc_cru values ('27457','Piseux');
insert into cnc_cru values ('14074','Billy');
insert into cnc_cru values ('50613','Valcanville');

insert into cnc_classer values (2021,'14074',65);
insert into cnc_classer values (2021,'61169',10);
insert into cnc_classer values (2021,'27457',14);
insert into cnc_classer values (2021,'14712',1);
insert into cnc_classer values (2022,'14074',107);
insert into cnc_classer values (2022,'61169',19);
insert into cnc_classer values (2022,'27457',9);
insert into cnc_classer values (2022,'14712',1);
insert into cnc_classer values (2022,'14482',198);
insert into cnc_classer values (2022,'14092',309);
insert into cnc_classer values (2022,'14341',84);
insert into cnc_classer values (2023,'14074',2);
insert into cnc_classer values (2023,'27457',2000);
insert into cnc_classer values (2023,'14712',815);
insert into cnc_classer values (2023,'61169',38);
insert into cnc_classer values (2023,'14482',129);
insert into cnc_classer values (2023,'14092',309);
insert into cnc_classer values (2023,'14341',89);
 
insert into cnc_camion values ('AB-123-CD' ,34);
insert into cnc_camion values ('1234 QQ 14',30);
insert into cnc_camion values ('66 NAZ 14' ,20);
insert into cnc_camion values ('421 KO 61' ,33);
insert into cnc_camion values ('2 OK 50'   ,32);


insert into cnc_apport values (1121,'AB-123-CD'  ,'1/09/2023');
insert into cnc_apport values (1150,'1234 QQ 14' ,'01/09/2023');
insert into cnc_apport values (1188,'AB-123-CD'  ,'02/09/2023');
insert into cnc_apport values (1190,'421 KO 61'  ,'05/09/2023');
insert into cnc_apport values (1200,'1234 QQ 14' ,'05/09/2023');
insert into cnc_apport values (1225,'AB-123-CD'  ,'05/09/2023');
insert into cnc_apport values (1226,'AB-123-CD'  ,'05/09/2023');

insert into cnc_apport values (1231,'AB-123-CD' ,'06/09/2023');
insert into cnc_apport values (1238,'1234 QQ 14','06/09/2023');
insert into cnc_apport values (1241,'AB-123-CD' ,'07/09/2023');
insert into cnc_apport values (1248,'421 KO 61' ,'10/09/2023');
insert into cnc_apport values (1298,'421 KO 61' ,'11/09/2023');
insert into cnc_apport values (1307,'2 OK 50'   ,'11/09/2023');

insert into cnc_lot values (1121,1,'14074',7);
insert into cnc_lot values (1121,2,'14074',7);
insert into cnc_lot values (1150,1,'61169',6);
insert into cnc_lot values (1150,2,'61169',6);
insert into cnc_lot values (1150,3,'61169',6);
insert into cnc_lot values (1188,1,'14092',2);
insert into cnc_lot values (1190,1,'14074',4);
insert into cnc_lot values (1200,1,'50613',3);
insert into cnc_lot values (1200,2,'50613',3);
insert into cnc_lot values (1225,1,'14482',1);
insert into cnc_lot values (1226,1,'14482',1);

insert into cnc_lot values (1231,1,'14074',7);
insert into cnc_lot values (1231,2,'14074',6);
insert into cnc_lot values (1231,3,'14074',4);
insert into cnc_lot values (1238,1,'27457',1);
insert into cnc_lot values (1238,2,'14482',1);
insert into cnc_lot values (1238,3,'14074',2);
insert into cnc_lot values (1238,4,'14712',3);
insert into cnc_lot values (1241,1,'61169',1);
insert into cnc_lot values (1298,1,'14482',4);
insert into cnc_lot values (1298,2,'14341',2);
insert into cnc_lot values (1307,1,'27457',1);
insert into cnc_lot values (1307,2,'61169',1);
insert into cnc_lot values (1307,3,'14092',1);

insert into cnc_peser values (28 ,1231,1,60.9 ,8);
insert into cnc_peser values (31 ,1231,1,49.5 ,7);
insert into cnc_peser values (36 ,1231,1,72.8 ,8);
insert into cnc_peser values (41 ,1231,2,75.4 ,8);
insert into cnc_peser values (8  ,1231,2,76.3 ,10);
insert into cnc_peser values (11 ,1231,3,101.1,12);
insert into cnc_peser values (16 ,1231,3,89.6 ,11);
insert into cnc_peser values (108,1231,3,98.5 ,12);
insert into cnc_peser values (109,1231,3,60.4 ,6);
insert into cnc_peser values (98 ,1231,3,89.3 ,10);

insert into cnc_livreur values (1011,'SUPER'  ,'Didier'    ,'2 rue Johnny'         ,'CAEN'        ,'14000' );
insert into cnc_livreur values (1012,'SUPER'  ,'L�a'       ,'2 rue Johnny'         ,'CAEN'        ,'14000' );
insert into cnc_livreur values (2019,'ABEL'   ,'Samir'     ,'216 avenue Oracle'    ,'MONDEVILLE'  ,'14120' );
insert into cnc_livreur values (2024,'MUDA'   ,'Robert'    ,'impasse Access'       ,'LION-SUR-MER','14780' );
insert into cnc_livreur values (2026,'RAHL'   ,'Darken'    ,'6 rue de la v�rit�'   ,'SAINT-SAMSON','53140' );
insert into cnc_livreur values (1034,'VEDERE' ,'Isabelle'  ,'8 rue de la requ�te'  ,'MESSEI'      ,'61440' );
insert into cnc_livreur values (2034,'TIME'   ,'Vincent'   ,'2236 Bd des cahmpions','IFS'         ,'14123' );
insert into cnc_livreur values (1041,'GORIOT' ,'Mathilde'  ,'6 rue de la  paix'    ,'CAEN'        ,'14000' );
insert into cnc_livreur values (2048,'PIKETTY','Fabienne'  ,'5 rue de la bourse'   ,'IFS'         ,'14123' );
insert into cnc_livreur values (1061,'NOKIA'  ,'Christelle','7 rue Moli�re'        ,'MALTOT'      ,'14930' );
insert into cnc_livreur values (2063,'NERON'  ,'Philippe'  ,'9 rue de Rome'        ,'SAINT-SAMSON','14670' );
insert into cnc_livreur values (2066,'TALUT'  ,'Jean'      ,'15 rue Tayou'         ,'SAINT-SAMSON','14670' );
insert into cnc_livreur values (2080,'LAMERE'  ,'Michel'   ,'13 rue Lustucru'      ,'TROARN','14670' );
insert into cnc_livreur values (2082,'DELALUNE','Claire'   ,'10 Bld Pierrot'       ,'TROARN','14670' );
insert into cnc_livreur values (2094,'HOUSEEL' ,'Kader'    ,'6 rue des 3 maison'   ,'MOULT','14370' );


insert into cnc_assurer values (1011,1121,1,0.15);
insert into cnc_assurer values (1012,1121,1,0.35);
insert into cnc_assurer values (2024,1150,1,1);
insert into cnc_assurer values (2063,1188,1,0.50);
insert into cnc_assurer values (2048,1190,1,0.60);
insert into cnc_assurer values (1011,1190,1,0.40);
insert into cnc_assurer values (2024,1200,1,1);
insert into cnc_assurer values (1011,1225,1,0.20);
insert into cnc_assurer values (1012,1225,1,0.40);
insert into cnc_assurer values (1034,1225,1,0.40);
insert into cnc_assurer values (2034,1226,1,1);

insert into cnc_assurer values (1011,1231,1,1);
insert into cnc_assurer values (1012,1231,2,0.7);
insert into cnc_assurer values (1011,1231,2,0.3);
insert into cnc_assurer values (2019,1231,3,0.5);
insert into cnc_assurer values (2034,1231,3,0.5);
insert into cnc_assurer values (2034,1238,1,0.3);
insert into cnc_assurer values (2024,1238,1,0.4);
insert into cnc_assurer values (2063,1238,1,0.3);
insert into cnc_assurer values (1061,1238,2,1);
insert into cnc_assurer values (2024,1307,1,0.3);
insert into cnc_assurer values (2026,1307,1,0.7);
insert into cnc_assurer values (2048,1307,2,0.25);
insert into cnc_assurer values (2063,1307,2,0.75);
insert into cnc_assurer values (1012,1241,1,0.2);
insert into cnc_assurer values (1034,1241,1,0.8);

insert into cnc_statut values ('EI','Entreprise Individuelle');
insert into cnc_statut values ('SRL','Soci�t� � Responsabilit� Limit�e');
insert into cnc_statut values ('SCAEC','Soci�t� Coop�rative Agricole d''Exploitations en Commun');
insert into cnc_statut values ('COOP','Coop�rative');

insert into cnc_independant values (1011,'EI');
insert into cnc_independant values (1012,'SRL');
insert into cnc_independant values (1034,'SCAEC');
insert into cnc_independant values (1041,'COOP');
insert into cnc_independant values (1061,'SCAEC');
insert into cnc_independant values (2066,'EI');
insert into cnc_independant values (2080,'COOP');
insert into cnc_independant values (2082,'SRL');
insert into cnc_independant values (2094,'EI');

insert into cnc_cooperateur values (2019,0.50);
insert into cnc_cooperateur values (2024,100);
insert into cnc_cooperateur values (2026,0.30);
insert into cnc_cooperateur values (2034,0.75);
insert into cnc_cooperateur values (2048,0.75);
insert into cnc_cooperateur values (2063,0.25);

insert into cnc_parcelle values (1,2019,2.3);
insert into cnc_parcelle values (3,2019,1.5);
insert into cnc_parcelle values (5,2024,0.9);
insert into cnc_parcelle values (6,2034,1.6);
insert into cnc_parcelle values (8,2048,3.7);
insert into cnc_parcelle values (15,2063,0.5);
insert into cnc_parcelle values (16,2063,0.9);

insert into cnc_situer values ('14712',1);
insert into cnc_situer values ('27457',3);
insert into cnc_situer values ('14074',5);
insert into cnc_situer values ('14074',6);
insert into cnc_situer values ('50613',8);
insert into cnc_situer values ('50613',15);
insert into cnc_situer values ('14482',16);


commit;
select * from  cnc_apport;
select * from  cnc_assurer;
select * from  cnc_camion;
select * from  cnc_cepage;
select * from  cnc_classer;
select * from  cnc_cooperateur;
select * from  cnc_cru;
select * from  cnc_independant;
select * from  cnc_livreur;
select * from  cnc_lot;
select * from  cnc_parcelle;
select * from  cnc_peser;
select * from  cnc_situer;
select * from  cnc_statut;



/*1*/
select * from cnc_livreur
order by liv_ville,liv_nom desc;

/*2*/
select liv_prenom from cnc_livreur 
where upper(liv_prenom) LIKE '%D%' 
or upper(liv_prenom) LIKE '%A%';

/*3*/
select sysdate-app_date_arrivee as jour from cnc_apport;

/*4*/
select * from cnc_classer
where annee = 2022
and (cla_classement <10 
or cla_classement >100);

/*5*/
select app_num, lot_num, pes_poids, cru_code_insee from cnc_peser
join cnc_lot using (app_num, lot_num);

/*6*/
select pes.app_num, pes.lot_num, pes_poids, cru_code_insee from cnc_peser pes
join cnc_lot lot on pes.app_num = lot.app_num and pes.lot_num = lot.lot_num; 

/*7*/
select liv_prenom, liv_nom, liv_ville, sta_libelle from cnc_livreur liv, cnc_independant indep, cnc_statut sta
where liv.liv_code=indep.liv_code
and indep.sta_code=sta.sta_code;

/*8*/
select * from cnc_apport
right join cnc_camion using(cam_immat);

/*9*/
select cep_code, cep_libelle from cnc_cepage cep
left join cnc_lot lot using(cep_code)
where app_num is null and lot_num is null and cru_code_insee is null;

/*10*/
select * from cnc_livreur l1, cnc_livreur l2




