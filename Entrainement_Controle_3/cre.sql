-- -----------------------------------------------------------------------------
--             Génération d'une base de données pour
--                      Oracle Version 10g
--                     (2/2/2024 11;30;18)
-- -----------------------------------------------------------------------------
--      Nom de la base ; MLR
--      Projet ; cre
--      Auteur ; Eric Porcq
--      Date de dernière modification ; 2/2/2024 11;30;05
-- -----------------------------------------------------------------------------

DROP TABLE CRE_AVENANT CASCADE CONSTRAINTS;
DROP TABLE CRE_IMPAYES CASCADE CONSTRAINTS;
DROP TABLE CRE_SIGNATAIRE CASCADE CONSTRAINTS;
DROP TABLE CRE_VEHICULE CASCADE CONSTRAINTS;
DROP TABLE CRE_CONTRAT CASCADE CONSTRAINTS;
DROP TABLE CRE_INTERVENANT CASCADE CONSTRAINTS;
DROP TABLE CRE_VENDEUR_PRO CASCADE CONSTRAINTS;
DROP TABLE CRE_DOSSIER_NUMERIQUE CASCADE CONSTRAINTS;
DROP TABLE CRE_MISSION CASCADE CONSTRAINTS;
DROP TABLE CRE_GARANT CASCADE CONSTRAINTS;

CREATE TABLE CRE_AVENANT
(
    CON_NUM VARCHAR2(32)  NOT NULL,
    AVE_NUM NUMBER(2)  NOT NULL,
    AVE_DATE_SIGNATURE DATE  NULL,
    AVE_JOUR_ÉCHÉANCE NUMBER(2)  NULL,
    AVE_NB_MENSUALITE NUMBER  NULL,
    --AVE_MONTANT_ECHEANCE NUMBER  NULL,
    CONSTRAINT PK_CRE_AVENANT PRIMARY KEY (CON_NUM, AVE_NUM)  
);
-- champ calculable

CREATE  INDEX I_FK_CRE_AVENANT_CRE_CONTRAT
     ON CRE_AVENANT (CON_NUM ASC);

CREATE TABLE CRE_IMPAYES
(
    CON_NUM VARCHAR2(32)  NOT NULL,
    IMP_NUM NUMBER(3)  NOT NULL,
    AVE_NUM NUMBER(2)  NULL,
    IMP_DATE DATE  NULL,
    CONSTRAINT PK_CRE_IMPAYES PRIMARY KEY (CON_NUM, IMP_NUM)  
);

CREATE  INDEX I_FK_CRE_IMPAYES_CRE_AVENANT
     ON CRE_IMPAYES (AVE_NUM ASC);

CREATE  INDEX I_FK_CRE_IMPAYES_CRE_CONTRAT
     ON CRE_IMPAYES (CON_NUM ASC);

CREATE TABLE CRE_SIGNATAIRE
(
    SIG_ID VARCHAR2(16) ,
    SIG_NOM VARCHAR2(32)  NULL,
    SIG_PRENOM VARCHAR2(32)  NULL,
    SIG_ADRESSE VARCHAR2(128)  NULL,
    SIG_VILLE VARCHAR2(128)  NULL,
    SIG_CODE_POSTAL VARCHAR2(16)  NULL,
    SIG_PROFESSION VARCHAR2(128)  NULL,
    SIG_TELEPHONE CHAR(10)  NULL,
    SIG_RIB CHAR(13)  NULL,
    CONSTRAINT PK_CRE_SIGNATAIRE PRIMARY KEY (SIG_ID)  
);

CREATE TABLE CRE_VEHICULE
(
    VEH_NUM_SERIE VARCHAR2(20)  NOT NULL,
    VEH_MARQUE VARCHAR2(32)  NULL,
    VEH_TYPE VARCHAR2(32)  NULL,
    VEH_IMMATRICULATION VARCHAR2(16)  NULL,
    VEH_DATE_MEC DATE  NOT NULL,
    CONSTRAINT PK_CRE_VEHICULE PRIMARY KEY (VEH_NUM_SERIE),
    CONSTRAINT U_CRE_VEHICULE UNIQUE(VEH_IMMATRICULATION)  
);

CREATE TABLE CRE_CONTRAT
(
    CON_NUM VARCHAR2(32)  NOT NULL,
    VEH_NUM_SERIE VARCHAR2(20)  NOT NULL,
    SIG_ID VARCHAR2(16)  NOT NULL,
    CON_MONTANT_ACHAT NUMBER  NULL,
    CON_MONTANT_PRET NUMBER  NULL,
    CON_NEUF_OCCAS RAW(1)  NULL,
    CON_DATE_SIGNATURE DATE  NULL,
    CON_TAUX_ANNUEL NUMBER  NULL,
    CON_DUREE_INIT NUMBER(3)  NULL,
    CON_JOUR_ECHEANCE NUMBER(2)  NULL,
    CON_DAT_PRE_ECHEANCE DATE  NULL,
    -- CON_MENSUALITE NUMBER  NULL,
    -- CON_CAPITAL_RESTANT NUMBER  NULL,
    CONSTRAINT PK_CRE_CONTRAT PRIMARY KEY (CON_NUM)  
);
-- champs calculables

