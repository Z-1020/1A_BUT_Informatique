-- -----------------------------------------------------------------------------
--             Génération d'une base de données pour
--                      Oracle Version 10g
--                     (13/2/2024 15:30:47)
-- -----------------------------------------------------------------------------
--      Nom de la base : MLR_SEG
--      Projet : seg
--      Auteur : Eric Porcq
--      Date de dernière modification : 13/2/2024 15:29:42
-- -----------------------------------------------------------------------------

DROP TABLE SEG_POMPAGE CASCADE CONSTRAINTS;
DROP TABLE SEG_MOIS CASCADE CONSTRAINTS;
DROP TABLE SEG_CAPTAGE CASCADE CONSTRAINTS;
DROP TABLE SEG_FORAGE CASCADE CONSTRAINTS;
DROP TABLE SEG_FINANCEUR CASCADE CONSTRAINTS;
DROP TABLE SEG_LABORATOIRE CASCADE CONSTRAINTS;
DROP TABLE SEG_TECHNICIEN CASCADE CONSTRAINTS;
DROP TABLE SEG_ANALYSE CASCADE CONSTRAINTS;
DROP TABLE SEG_ENTERRE CASCADE CONSTRAINTS;
DROP TABLE SEG_SUBSTANCE CASCADE CONSTRAINTS;
DROP TABLE SEG_AERIEN CASCADE CONSTRAINTS;
DROP TABLE SEG_RESERVOIR CASCADE CONSTRAINTS;
DROP TABLE SEG_CONTENIR CASCADE CONSTRAINTS;
DROP TABLE SEG_ALIMENTER_SECOURS CASCADE CONSTRAINTS;
DROP TABLE SEG_MESURE CASCADE CONSTRAINTS;

CREATE TABLE SEG_POMPAGE
(
    CAP_CODE CHAR(5),
    POM_NATURE VARCHAR2(20)  NULL,
    CONSTRAINT PK_SEG_POMPAGE PRIMARY KEY (CAP_CODE)  
);

CREATE TABLE SEG_MOIS
(
    MOI_NUMERO NUMBER(2),
    MOI_LIBELLE VARCHAR2(32)  NULL,
    CONSTRAINT PK_SEG_MOIS PRIMARY KEY (MOI_NUMERO)  
);

CREATE TABLE SEG_CAPTAGE
(
    CAP_CODE CHAR(5),
    CAP_NOM VARCHAR2(32)  NULL,
    CAP_DEBIT_MAX NUMBER  NULL,
    CONSTRAINT PK_SEG_CAPTAGE PRIMARY KEY (CAP_CODE)  
);

CREATE TABLE SEG_FORAGE
(
    CAP_CODE CHAR(5),
    FOR_PROFONDEUR NUMBER(3)  NULL,
    FOR_DIAMETRE NUMBER(3)  NULL,
    CONSTRAINT PK_SEG_FORAGE PRIMARY KEY (CAP_CODE)  
);

CREATE TABLE SEG_FINANCEUR
(
    FIN_CODE NUMBER(4),
    FIN_NOM VARCHAR2(32)  NULL,
    FIN_TYPE VARCHAR2(16)  NULL,
    CONSTRAINT PK_SEG_FINANCEUR PRIMARY KEY (FIN_CODE)  
);

CREATE TABLE SEG_LABORATOIRE
(
    LAB_CODE VARCHAR2(16),
    LAB_NOM VARCHAR2(32)  NULL,
    LAB_PRIX NUMBER(10,2)  NULL,
    LAB_DATE_ACCREDIT DATE  NULL,
    CONSTRAINT PK_SEG_LABORATOIRE PRIMARY KEY (LAB_CODE)  
);

CREATE TABLE SEG_TECHNICIEN
(
    TEC_MATRICULE CHAR(4),
    TEC_NOM VARCHAR2(32)  NULL,
    TEC_PRENOM VARCHAR2(32)  NULL,
    TEC_TELEPHONE CHAR(14)  NULL,
    TEC_DATE_NAISS DATE  NULL,
    TEC_DATE_EMBAU DATE  NULL,
    CONSTRAINT PK_SEG_TECHNICIEN PRIMARY KEY (TEC_MATRICULE)  
);

CREATE TABLE SEG_ANALYSE
(
    RES_CODE CHAR(5),
    ANA_ID NUMBER(3),
    LAB_CODE VARCHAR2(16),
    CAP_CODE CHAR(5) ,
    ANA_DATE DATE  NULL,
    ANA_ESCHERICHIA_COLI NUMBER  NULL,
    ANA_ENTEROCOQUE NUMBER  NULL,
    CONSTRAINT PK_SEG_ANALYSE PRIMARY KEY (RES_CODE, ANA_ID)  
);