CREATE  INDEX I_FK_CRE_CONTRAT_CRE_VEHICULE
     ON CRE_CONTRAT (VEH_NUM_SERIE ASC);

CREATE  INDEX I_FK_CRE_CONTRAT_CRE_SIGNATAIR
     ON CRE_CONTRAT (SIG_ID ASC);

CREATE TABLE CRE_INTERVENANT
(
    INT_NUM NUMBER(6)  NOT NULL,
    INT_NOM VARCHAR2(32)  NULL,
    INT_PRENOM VARCHAR2(32)  NULL,
    CONSTRAINT PK_CRE_INTERVENANT PRIMARY KEY (INT_NUM)  
);

CREATE TABLE CRE_VENDEUR_PRO
(
    VEP_SIRET VARCHAR2(16)  NOT NULL,
    VEP_NOM VARCHAR2(64)  NULL,
    VEP_VILLE VARCHAR2(32)  NULL,
    VEP_TELEPHONE VARCHAR2(16)  NULL,
    CONSTRAINT PK_CRE_VENDEUR_PRO PRIMARY KEY (VEP_SIRET)  
);

CREATE TABLE CRE_DOSSIER_NUMERIQUE
(
    CON_NUM VARCHAR2(32),
    DOS_NUM NUMBER(2),
    DOS_LIBELLE VARCHAR2(60)  NULL,
    DOS_CHEMIN VARCHAR2(60)  NULL,
    DOS_DATE DATE  NULL,
    CONSTRAINT PK_CRE_DOSSIER_NUMERIQUE PRIMARY KEY (CON_NUM, DOS_NUM)  
);

CREATE  INDEX I_FK_CRE_DOSSIER_NUMERIQUE_CRE
     ON CRE_DOSSIER_NUMERIQUE (CON_NUM ASC);

CREATE TABLE CRE_MISSION
(
    MIS_NUM NUMBER(4),
    INT_NUM NUMBER(6),
    CON_NUM VARCHAR2(32)  NOT NULL,
    MIS_DATE_DEBUT DATE  NULL,
    MIS_DATE_CLOTURE DATE  NULL,
    MIS_COMMENTAIRE VARCHAR2(128)  NULL,
    CONSTRAINT PK_CRE_MISSION PRIMARY KEY (MIS_NUM)  
);

CREATE  INDEX I_FK_CRE_MISSION_CRE_INTERVENA
     ON CRE_MISSION (INT_NUM ASC);

CREATE  INDEX I_FK_CRE_MISSION_CRE_CONTRAT
     ON CRE_MISSION (CON_NUM ASC);



CREATE TABLE CRE_GARANT
(
    SIG_ID VARCHAR2(16)  NOT NULL,
    CON_NUM VARCHAR2(32)  NOT NULL,
    AVE_NUM NUMBER(2)  NOT NULL,
    GAR_RANG NUMBER(1)  NULL,
    CONSTRAINT PK_CRE_GARANT PRIMARY KEY (SIG_ID, CON_NUM, AVE_NUM)  
);

CREATE  INDEX I_FK_CRE_GARANT_CRE_SIGNATAIRE
     ON CRE_GARANT (SIG_ID ASC);

CREATE  INDEX I_FK_CRE_GARANT_CRE_AVENANT
     ON CRE_GARANT (CON_NUM ASC, AVE_NUM ASC);

ALTER TABLE CRE_AVENANT ADD (
     CONSTRAINT FK_CRE_AVENANT_CRE_CONTRAT
          FOREIGN KEY (CON_NUM)
               REFERENCES CRE_CONTRAT (CON_NUM));

ALTER TABLE CRE_IMPAYES ADD (
     CONSTRAINT FK_CRE_IMPAYES_CRE_AVENANT
          FOREIGN KEY (CON_NUM, AVE_NUM)
               REFERENCES CRE_AVENANT (CON_NUM, AVE_NUM));

ALTER TABLE CRE_IMPAYES ADD (
     CONSTRAINT FK_CRE_IMPAYES_CRE_CONTRAT
          FOREIGN KEY (CON_NUM)
               REFERENCES CRE_CONTRAT (CON_NUM));

ALTER TABLE CRE_CONTRAT ADD (
     CONSTRAINT FK_CRE_CONTRAT_CRE_VEHICULE
          FOREIGN KEY (VEH_NUM_SERIE)
               REFERENCES CRE_VEHICULE (VEH_NUM_SERIE));

ALTER TABLE CRE_CONTRAT ADD (
     CONSTRAINT FK_CRE_CONTRAT_CRE_SIGNATAIRE
          FOREIGN KEY (SIG_ID)
               REFERENCES CRE_SIGNATAIRE (SIG_ID));

ALTER TABLE CRE_DOSSIER_NUMERIQUE ADD (
     CONSTRAINT FK_CRE_DOSSIER_NUMERIQUE_CRE_C
          FOREIGN KEY (CON_NUM)
               REFERENCES CRE_CONTRAT (CON_NUM));

ALTER TABLE CRE_MISSION ADD (
     CONSTRAINT FK_CRE_MISSION_CRE_INTERVENANT
          FOREIGN KEY (INT_NUM)
               REFERENCES CRE_INTERVENANT (INT_NUM));