CREATE  INDEX I_FK_SEG_ANALYSE_SEG_LABORATOI
     ON SEG_ANALYSE (LAB_CODE ASC);

CREATE  INDEX I_FK_SEG_ANALYSE_SEG_RESERVOIR
     ON SEG_ANALYSE (RES_CODE ASC);

CREATE  INDEX I_FK_SEG_ANALYSE_SEG_CAPTAGE
     ON SEG_ANALYSE (CAP_CODE ASC);

CREATE TABLE SEG_ENTERRE
(
    RES_CODE CHAR(5),
    ENT_DEBIT CHAR(32)  NULL,
    CONSTRAINT PK_SEG_ENTERRE PRIMARY KEY (RES_CODE)  
);

CREATE TABLE SEG_SUBSTANCE
(
    SUB_CODE VARCHAR2(32)  NOT NULL,
    SUB_NOM VARCHAR2(32)  NULL,
    SUB_VALMAX NUMBER  NULL,
    CONSTRAINT PK_SEG_SUBSTANCE PRIMARY KEY (SUB_CODE)  
);

CREATE TABLE SEG_AERIEN
(
    RES_CODE CHAR(5)  NOT NULL,
    AER_HAUTEUR_MIN NUMBER(3)  NULL,
    AER_HAUTEUR_MAX NUMBER(3)  NULL,
    AER_TEMPS_REMPLISSAGE NUMBER(2)  NULL,
    AER_PRESSION NUMBER(3)  NULL,
    CONSTRAINT PK_SEG_AERIEN PRIMARY KEY (RES_CODE)  
);

CREATE TABLE SEG_RESERVOIR
(
    RES_CODE CHAR(5),
    CAP_CODE CHAR(5),
    RES_NOM VARCHAR2(32)  NULL,
    RES_CAPACITE_MAX NUMBER  NULL,
    CONSTRAINT PK_SEG_RESERVOIR PRIMARY KEY (RES_CODE)  
);

CREATE  INDEX I_FK_SEG_RESERVOIR_SEG_CAPTAGE
     ON SEG_RESERVOIR (CAP_CODE ASC);

CREATE TABLE SEG_CONTENIR
(
    RES_CODE CHAR(5),
    ANA_ID NUMBER(3),
    SUB_CODE VARCHAR2(32),
    CON_QUANTITE NUMBER  NULL,
    CONSTRAINT PK_SEG_CONTENIR PRIMARY KEY (RES_CODE, ANA_ID, SUB_CODE)  
);

CREATE  INDEX I_FK_SEG_CONTENIR_SEG_ANALYSE
     ON SEG_CONTENIR (RES_CODE ASC, ANA_ID ASC);

CREATE  INDEX I_FK_SEG_CONTENIR_SEG_SUBSTANC
     ON SEG_CONTENIR (SUB_CODE ASC);

CREATE TABLE SEG_ALIMENTER_SECOURS
(
    RES_CODE CHAR(5),
    CAP_CODE CHAR(5),
    TEC_MATRICULE CHAR(4)  NOT NULL,
    ALS_REMARQUE VARCHAR2(64)  NULL,
    CONSTRAINT PK_SEG_ALIMENTER_SECOURS PRIMARY KEY (RES_CODE, CAP_CODE)  
);

CREATE  INDEX I_FK_SEG_ALIMENTER_SECOURS_SEG
     ON SEG_ALIMENTER_SECOURS (RES_CODE ASC);

CREATE  INDEX I_FK_SEG_ALIMENTER_SECOURS_SE1
     ON SEG_ALIMENTER_SECOURS (CAP_CODE ASC);

CREATE  INDEX I_FK_SEG_ALIMENTER_SECOURS_SE2
     ON SEG_ALIMENTER_SECOURS (TEC_MATRICULE ASC);

CREATE TABLE SEG_MESURE
(
    MOI_NUMERO NUMBER(2),
    CAP_CODE CHAR(5),
    POS_DEBIT_MOYEN NUMBER  NULL,
    CONSTRAINT PK_SEG_MESURE PRIMARY KEY (MOI_NUMERO, CAP_CODE)  
);

CREATE  INDEX I_FK_SEG_MESURE_SEG_MOIS
     ON SEG_MESURE (MOI_NUMERO ASC);

CREATE  INDEX I_FK_SEG_MESURE_SEG_CAPTAGE
     ON SEG_MESURE (CAP_CODE ASC);

ALTER TABLE SEG_POMPAGE ADD (
     CONSTRAINT FK_SEG_POMPAGE_SEG_CAPTAGE
          FOREIGN KEY (CAP_CODE)
               REFERENCES SEG_CAPTAGE (CAP_CODE));

ALTER TABLE SEG_FORAGE ADD (
     CONSTRAINT FK_SEG_FORAGE_SEG_CAPTAGE
          FOREIGN KEY (CAP_CODE)
               REFERENCES SEG_CAPTAGE (CAP_CODE));

ALTER TABLE SEG_ANALYSE ADD (
     CONSTRAINT FK_SEG_ANALYSE_SEG_LABORATOIRE
          FOREIGN KEY (LAB_CODE)
               REFERENCES SEG_LABORATOIRE (LAB_CODE));

ALTER TABLE SEG_ANALYSE ADD (
     CONSTRAINT FK_SEG_ANALYSE_SEG_RESERVOIR
          FOREIGN KEY (RES_CODE)
               REFERENCES SEG_RESERVOIR (RES_CODE));

ALTER TABLE SEG_ANALYSE ADD (
     CONSTRAINT FK_SEG_ANALYSE_SEG_CAPTAGE
          FOREIGN KEY (CAP_CODE)
               REFERENCES SEG_CAPTAGE (CAP_CODE));

ALTER TABLE SEG_ENTERRE ADD (
     CONSTRAINT FK_SEG_ENTERRE_SEG_RESERVOIR
          FOREIGN KEY (RES_CODE)
               REFERENCES SEG_RESERVOIR (RES_CODE));

ALTER TABLE SEG_AERIEN ADD (
     CONSTRAINT FK_SEG_AERIEN_SEG_RESERVOIR
          FOREIGN KEY (RES_CODE)
               REFERENCES SEG_RESERVOIR (RES_CODE));

ALTER TABLE SEG_RESERVOIR ADD (
     CONSTRAINT FK_SEG_RESERVOIR_SEG_CAPTAGE
          FOREIGN KEY (CAP_CODE)
               REFERENCES SEG_CAPTAGE (CAP_CODE));

ALTER TABLE SEG_CONTENIR ADD (
     CONSTRAINT FK_SEG_CONTENIR_SEG_ANALYSE
          FOREIGN KEY (RES_CODE, ANA_ID)
               REFERENCES SEG_ANALYSE (RES_CODE, ANA_ID));

ALTER TABLE SEG_CONTENIR ADD (
     CONSTRAINT FK_SEG_CONTENIR_SEG_SUBSTANCE
          FOREIGN KEY (SUB_CODE)
               REFERENCES SEG_SUBSTANCE (SUB_CODE));

ALTER TABLE SEG_ALIMENTER_SECOURS ADD (
     CONSTRAINT FK_SEG_ALIMENTER_SECOURS_SEG_R
          FOREIGN KEY (RES_CODE)
               REFERENCES SEG_RESERVOIR (RES_CODE));

ALTER TABLE SEG_ALIMENTER_SECOURS ADD (
     CONSTRAINT FK_SEG_ALIMENTER_SECOURS_SEG_C
          FOREIGN KEY (CAP_CODE)
               REFERENCES SEG_CAPTAGE (CAP_CODE));

ALTER TABLE SEG_ALIMENTER_SECOURS ADD (
     CONSTRAINT FK_SEG_ALIMENTER_SECOURS_SEG_T
          FOREIGN KEY (TEC_MATRICULE)
               REFERENCES SEG_TECHNICIEN (TEC_MATRICULE));

ALTER TABLE SEG_MESURE ADD (
     CONSTRAINT FK_SEG_MESURE_SEG_MOIS
          FOREIGN KEY (MOI_NUMERO)
               REFERENCES SEG_MOIS (MOI_NUMERO));

ALTER TABLE SEG_MESURE ADD (
     CONSTRAINT FK_SEG_MESURE_SEG_CAPTAGE
          FOREIGN KEY (CAP_CODE)
               REFERENCES SEG_CAPTAGE (CAP_CODE));

-- -----------------------------------------------------------------------------
--                FIN DE GENERATION
-- -----------------------------------------------------------------------------

insert into seg_mois values ( 1  , 'JANVIER'   );
insert into seg_mois values ( 2  , 'FEVRIER'   );
insert into seg_mois values ( 3  , 'MARS'      );
insert into seg_mois values ( 4  , 'AVRIL'     );
insert into seg_mois values ( 5  , 'MAI'       );
insert into seg_mois values ( 6  , 'JUIN'      );
insert into seg_mois values ( 7  , 'JUILLET'   );
insert into seg_mois values ( 8  , 'AOUT'      );
insert into seg_mois values ( 9  , 'SEPTEMBRE' );
insert into seg_mois values ( 10 , 'OCTOBRE'   );
insert into seg_mois values ( 11 , 'NOVEMBRE'  );
insert into seg_mois values ( 12 , 'DECEMBRE'  );