ALTER TABLE CRE_MISSION ADD (
     CONSTRAINT FK_CRE_MISSION_CRE_CONTRAT
          FOREIGN KEY (CON_NUM)
               REFERENCES CRE_CONTRAT (CON_NUM));

ALTER TABLE CRE_GARANT ADD (
     CONSTRAINT FK_CRE_GARANT_CRE_SIGNATAIRE
          FOREIGN KEY (SIG_ID)
               REFERENCES CRE_SIGNATAIRE (SIG_ID));

ALTER TABLE CRE_GARANT ADD (
     CONSTRAINT FK_CRE_GARANT_CRE_AVENANT
          FOREIGN KEY (CON_NUM, AVE_NUM)
               REFERENCES CRE_AVENANT (CON_NUM, AVE_NUM));


-- -----------------------------------------------------------------------------
--                FIN DE GENERATION
-- -----------------------------------------------------------------------------


insert into cre_vehicule values ('VF7534389HGF32' , 'Citroën'    , 'BX 1.6 GL'                    , '666ZZ14'  , to_date('01/12/1995' , 'dd/mm/yyyy') ); 
insert into cre_vehicule values ('VF7534384HNSDT' , 'Renault'    , 'Ranault 18 GTS'               , '666KK14'  , to_date('01/12/1995' , 'dd/mm/yyyy') ); 
insert into cre_vehicule values ('WBAAS71000FY27' , 'BMW'        , 'BMW Série 3 Cabriolet'        , '1253BC25' , to_date('03/03/2017' , 'dd/mm/yyyy') );
insert into cre_vehicule values ('WWWA3410018910' , 'Volkswagen' , 'GOLF III GTI'                 , '123NAZ75' , to_date('10/09/2017' , 'dd/mm/yyyy') );
insert into cre_vehicule values ('VF1FRS45FDG1F3' , 'Renault'    , 'CLIO 1.9 D EXAMEN'            , '156RTT78' , to_date('16/05/2018' , 'dd/mm/yyyy') );
insert into cre_vehicule values ('VF1FRS45FDG1F4' , 'Renault'    , 'CLIO 1.9 D EXAMEN'            , '156RTU78' , to_date('16/05/2018' , 'dd/mm/yyyy') );
insert into cre_vehicule values ('VF353485GHR123' , 'Peugeot'    , '207 2.0 HDI ELCARO'           , '1811ZA14' , to_date('12/04/2019' , 'dd/mm/yyyy') );
insert into cre_vehicule values ('WVWZZZ1JZXW236' , 'Volkswagen' , 'GOLF V PERSIQUE'              , 'KB336BN'  , to_date('15/11/2019' , 'dd/mm/yyyy') );
insert into cre_vehicule values ('ZFF007FGD4FD5D' , 'Ferrari'    , 'F430'                         , '007JB14'  , to_date('01/01/2020' , 'dd/mm/yyyy') );
insert into cre_vehicule values ('5BP004FG445GD0' , 'Hyundai'    , 'HYUNDAI TRAJET 2.0 CRDI PACK' , '654ABC76' , to_date('29/03/2020' , 'dd/mm/yyyy') );
insert into cre_vehicule values ('VF34C9HZH55243' , 'Peugeot'    , '308 TAYOU'                    , 'BT302AK'  , to_date('29/05/2021' , 'dd/mm/yyyy') );
insert into cre_vehicule values ('WVWZZZ1JZXW235' , 'Volkswagen' , 'GOLF V PERSIQUE'              , 'KB336BK'  , to_date('01/10/2021' , 'dd/mm/yyyy') );
insert into cre_vehicule values ('VF34C9HZH55245' , 'Peugeot'    , '308 TAYOU'                    , 'BT305AL'  , to_date('14/06/2022' , 'dd/mm/yyyy') );
insert into cre_vehicule values ('M10AUDDDB11207' , 'Audi'       , 'A4 2.0 TDI'                   , 'BN987JM'  , to_date('24/04/2022' , 'dd/mm/yyyy') );
insert into cre_vehicule values ('VF7534389HGF39' , 'Citroën'    , 'C3 III'                       , 'NN351GG'  , to_date('05/05/2022' , 'dd/mm/yyyy') );
insert into cre_vehicule values ('WVWZZZ1JZXW230' , 'Fiat'       , 'Fiat 500'                     , 'KP401UU'  , to_date('04/12/2023' , 'dd/mm/yyyy') );