insert into seg_captage values( 'C01' , 'forage de la petite gargouille' , 260 );
insert into seg_captage values( 'C02' , 'forage du rocher suchere'       , 320 );
insert into seg_captage values( 'C03' , 'le trou du talus'               , 400 );
insert into seg_captage values( 'C04' , 'la grotte aux loups'            , 200 );
insert into seg_captage values( 'C05' , 'forage du bois des pins'        , 280 );
insert into seg_captage values( 'C06' , 'lac de la forge'                , 150 );
insert into seg_captage values( 'C07' , 'le bout du bout'                , 170 );
insert into seg_captage values( 'C08' , 'la care de creu'                , 165 );
insert into seg_captage values( 'C09' , 'la rémonde'                     , 105 );
insert into seg_captage values( 'C10' , 'rimogène'                       , 125 );
insert into seg_captage values( 'C11' , 'la rue du C3'                   , 500 );
insert into seg_captage values( 'C12' , 'l''Orange en Pierre'            , 900 );
insert into seg_captage values( 'C16' , 'la poche Tronc'                 , 780 );

insert into seg_forage values( 'C01' , 150 , 15 );
insert into seg_forage values( 'C02' , 220 , 25 );
insert into seg_forage values( 'C03' , 450 , 28 );
insert into seg_forage values( 'C04' , 171 , 9  );
insert into seg_forage values( 'C05' , 350 , 5  );
insert into seg_forage values( 'C11' , 610 , 12 );
insert into seg_forage values( 'C12' , 900 , 19 );

insert into seg_pompage values( 'C06' , 'lac'     );
insert into seg_pompage values( 'C07' , 'fleuve'  );
insert into seg_pompage values( 'C08' , 'lac'     );
insert into seg_pompage values( 'C09' , 'rivière' );
insert into seg_pompage values( 'C10' , 'lac'     );
insert into seg_pompage values( 'C16' , 'bar'     );

insert into seg_mesure values ( 1  , 'C01' , 125 );
insert into seg_mesure values ( 2  , 'C01' , 129 );
insert into seg_mesure values ( 3  , 'C01' , 140 );
insert into seg_mesure values ( 4  , 'C01' , 110 );
insert into seg_mesure values ( 5  , 'C01' , 105 );
insert into seg_mesure values ( 6  , 'C01' , 75  );
insert into seg_mesure values ( 7  , 'C01' , 60  );
insert into seg_mesure values ( 8  , 'C01' , 50  );
insert into seg_mesure values ( 9  , 'C01' , 73  );
insert into seg_mesure values ( 10 , 'C01' , 99  );
insert into seg_mesure values ( 11 , 'C01' , 118 );
insert into seg_mesure values ( 12 , 'C01' , 126 );
insert into seg_mesure values ( 1  , 'C02' , 110 );
insert into seg_mesure values ( 2  , 'C02' , 124 );
insert into seg_mesure values ( 3  , 'C02' , 135 );
insert into seg_mesure values ( 1  , 'C11' , 300 );
insert into seg_mesure values ( 2  , 'C11' , 350 );
insert into seg_mesure values ( 3  , 'C11' , 450 );
insert into seg_mesure values ( 4  , 'C11' , 320 );
insert into seg_mesure values ( 5  , 'C11' , 300 );
insert into seg_mesure values ( 6  , 'C11' , 120 );
insert into seg_mesure values ( 7  , 'C11' , 80  );
insert into seg_mesure values ( 1  , 'C12' , 145 );
insert into seg_mesure values ( 2  , 'C12' , 160 );
insert into seg_mesure values ( 3  , 'C12' , 150 );
insert into seg_mesure values ( 4  , 'C12' , 100 );
insert into seg_mesure values ( 5  , 'C12' , 100 );
insert into seg_mesure values ( 6  , 'C12' , 70  );
insert into seg_mesure values ( 7  , 'C12' , 50  );
insert into seg_mesure values ( 8  , 'C12' , 30  );
insert into seg_mesure values ( 9  , 'C12' , 100 );
insert into seg_mesure values ( 10 , 'C12' , 120 );
insert into seg_mesure values ( 11 , 'C12' , 140 );
insert into seg_mesure values ( 12 , 'C12' , 172 );

insert into seg_technicien values ( 'T01' , 'LEFORT'       , 'Patrice'     , '06 22 33 44 55', to_date('23/09/1998','dd/mm/yyyy') , to_date('01/09/2020','dd/mm/yyyy') );
insert into seg_technicien values ( 'T02' , 'PALA'         , 'Mehdi'       , '06 22 33 44 56', to_date('04/04/2001','dd/mm/yyyy') , to_date('14/03/2023','dd/mm/yyyy') );
insert into seg_technicien values ( 'T03' , 'LADOUR'       , 'Vivianne'    , '06 22 33 44 56', to_date('15/05/1979','dd/mm/yyyy') , to_date('01/01/2000','dd/mm/yyyy') );
insert into seg_technicien values ( 'T04' , 'LEFORT'       , 'Patrice'     , '06 22 33 44 57', to_date('14/10/1965','dd/mm/yyyy') , to_date('13/05/1990','dd/mm/yyyy') );
insert into seg_technicien values ( 'T05' , 'LEGRAND'      , 'Bernard'     , '06 22 33 44 58', to_date('05/12/1962','dd/mm/yyyy') , to_date('10/04/1994','dd/mm/yyyy') );
insert into seg_technicien values ( 'T06' , 'LEPETIT'      , 'Jean-Pierre' , '06 66 66 66 66', to_date('08/02/1975','dd/mm/yyyy') , to_date('01/09/1987','dd/mm/yyyy') );
insert into seg_technicien values ( 'T07' , 'TROJ'         , 'Fabien'      , '06 66 66 66 66', to_date('13/03/1977','dd/mm/yyyy') , to_date('01/09/1993','dd/mm/yyyy') );
insert into seg_technicien values ( 'T08' , 'SUTURB'       , 'Philippe'    , '06 22 33 44 59', to_date('14/11/1966','dd/mm/yyyy') , to_date('01/09/1984','dd/mm/yyyy') );
insert into seg_technicien values ( 'T09' , 'LEBRAVE'      , 'Stéphane'    , '06 22 33 44 60', to_date('30/10/1980','dd/mm/yyyy') , to_date('01/01/2004','dd/mm/yyyy') );
insert into seg_technicien values ( 'T10' , 'RAHL'         , 'Richard'     , '06 22 33 44 61', to_date('07/06/2000','dd/mm/yyyy') , to_date('10/04/2022','dd/mm/yyyy') );
insert into seg_technicien values ( 'T15' , 'RAHL'         , 'Darken'      , '06 22 11 10 08', to_date('15/05/1967','dd/mm/yyyy') , to_date('15/06/1991','dd/mm/yyyy') );
insert into seg_technicien values ( 'T16' , 'MUDA'         , 'Robert'      , '06 99 88 77 66', to_date('23/04/1964','dd/mm/yyyy') , to_date('13/03/1987','dd/mm/yyyy') );
insert into seg_technicien values ( 'T18' , 'HAIBON'       , 'Sylvain'     , '06 33 44 58 66', to_date('10/01/1976','dd/mm/yyyy') , to_date('15/10/1998','dd/mm/yyyy') );
insert into seg_technicien values ( 'T19' , 'PLUTONITENDO' , 'Christelle'  , '06 40 50 60 60', to_date('04/11/1980','dd/mm/yyyy') , to_date('01/09/2013','dd/mm/yyyy') );
insert into seg_technicien values ( 'T21' , 'FACHER'       , 'Gwendoline'  , '06 38 49 58 60', to_date('27/02/1992','dd/mm/yyyy') , to_date('04/01/2023','dd/mm/yyyy') );
insert into seg_technicien values ( 'T22' , 'DELALUNE'     , 'Claire'      , '07 30 56 41 80', to_date('10/01/1994','dd/mm/yyyy') , to_date('01/09/2021','dd/mm/yyyy') );