insert into cre_signataire values ('P12802' , 'MARIE'       , 'Veronique' , '3 rue du blé'             , 'CAEN'         , '14100' , 'Carleur'      , '0231828282' , '030529506736'  );
insert into cre_signataire values ('P12803' , 'TROILOUKOUM' , 'Vivien'    , '2 rue cardinal Lavigerie' , 'CAEN'         , '14300' , 'Dentiste'     , '0231828260' , '030521234736'  );
insert into cre_signataire values ('P12805' , 'HOUSSEL'     , 'Kader'     , '63 Oracle Road'           , 'PARIS'        , '75010' , 'Météorologue' , '0284828260' , '030521234126'  );
insert into cre_signataire values ('P12809' , 'MARIE'       , 'Josiane'   , '6 avenue Philipe B.'      , 'IFS'          , '14123' , 'Enseignant'   , '0231987654' , '040508416566'  );
insert into cre_signataire values ('P12808' , 'SUPER'       , 'Julian'    , '5 allée des tomates'      , 'IFS'          , '14123' , 'Caissier'     , '0624323244' , '0405084165258' );
insert into cre_signataire values ('P12810' , 'POULEQ'      , 'Patrick'   , '4 boullevard Platini'     , 'NANTES'       , '44000' , 'Soudeur'      , '0628323285' , '8205086542348' );
insert into cre_signataire values ('P12813' , 'NEIGE'       , 'Blanche'   , '5 rue du Bois'            , 'NANTES'       , '44000' , 'Infirmier'    , '0624323678' , '9205033542365' );
insert into cre_signataire values ('P12814' , 'PETIOT'      , 'Marcel'    , 'impasse des panthères'    , 'CAEN'         , '14000' , 'Guérisseur'   , ''           , '9205033542365' );
insert into cre_signataire values ('P12816' , 'MARIO'       , 'Super'     , '3 rue de la centrale'     , 'CHERBOURG'    , '50100' , 'Plombier'     , '0606070799' , '1645032542390' );
insert into cre_signataire values ('P12830' , 'BAGGINS'     , 'Bilbo'     , '4 cul de sac'             , 'HOBBITEBOURG' , '14123' , 'Cuisinier'    , '0231484848' , '1234532542390' );
insert into cre_signataire values ('P12839' , 'MUDA'        , 'Robert'    , '1 rue du C3'              , 'IFS'          , '14123' , 'Artiste'      , '0235564848' , '1298732542390' );
insert into cre_signataire values ('P12888' , 'CEBRAVE'     , 'Stéphane'  , '6 rue du bois'            , 'CAEN'         , '14000' , 'Cycliste'     , '0615202530' , '1234532123457' );
insert into cre_signataire values ('P12901' , 'TRUST'       , 'Kylian'    , '5 rue des rosiers'        , 'CHERBOURG'    , '14000' , 'Cuisinier'     , '0614834646' , '987908798709'  );
insert into cre_signataire values ('P12904' , 'YOUNG'       , 'Angus'     , '2 rue cardinal Lavigerie' , 'CAEN'         , '14000' , 'Médecein'      , '0645789088' , '456067897890'  );
insert into cre_signataire values ('P12909' , 'KNOPFLER'    , 'Mark'      , '1 Avenue du 06 Juin'      , 'CAEN'         , '14000' , 'Couvreur'      , '0612478798' , '154649878098'  );
insert into cre_signataire values ('P12916' , 'SECHAN'      , 'Elsa'      , '5 Avenue du 06 Juin'      , 'CAEN'         , '14000' , 'Kiné'          , '0705464646' , '489087909870'  );
insert into cre_signataire values ('P12934' , 'DELALUNE'    , 'Claire'    , '16 rue de saintonge'      , 'IFS'          , '14123' , 'Enseignant'    , '0754646488' , '464606879797'  );


-- select * from cre_contrat;
-- attention jour_echeance doit correspondre date première échéance
insert into cre_contrat values ('01800019959' , 'WBAAS71000FY27' , 'P12805' , 16000 , 10000 , '0' , to_date('25/11/2017','dd/mm/yyyy') , 3.9 , 40 , 1  , to_date('01/12/2017','dd/mm/yyyy') );
insert into cre_contrat values ('01800020348' , 'VF1FRS45FDG1F3' , 'P12802' , 15500 , 15500 , '1' , to_date('17/05/2018','dd/mm/yyyy') , 3.8 , 48 , 1  , to_date('01/06/2014','dd/mm/yyyy') );
insert into cre_contrat values ('01800020320' , 'VF353485GHR123' , 'P12803' , 18000 , 12000 , '1' , to_date('18/04/2019','dd/mm/yyyy') , 4.2 , 36 , 3  , to_date('03/05/2019','dd/mm/yyyy') );
insert into cre_contrat values ('01800020349' , 'WWWA3410018910' , 'P12808' , 21000 , 15000 , '1' , to_date('14/05/2019','dd/mm/yyyy') , 3.6 , 48 , 5  , to_date('05/06/2019','dd/mm/yyyy') );
insert into cre_contrat values ('01800045387' , 'VF1FRS45FDG1F4' , 'P12805' , 9000  , 5000  , '1' , to_date('12/05/2020','dd/mm/yyyy') , 4.1 , 36 , 8  , to_date('08/06/2020','dd/mm/yyyy') );
insert into cre_contrat values ('01800020350' , '5BP004FG445GD0' , 'P12809' , 8000  , 8000  , '1' , to_date('14/05/2021','dd/mm/yyyy') , 4.1 , 60 , 5  , to_date('05/06/2021','dd/mm/yyyy') );
insert into cre_contrat values ('02200043458' , 'VF34C9HZH55243' , 'P12830' , 16000 , 5500  , '1' , to_date('30/06/2021','dd/mm/yyyy') , 2.7 , 36 , 3  , to_date('03/07/2021','dd/mm/yyyy') );
insert into cre_contrat values ('02200043504' , 'WVWZZZ1JZXW236' , 'P12901' , 16900 , 10000 , '0' , to_date('10/01/2022','dd/mm/yyyy') , 2.7 , 36 , 7  , to_date('07/02/2022','dd/mm/yyyy') );
insert into cre_contrat values ('01800012684' , 'ZFF007FGD4FD5D' , 'P12810' , 75000 , 3000  , '0' , to_date('01/04/2022','dd/mm/yyyy') , 2.5 , 12 , 1  , to_date('01/05/2022','dd/mm/yyyy') );
insert into cre_contrat values ('02200043470' , 'VF34C9HZH55245' , 'P12808' , 16300 , 7500  , '1' , to_date('04/07/2022','dd/mm/yyyy') , 2.3 , 32 , 4  , to_date('04/08/2022','dd/mm/yyyy') );
insert into cre_contrat values ('01800010359' , 'VF7534389HGF32' , 'P12813' , 3000  , 3000  , '0' , to_date('05/09/2022','dd/mm/yyyy') , 4.6 , 24 , 8  , to_date('08/10/2022','dd/mm/yyyy') );
insert into cre_contrat values ('02200043508' , 'VF7534389HGF39' , 'P12904' , 10400 , 6000  , '0' , to_date('16/10/2022','dd/mm/yyyy') , 2.8 , 48 , 16 , to_date('16/11/2022','dd/mm/yyyy') );
insert into cre_contrat values ('02200043495' , 'M10AUDDDB11207' , 'P12805' , 13500 , 2500  , '0' , to_date('24/12/2022','dd/mm/yyyy') , 2.2 , 24 , 5  , to_date('05/01/2023','dd/mm/yyyy') );
insert into cre_contrat values ('02200043509' , 'WVWZZZ1JZXW230' , 'P12909' , 9500  , 9500  , '1' , to_date('05/01/2023','dd/mm/yyyy') , 3.1 , 60 , 5  , to_date('05/02/2023','dd/mm/yyyy') );