insert into seg_reservoir values ( 'R01' , 'C01' , 'dôme du loup'             , 5000  );
insert into seg_reservoir values ( 'R02' , 'C01' , 'sauge en gévaudan'        , 4500  );
insert into seg_reservoir values ( 'R03' , 'C02' , 'la ferme aux loutres'     , 3500  );
insert into seg_reservoir values ( 'R04' , 'C02' , 'la cave'                  , 8000  );
insert into seg_reservoir values ( 'R05' , 'C03' , 'le champ de buisson'      , 6000  );
insert into seg_reservoir values ( 'R08' , 'C04' , 'Le puits du fioul'        , 2000  );
insert into seg_reservoir values ( 'R14' , 'C05' , 'la fontaine à eau'        , 500   );
insert into seg_reservoir values ( 'R17' , 'C06' , 'la forge principale'      , 700   );
insert into seg_reservoir values ( 'R18' , 'C06' , 'le lac Duc'               , 2500  );
insert into seg_reservoir values ( 'R19' , 'C07' , 'L''eau delà'              , 4500  );
insert into seg_reservoir values ( 'R20' , 'C07' , 'L''infini'                , 900   );
insert into seg_reservoir values ( 'R22' , 'C08' , 'le coin Bauer'            , 700   );
insert into seg_reservoir values ( 'R23' , 'C08' , 'Le trou glaçé'            , 600   );
insert into seg_reservoir values ( 'R31' , 'C11' , 'l''eau du plafond'        , 13500 );
insert into seg_reservoir values ( 'R32' , 'C11' , 'le sol stice'             , 6200  );
insert into seg_reservoir values ( 'R33' , 'C11' , '2236 hors d''eau'         , 200   );
insert into seg_reservoir values ( 'R36' , 'C12' , 'GIT Art'                  , 650   );
insert into seg_reservoir values ( 'R37' , 'C12' , 'La réserve JAVA'          , 780   );
insert into seg_reservoir values ( 'R38' , 'C12' , 'Hydro Conception'         , 840   );
insert into seg_reservoir values ( 'R63' , 'C16' , 'le trou sans soif'        , 8160  );
insert into seg_reservoir values ( 'R64' , 'C16' , 'le trou Normand'          , 10500 );
insert into seg_reservoir values ( 'R65' , 'C16' , 'les  couleures primaires' , 7200  );

insert into seg_aerien values ( 'R01' , 3  , 25 , 5  , 26 );
insert into seg_aerien values ( 'R08' , 11 , 30 , 8  , 21 );
insert into seg_aerien values ( 'R14' , 8  , 30 , 8  , 27 );
insert into seg_aerien values ( 'R17' , 7  , 25 , 4  , 31 );
insert into seg_aerien values ( 'R22' , 14 , 29 , 6  , 25 );
insert into seg_aerien values ( 'R23' , 15 , 41 , 11 , 15 );
insert into seg_aerien values ( 'R33' , 5  , 10 , 3  , 31 );
insert into seg_aerien values ( 'R63' , 8  , 17 , 5  , 25 );
insert into seg_aerien values ( 'R64' , 7  , 13 , 4  , 18 );

insert into seg_enterre values ( 'R02' , 49 );
insert into seg_enterre values ( 'R03' , 53 );
insert into seg_enterre values ( 'R04' , 60 );
insert into seg_enterre values ( 'R05' , 95 );
insert into seg_enterre values ( 'R18' , 65 );
insert into seg_enterre values ( 'R19' , 35 );
insert into seg_enterre values ( 'R20' , 58 );
insert into seg_enterre values ( 'R31' , 41 );
insert into seg_enterre values ( 'R32' , 77 );
insert into seg_enterre values ( 'R36' , 41 );
insert into seg_enterre values ( 'R37' , 99 );
insert into seg_enterre values ( 'R38' , 36 );
insert into seg_enterre values ( 'R65' , 65 );

insert into seg_alimenter_secours values ( 'R01' , 'C08' , 'T07' , 'ne pas déclencher la procédure d''urgence' );
insert into seg_alimenter_secours values ( 'R01' , 'C10' , 'T09' , 'activer le relai de pompage'               );
insert into seg_alimenter_secours values ( 'R02' , 'C08' , 'T07' , 'prévenir le centre de contrôle'            );
insert into seg_alimenter_secours values ( 'R02' , 'C07' , 'T10' , 'diminuer le débit d''un tiers'             );
insert into seg_alimenter_secours values ( 'R03' , 'C02' , 'T10' , 'enclencher la double alimentation'         );
insert into seg_alimenter_secours values ( 'R03' , 'C03' , 'T03' , 'baisser le grpupe de surpression'          );
insert into seg_alimenter_secours values ( 'R03' , 'C08' , 'T04' , 'ne pas activer le relai de pompage'        );
insert into seg_alimenter_secours values ( 'R64' , 'C12' , 'T21' , 'ne pas s''assoir à son bureau'             );
insert into seg_alimenter_secours values ( 'R65' , 'C12' , 'T22' , 'ne pas régler les vanne la nuit'           );

insert into seg_financeur values ( 1 , 'Ministère de l''agriculture'   , 'public' );
insert into seg_financeur values ( 2 , 'Ministère de l''environnement' , 'public' );
insert into seg_financeur values ( 3 , 'Ministère des finances'        , 'public' );
insert into seg_financeur values ( 51 , 'Office des eaux'              , 'privé' );
insert into seg_financeur values ( 52 , 'Sénior Météo'                 , 'privé' );