insert into cre_dossier_numerique values ('01800020348' ,1 , 'feuilles de paye'   , 'c;\contrat\01800020348\paye.pdf'   , to_date('20/05/2018','dd/mm/yyyy') );
insert into cre_dossier_numerique values ('01800020348' ,2 , 'relevés banquaires' , 'c;\contrat\01800020348\releve.pdf' , to_date('20/05/2018','dd/mm/yyyy') );
insert into cre_dossier_numerique values ('01800020348' ,3 , 'feuille impot'      , 'c;\contrat\01800020348\impot.pdf'  , to_date('20/05/2018','dd/mm/yyyy') );
insert into cre_dossier_numerique values ('01800020320' ,1 , 'feuilles de paye'   , 'c;\contrat\01800020320\paye.pdf'   , to_date('18/04/2019','dd/mm/yyyy') );
insert into cre_dossier_numerique values ('01800020320' ,2 , 'relevés banquaires' , 'c;\contrat\01800020320\releve.pdf' , to_date('18/04/2019','dd/mm/yyyy') );
insert into cre_dossier_numerique values ('01800020320' ,3 , 'feuille impot'      , 'c;\contrat\01800020320\impot.pdf'  , to_date('18/04/2019','dd/mm/yyyy') );
insert into cre_dossier_numerique values ('02200043504' ,1 , 'feuilles de paye'   , 'c;\contrat\02200043504\paye.pdf'   , to_date('10/01/2022','dd/mm/yyyy') );
insert into cre_dossier_numerique values ('01800010359' ,1 , 'feuilles de paye'   , 'c;\contrat\01800010359\paye.pdf'   , to_date('05/09/2022','dd/mm/yyyy') );
insert into cre_dossier_numerique values ('01800010359' ,2 , 'relevés banquaires' , 'c;\contrat\01800010359\releve.pdf' , to_date('05/09/2022','dd/mm/yyyy') );
insert into cre_dossier_numerique values ('01800010359' ,3 , 'feuille impot'      , 'c;\contrat\01800010359\impot.pdf'  , to_date('05/09/2022','dd/mm/yyyy') );
insert into cre_dossier_numerique values ('02200043504' ,2 , 'relevés banquaires' , 'c;\contrat\02200043504\releve.pdf' , to_date('14/10/2022','dd/mm/yyyy') );
insert into cre_dossier_numerique values ('02200043504' ,3 , 'feuille impot'      , 'c;\contrat\02200043504\impot.pdf'  , to_date('31/12/2022','dd/mm/yyyy') );

insert into cre_intervenant values (980045 , 'DELIVAROT'  , 'Paul'       );
insert into cre_intervenant values (980054 , 'MOUTARDE'   , 'Colonel'    );
insert into cre_intervenant values (980115 , 'PASSAMSUNG' , 'Christelle' );
insert into cre_intervenant values (980007 , 'LEBRETON'   , 'Fabienne'   );
insert into cre_intervenant values (980666 , 'WINTERFRAU' , 'Albrecht'   );
insert into cre_intervenant values (980685 , 'HABEL'      , 'Samir'      );
insert into cre_intervenant values (980701 , 'DEROCHE'    , 'Marlène'     );
insert into cre_intervenant values (980705 , 'DUTALENT'    , 'Frédéric'   );