insert into seg_laboratoire values ( '4BC1' , 'EAU TARIE'   , '290,30' , to_date('10/04/2024','dd/mm/yyyy') );
insert into seg_laboratoire values ( '4BC9' , 'AGUATYCIA'   , '504,35' , to_date('01/03/2024','dd/mm/yyyy') );
insert into seg_laboratoire values ( '4CC4' , 'ANNE ALYSE'  , '110,90' , to_date('12/08/2023','dd/mm/yyyy') );
insert into seg_laboratoire values ( '4CC5' , 'BRITA'       , '120,60' , to_date('15/02/2023','dd/mm/yyyy') );
insert into seg_laboratoire values ( '4CD1' , 'EAU SECOURS' , '401,80' , to_date('17/05/2023','dd/mm/yyyy') );

insert into seg_analyse values ( 'R01' , 1 , '4BC1' ,'C05' , to_date('12/05/2021','dd/mm/yyyy') , 0 , 0 );
insert into seg_analyse values ( 'R01' , 2 , '4BC9' ,'C05' , to_date('17/05/2021','dd/mm/yyyy') , 0 , 0 );
insert into seg_analyse values ( 'R02' , 1 , '4BC9' ,'C09' , to_date('10/04/2022','dd/mm/yyyy') , 0 , 0 );
insert into seg_analyse values ( 'R02' , 2 , '4CC4' ,'C09' , to_date('01/05/2022','dd/mm/yyyy') , 1 , 0 );
insert into seg_analyse values ( 'R02' , 3 , '4CC5' ,'C09' , to_date('02/05/2022','dd/mm/yyyy') , 0 , 0 );
insert into seg_analyse values ( 'R03' , 1 , '4CC5' ,'C05' , to_date('02/03/2021','dd/mm/yyyy') , 0 , 0 );
insert into seg_analyse values ( 'R03' , 2 , '4CD1' ,'C05' , to_date('02/03/2014','dd/mm/yyyy') , 0 , 0 );
insert into seg_analyse values ( 'R03' , 3 , '4CD1' ,'C05' , to_date('02/03/2014','dd/mm/yyyy') , 0 , 0 );
insert into seg_analyse values ( 'R03' , 4 , '4CD1' ,'C05' , to_date('02/03/2014','dd/mm/yyyy') , 0 , 0 );
insert into seg_analyse values ( 'R63' , 5 , '4CD1' ,'C16' , to_date('05/04/2021','dd/mm/yyyy') , 0 , 0 );
insert into seg_analyse values ( 'R63' , 6 , '4CD1' ,'C16' , to_date('09/06/2021','dd/mm/yyyy') , 0 , 1 );
insert into seg_analyse values ( 'R64' , 7 , '4CD1' ,'C16' , to_date('02/07/2022','dd/mm/yyyy') , 1 , 0 );
insert into seg_analyse values ( 'R64' , 8 , '4CD1' ,'C16' , to_date('18/07/2022','dd/mm/yyyy') , 0 , 0 );

insert into seg_substance values ( 33 , 'arsenic'  , 10 );
insert into seg_substance values ( 82 , 'plomb'    , 25 );
insert into seg_substance values ( 48 , 'cadmium'  , 5  );
insert into seg_substance values ( 80 , 'mercure'  , 10 );
insert into seg_substance values ( 89 , 'gibolin'  , 33 );
insert into seg_substance values ( 97 , 'moutarde' , 14 );

insert into seg_contenir values ('R01' , 1 ,  33 , 5  );
insert into seg_contenir values ('R01' , 1 , 82 , 20 );
insert into seg_contenir values ('R01' , 1 , 48 , 6  );
insert into seg_contenir values ('R01' , 1 , 80 , 3  );
insert into seg_contenir values ('R01' , 2 , 33 , 4  );
insert into seg_contenir values ('R01' , 2 , 82 , 12 );
insert into seg_contenir values ('R01' , 2 , 48 , 3  );
insert into seg_contenir values ('R02' , 1 , 33 , 4  );
insert into seg_contenir values ('R02' , 1 , 82 , 12 );
insert into seg_contenir values ('R03' , 1 , 48 , 3  );
insert into seg_contenir values ('R03' , 1 , 80 , 4  );
insert into seg_contenir values ('R03' , 2 , 33 , 3  );
insert into seg_contenir values ('R03' , 3 , 82 , 19 );
insert into seg_contenir values ('R03' , 3 , 48 , 4  );
insert into seg_contenir values ('R03' , 4 , 80 , 12 );
insert into seg_contenir values ('R03' , 4 , 33 , 8 );