insert into cre_mission values (104 ,980045 ,'01800020350' ,to_date('01/07/2022','dd/mm/yyyy') , to_date('10/07/2022','dd/mm/yyyy') , 'hors état de nuire'                                             );
insert into cre_mission values (95  ,980045 ,'01800012684' ,to_date('01/10/2022','dd/mm/yyyy') , to_date('1/11/2022','dd/mm/yyyy')  , 'les difficultés sont elles dûes à une entretien trop onéreux ?' );
insert into cre_mission values (111 ,980054 ,'01800020350' ,to_date('04/10/2022','dd/mm/yyyy') , to_date('12/10/2022','dd/mm/yyyy') , 'reaménager le prêt cautionneur'                                 );
insert into cre_mission values (100 ,980666 ,'02200043508' ,to_date('30/11/2022','dd/mm/yyyy') , to_date('04/11/2023','dd/mm/yyyy') , 'inciter à payer régulièrement'                                  );
insert into cre_mission values (101 ,980045 ,'01800012684' ,to_date('13/01/2023','dd/mm/yyyy') , to_date('25/03/2023','dd/mm/yyyy') , 'reaménager le prêt cautionneur; proposer vente véhicule'        );
insert into cre_mission values (124 ,980054 ,'01800020350' ,to_date('01/02/2023','dd/mm/yyyy') , to_date('01/04/2023','dd/mm/yyyy') , 'reaménager le prêt cautionneur; proposer vente véhicule'        );
insert into cre_mission values (132 ,980115 ,'01800020349' ,to_date('20/02/2023','dd/mm/yyyy') , ''                                 , 'menacer de sévices corporels'                                   );
insert into cre_mission values (136 ,980685 ,'01800020320' ,to_date('01/02/2023','dd/mm/yyyy') , to_date('10/02/2023','dd/mm/yyyy') , 'retrait de l''option tout SQL'                                  );
insert into cre_mission values (137 ,980666 ,'02200043508' ,to_date('04/02/2023','dd/mm/yyyy') , to_date('10/06/2023','dd/mm/yyyy') , 'reaménager le prêt cautionneur'                                 );
insert into cre_mission values (130 ,980007 ,'01800020349' ,to_date('10/12/2023','dd/mm/yyyy') , to_date('13/12/2019','dd/mm/yyyy') , 'inciter à payer régulièrement'                                  );
insert into cre_mission values (139 ,980685 ,'01800020320' ,to_date('20/02/2023','dd/mm/yyyy') , to_date('22/02/2023','dd/mm/yyyy') , 'mutation en RT'                                                 );
insert into cre_mission values (168 ,980666 ,'01800020320' ,to_date('25/02/2023','dd/mm/yyyy') , to_date('16/04/2023','dd/mm/yyyy') , 'Séance de claquettes pour incroyable talons'                    );
insert into cre_mission values (206 ,980666 ,'02200043509' ,to_date('10/08/2023','dd/mm/yyyy') , to_date('15/12/2023','dd/mm/yyyy') , 'inciter à payer régulièrement'                                  );
insert into cre_mission values (209 ,980666 ,'02200043508' ,to_date('01/09/2023','dd/mm/yyyy') , ''                                 , 'reaménager le prêt cautionneur'                                 );
insert into cre_mission values (305 ,980666 ,'02200043509' ,to_date('15/12/2023','dd/mm/yyyy') , ''                                 , 'Proposer de partager le véhicule'                               );


insert into cre_avenant values ('01800020349' , 1 , to_date('01/02/2016','dd/mm/yyyy') , 4 , 60 );
insert into cre_avenant values ('01800045387' , 1 , to_date('10/12/2016','dd/mm/yyyy') , 8 , 55 );
insert into cre_avenant values ('01800045387' , 2 , to_date('06/03/2017','dd/mm/yyyy') , 8 , 60 );
insert into cre_avenant values ('01800020350' , 1 , to_date('01/09/2018','dd/mm/yyyy') , 4 , 72 );
insert into cre_avenant values ('01800020350' , 2 , to_date('03/11/2018','dd/mm/yyyy') , 4 , 84 );
insert into cre_avenant values ('01800020350' , 3 , to_date('20/02/2019','dd/mm/yyyy') , 7 , 60 );
insert into cre_avenant values ('01800020350' , 4 , to_date('28/02/2019','dd/mm/yyyy') , 7 , 84 );
insert into cre_avenant values ('02200043508' , 1 , to_date('04/03/2023','dd/mm/yyyy') , 2 , 60 );
insert into cre_avenant values ('02200043508' , 2 , to_date('01/10/2023','dd/mm/yyyy') , 2 , 72 );
insert into cre_avenant values ('02200043509' , 1 , to_date('01/02/2024','dd/mm/yyyy') , 2 , 72 );

insert into cre_impayes values ('01800020349' , 1 , null , to_date('10/07/2019','dd/mm/yyyy') );
insert into cre_impayes values ('01800020349' , 2 , null , to_date('10/12/2020','dd/mm/yyyy') );
insert into cre_impayes values ('01800020350' , 1 , null , to_date('01/05/2022','dd/mm/yyyy') );
insert into cre_impayes values ('01800020350' , 2 , null , to_date('05/08/2022','dd/mm/yyyy') );
insert into cre_impayes values ('01800020350' , 3 , null , to_date('03/12/2022','dd/mm/yyyy') );
insert into cre_impayes values ('01800012684' , 1 , null , to_date('01/08/2022','dd/mm/yyyy') );
insert into cre_impayes values ('01800012684' , 2 , null , to_date('01/09/2022','dd/mm/yyyy') );
insert into cre_impayes values ('02200043508' , 1 , null , to_date('01/08/2022','dd/mm/yyyy') );
insert into cre_impayes values ('02200043508' , 2 , null , to_date('01/09/2022','dd/mm/yyyy') );
insert into cre_impayes values ('02200043508' , 3 , null , to_date('01/10/2022','dd/mm/yyyy') );
insert into cre_impayes values ('02200043508' , 4 , null , to_date('01/11/2022','dd/mm/yyyy') );
insert into cre_impayes values ('02200043508' , 5 , null , to_date('01/12/2023','dd/mm/yyyy') );
insert into cre_impayes values ('02200043508' , 6 , 1    , to_date('02/07/2024','dd/mm/yyyy') );
insert into cre_impayes values ('02200043508' , 7 , 1    , to_date('02/08/2024','dd/mm/yyyy') );
insert into cre_impayes values ('01800020320' , 1 , null , to_date('01/11/2022','dd/mm/yyyy') );
insert into cre_impayes values ('01800020320' , 2 , null , to_date('01/01/2023','dd/mm/yyyy') );
insert into cre_impayes values ('01800020320' , 3 , null , to_date('01/02/2023','dd/mm/yyyy') );
insert into cre_impayes values ('02200043509' , 1 , null , to_date('01/10/2023','dd/mm/yyyy') );
insert into cre_impayes values ('02200043509' , 2 , null , to_date('01/11/2023','dd/mm/yyyy') );
insert into cre_impayes values ('02200043509' , 3 , null , to_date('01/12/2023','dd/mm/yyyy') );

insert into cre_garant values ('P12816' , '01800020350' , 1 , 1 );
insert into cre_garant values ('P12814' , '01800020350' , 1 , 2 );
insert into cre_garant values ('P12830' , '01800020350' , 2 , 1 );
insert into cre_garant values ('P12830' , '01800020350' , 3 , 1 );
insert into cre_garant values ('P12839' , '01800020350' , 4 , 1 );
insert into cre_garant values ('P12830' , '01800020350' , 4 , 2 );
insert into cre_garant values ('P12803' , '01800020349' , 1 , 1 );
insert into cre_garant values ('P12803' , '01800045387' , 1 , 1 );
insert into cre_garant values ('P12803' , '01800045387' , 2 , 1 );

insert into cre_garant values ('P12909' , '02200043508' , 1 , 1 );
insert into cre_garant values ('P12916' , '02200043508' , 2 , 2 );
insert into cre_garant values ('P12934' , '02200043509' , 1 , 1 );

insert into cre_vendeur_pro values ('8745347451234' , 'AUTO RHINO'  , 'Caen'        , '0231242478');
insert into cre_vendeur_pro values ('6464878974248' , 'AUTO LARD'   , 'Caen'        , '0231568746');
insert into cre_vendeur_pro values ('7654650657465' , 'MAUD AUTO'   , 'Caen'        , '0231224488');
insert into cre_vendeur_pro values ('4654897454654' , 'JEAN TALUT'  , 'Mondeville'  , '0231669957');


commit;

select * from cre_vehicule;
select * from CRE_INTERVENANT;
select * from cre_dossier_numerique;
select * from cre_mission;
select * from cre_contrat;
select * from cre_signataire;
select * from cre_garant;
select * from cre_avenant;
select * from cre_impayes;
select * from cre_vendeur_pro;

/* Exercice */

update cre_signataire
set sig_nom = 'BOUCHEZ'
where upper(sig_nom) ='MARIE' and upper(sig_prenom) = 'VERONIQUE';

select * from cre_signataire;
delete from cre_impayes
where to_char(imp_date, 'yyyy') < '2016';

insert into cre_signataire(sig_nom, sig_prenom)
values ('Marie','Josiane');
insert into cre_garant(con_num)
values ('Marie','Josiane', '01800020350');

drop table cre_vendre;
create table cre_vendre
(
    ven_date date,
    ven_prix int,
    ven_com varchar2(32),
    vep_siret varchar2(16),
    veh_num_serie char(20),
    constraint pk_cre_vendre primary key(veh_num_serie, vep_siret, ven_date)
);

ALTER TABLE CRE_vendre ADD (
     CONSTRAINT FK_CRE_vendre_veh_num_serie
          FOREIGN KEY (veh_num_serie)
               REFERENCES CRE_VEHICULE (VEH_NUM_SERIE));


/*1. Afficher les numéros de contrats, les dates de signatures, les montants des prêts avec le nom et prénom des signataires classés
par nom croissant et date de signature décroissant 1 point*/

select con_num, con_date_signature, con_montant_pret, sig_nom, sig_prenom from cre_contrat
join cre_signataire using (sig_id)
order by sig_nom asc, con_date_signature desc;

/*22. Afficher les numéros de tous les contrats, les montants des prêts avec le nom et prénom des signataires et des garants quand
il y en a. Ne pas oublier que les garants sont aussi des signataires. */