insert into seg_contenir values ('R64' , 8 , 33 , 8  );
insert into seg_contenir values ('R64' , 8 , 82 , 2  );
insert into seg_contenir values ('R64' , 8 , 80 , 41 );
insert into seg_contenir values ('R64' , 8 , 89 , 27 );
insert into seg_contenir values ('R64' , 8 , 97 , 10 );
commit;

SELECT * FROM SEG_MOIS ;
SELECT * FROM seg_mesure ;
SELECT * FROM SEG_CONTENIR ;
SELECT * FROM SEG_CAPTAGE ;
SELECT * FROM SEG_SUBSTANCE ;
SELECT * FROM SEG_POMPAGE ;
SELECT * FROM SEG_FORAGE ;
SELECT * FROM SEG_RESERVOIR ;
SELECT * FROM SEG_TECHNICIEN ;
SELECT * FROM SEG_ENTERRE ;
SELECT * FROM SEG_AERIEN ;
SELECT * FROM SEG_ALIMENTER_SECOURS ;
SELECT * FROM SEG_ANALYSE; 
select * from SEG_LABORATOIRE;
select * from SEG_FINANCEUR;

drop table seg_obtenir;
create table seg_obtenir
(
    lab_code varchar2(16),
    fin_code int,
    fin_date date,
    fin_valeur int,
    constraint pk_seg_obtenir primary key (lab_code, fin_code, fin_date)
);
alter table seg_obtenir add constraint fk1 foreign key (lab_code) references seg_laboratoire(lab_code);
alter table seg_obtenir add constraint fk2 foreign key (fin_code) references seg_financeur(fin_code);

insert into seg_technicien (tec_matricule, tec_nom, tec_prenom, tec_date_naiss, tec_date_embau)
values ('T11', 'PIERRE','Jean',to_date('02/06/1995', 'dd/mm/yyyy'), to_date('06/07/2010', 'dd/mm/yyyy')); 

select * from seg_technicien;
update seg_alimenter_secours
set tec_matricule = (select tec_matricule from seg_technicien where tec_nom ='SUTURB' and tec_prenom = 'Philippe')
where  tec_matricule = (select tec_matricule from seg_technicien where tec_nom ='TROJ' and tec_prenom = 'Fabien' );

select * from seg_alimenter_secours;

delete from seg_contenir where (ana_id, res_code) = (select ana_id, res_code from seg_analyse where lab_code in
(
    select lab_code from seg_laboratoire
    where lab_nom = 'EAU TARIE'
));

select * from seg_contenir;

/*1)*/
select tec_matricule, tec_prenom, substr(tec_nom, 1,1) || '***' as tec_nom from seg_technicien;
/*2)*/
select * from seg_technicien
join seg_alimenter_secours using (tec_matricule);
/*3)*/
select  tec_matricule, tec_nom, tec_prenom, tec_telephone, tec_date_naiss, tec_date_embau, res_code, cap_nom from seg_technicien
join seg_alimenter_secours using (tec_matricule)
join seg_captage using (cap_code)
union
select tec_matricule, tec_nom, tec_prenom, tec_telephone, tec_date_naiss, tec_date_embau, res_code, 'Aucun' as cap_nom from seg_technicien
left join  seg_alimenter_secours using (tec_matricule)
join seg_captage using (cap_code);

/*4)*/

select sub_nom, round(avg(con_quantite),2) as quant_moyenne, sub_valmax from seg_contenir
join seg_substance using(sub_code)
group by sub_nom, sub_valmax;

/*5)*/

select res_code, ana_id, sum(lab_prix) ||' $' as prix from seg_analyse
join seg_laboratoire using (lab_code)
join seg_contenir using(res_code, ana_id)
having sum(lab_prix)> 500
group by res_code, ana_id;

/*6)*/
create or replace view seg_total_analyse (total) as 
select count(ana_id) from seg_contenir;

select * from seg_total_analyse;
select sub_nom, count(ana_id) as nombre_analyse,  total  as total  from seg_contenir cross join seg_total_analyse
join seg_substance using (sub_code)
join seg_analyse using (res_code, ana_id)
group by sub_nom, total;

select sub_nom, count(ana_id) as nombre_analyse  from seg_contenir cross join seg_total_analyse
join seg_substance using (sub_code)
join seg_analyse using (res_code, ana_id)
group by sub_nom, total
union
select 'TOTAL', count(ana_id) from seg_contenir;

/*7)*/

select avg(pos_debit_moyen) as total from seg_mesure;

select moi_libelle, sum(pos_debit_moyen) as quantite_moyenne from seg_mois
join seg_mesure using (moi_numero)
having sum(pos_debit_moyen)> (select avg(pos_debit_moyen) as moyenne from seg_mesure)
group by moi_libelle;