create or replace view cre_signataire_avenant (con_num, ave_nom, ave_prenom) as
select con_num, sig_nom, sig_prenom from cre_signataire
join cre_garant using (sig_id);

select con_num, sig_nom, sig_prenom, ave_nom, ave_prenom, con_montant_pret from cre_contrat
join cre_signataire using(sig_id)
join cre_signataire_avenant using(con_num);

select con_num,con_montant_pret,sig1.sig_nom,sig1.sig_prenom,
sig2.sig_nom as nom_caution,sig2.sig_prenom as prenom_caution
from cre_contrat con
join cre_signataire sig1 on sig1.sig_id =  con.sig_id
left join cre_garant gar using(con_num)
left join cre_signataire sig2 on sig2.sig_id = gar.sig_id;

/*3. Afficher le montant des échéances pour les contrats (on ne tient pas compte des avenants). 2 points
La formule pour le calcul des mensualités est la suivante :*/

select * from cre_contrat;
select ( (con_montant_pret * con_taux_annuel/12/100)/(1-(power(1+ con_taux_annuel/12/100, -con_duree_init)))) as mensualité from cre_contrat;  

/*4. Afficher la date de première échéance, la durée initiale (elle est en mois), la date de dernière échéance (à calculer) des
contrats. Conseil : 1 mois fait environ 30,5 jours. Option(bonus 0,5) : Comme on connaît le jour des échéances
(con_jour_echeance), on peut rectifier la petite erreur occasionnée par ce calcul approché. */
select con_dat_pre_echeance, con_duree_init, (con_dat_pre_echeance + con_duree_init*30.5) as con_duree_fin_echeance from cre_contrat;

/*5. Afficher le nom et le prénom des signataires, leur nombre de contrats et la somme totale empruntée par chacun d'entre eux */
select sig_nom, sig_prenom, count(*) as nb_contrat, sum(con_montant_pret) || ' euros' as montant_total_pret from cre_contrat
join cre_signataire using(sig_id)
group by sig_nom, sig_prenom;

/*6. Même question mais en n'affichant que les signataires qui ont emprunté au moins 10000€. */
select sig_nom, sig_prenom, count(*) as nb_contrat, sum(con_montant_pret)  || ' euros' as montant_total_pret from cre_contrat
join cre_signataire using(sig_id)
having  sum(con_montant_pret) > = 10000
group by sig_nom, sig_prenom;

/* 7. Afficher la marque, le type, l immatriculation, la date de mise en circulation et l age en année, arrondie à un chiffre après la
virgule pour le où les véhicules dont l’âge est le plus grand. */

select veh_marque, veh_type, veh_immatriculation, veh_date_mec,(round((sysdate - veh_date_mec)/365.25, 1)) as age from cre_vehicule
where (round((sysdate - veh_date_mec)/365.25, 1)) in
(
    select max(round((sysdate - veh_date_mec)/365.25, 1)) from cre_vehicule
)
;
/*8. Afficher la moyenne des taux des contrats par année (de la date de signature). */

select to_char(con_date_signature,'yyyy') as annee, avg(con_taux_annuel) as moyenne_taux from cre_contrat
group by to_char(con_date_signature,'yyyy');

/* 9. Afficher le prénom et le nom des signataires (dans une même colonne), la somme totale empruntée par chacun d'entre eux
ainsi que la somme totale empruntée pour l'ensemble. Donner une version avec le total à droite de chaque ligne et une version
avec le total sur la ligne du bas. */


select sig_prenom || ' ' || sig_nom as signataires, sum(con_montant_pret) as somme_empruntee, (select sum(con_montant_pret) from cre_contrat) as total_pret from cre_signataire
join cre_contrat using(sig_id)
join cre_totale_pret using(con_montant_pret)
group by sig_prenom || ' ' || sig_nom, total_pret
order by 1 desc;

select sig_prenom || ' ' || sig_nom, sum(con_montant_pret) as nb from cre_contrat 
join cre_signataire using (sig_id)
group by sig_prenom || ' ' || sig_nom
union
select ' TOTAL',(select sum(con_montant_pret) from cre_contrat) as nb from cre_contrat
order by 1 desc;

/* 10. Afficher les numéros de contrats, les noms des garants avec leur nombre d'avenants pour le ou les contrats possédant le plus
d'avenants. Il est conseillé de faire une vue contenant les numéros de contrat et le nombre d’avenants par contrat. */

create or replace view cre_contrat_avenant (con_num, nb_avenant) as
select con_num, count(ave_num) from cre_contrat
join cre_avenant using(con_num)
group by con_num;

select con_num, sig_prenom, sig_nom, nb_avenant from cre_signataire
join cre_contrat using(sig_id)
join cre_contrat_avenant using(con_num);

create or replace view vq10 as
select con_num, count(*) as nb
from cre_avenant
group by con_num ;

select con_num,sig_prenom, sig_nom,  count(*) as nb  
from cre_garant gar
join cre_signataire sig on sig.sig_id = gar.sig_id
where (con_num) =
(
  select con_num from vq10 where nb =
    (select max(nb) from vq10)
)
group by con_num,sig_prenom, sig_nom; 