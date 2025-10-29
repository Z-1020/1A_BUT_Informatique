-- -----------------------------------------------------------------------------
--             Génération d'une base de données pour
--                      Oracle Version 10g
--                     (27/12/2013 18:23:53)
-- -----------------------------------------------------------------------------
--      Nom de la base : MLR1
--      Projet : crab
--      Auteur : IUT DE CAEN
--      Date de dernière modification : 27/12/2013 18:23:44
-- -----------------------------------------------------------------------------

DROP TABLE CRA_CLIENT CASCADE CONSTRAINTS;
DROP TABLE CRA_CONTROLE CASCADE CONSTRAINTS;
DROP TABLE CRA_PREPAYE CASCADE CONSTRAINTS;
DROP TABLE CRA_STATION CASCADE CONSTRAINTS;
DROP TABLE CRA_MODELE_BATTERIE CASCADE CONSTRAINTS;
DROP TABLE CRA_CONTRAT CASCADE CONSTRAINTS;
DROP TABLE CRA_TYPE_CHARGE CASCADE CONSTRAINTS;
DROP TABLE CRA_BORNE_RECHARGE CASCADE CONSTRAINTS;
DROP TABLE CRA_CHARGEMENT CASCADE CONSTRAINTS;
DROP TABLE CRA_ABONNEMENT CASCADE CONSTRAINTS;
DROP TABLE CRA_SUPPORTER CASCADE CONSTRAINTS;
DROP TABLE CRA_TECHNICIEN CASCADE CONSTRAINTS;

CREATE TABLE CRA_TECHNICIEN
(
    TEC_MATRICULE NUMBER(3),
    TEC_NOM VARCHAR2(32),
    TEC_PRENOM VARCHAR2(32),
    CONSTRAINT PK_CRA_TECHNICIEN PRIMARY KEY (TEC_MATRICULE)  
);

CREATE TABLE CRA_CLIENT
(
    PER_ID NUMBER(3)  NOT NULL,
    PER_NOM VARCHAR2(32)  NULL,
    PER_PRENOM VARCHAR2(32)  NULL,
    PER_TELEPHONE VARCHAR2(10)  NULL,
    PER_COURRIEL VARCHAR2(32)  NULL,
    PER_ADRESSE VARCHAR2(32)  NULL,
    PER_VILLE VARCHAR2(32)  NULL,
    CONSTRAINT PK_CRA_CLIENT PRIMARY KEY (PER_ID)  
);

CREATE TABLE CRA_CONTROLE
(
    CON_ID NUMBER(2) ,
    CON_TYPE NUMBER(1) ,
    CON_LIBELLE VARCHAR2(50) ,
    CONSTRAINT PK_CRA_CONTROLE PRIMARY KEY (CON_ID, CON_TYPE)  
);

CREATE TABLE CRA_PREPAYE
(
    CON_NUM NUMBER(3)  NOT NULL,
    FOR_SOLDE_KWH NUMBER(6,1)  NULL,
    CONSTRAINT PK_CRA_PREPAYE PRIMARY KEY (CON_NUM)  
);

CREATE TABLE CRA_STATION
(
    STA_ID NUMBER(2)  NOT NULL,
    STA_NOM VARCHAR2(64)  NULL,
    STA_ADRESSE VARCHAR2(32)  NULL,
    STA_VILLE VARCHAR2(32)  NULL,
    CONSTRAINT PK_CRA_STATION PRIMARY KEY (STA_ID)  
);

CREATE TABLE CRA_MODELE_BATTERIE
(
    MOD_REF VARCHAR2(32)  NOT NULL,
    MOD_CAPACITE NUMBER(6,2)  NULL,
    MOD_FABRICANT VARCHAR2(32)  NULL,
    CONSTRAINT PK_CRA_MODELE_BATTERIE PRIMARY KEY (MOD_REF)  
);

CREATE TABLE CRA_CONTRAT
(
    CON_NUM NUMBER(3)  NOT NULL,
    MOD_REF VARCHAR2(32)  NOT NULL,
    PER_ID NUMBER(3)  NOT NULL,
    CON_DATE_DEBUT DATE  NULL,
    CON_IMMATRICULATION VARCHAR2(12)  NULL,
    CONSTRAINT PK_CRA_CONTRAT PRIMARY KEY (CON_NUM)  
);

CREATE  INDEX I_FK_CRA_CONTRAT_CRA_MODELE_BA
     ON CRA_CONTRAT (MOD_REF ASC);

CREATE  INDEX I_FK_CRA_CONTRAT_CRA_CLIENT
     ON CRA_CONTRAT (PER_ID ASC);

CREATE TABLE CRA_TYPE_CHARGE
(
    TYC_ID NUMBER(1)  NOT NULL,
    TYC_LIBELLE VARCHAR2(32)  NULL,
    TYC_PUISSANCE NUMBER(4)  NULL,
    CONSTRAINT PK_CRA_TYPE_CHARGE PRIMARY KEY (TYC_ID)  
);

CREATE TABLE CRA_BORNE_RECHARGE
(
    STA_ID NUMBER(2)  NOT NULL,
    BOR_CODE NUMBER(2)  NOT NULL,
    TYC_ID NUMBER(1)  NOT NULL,
    BOR_DATE_MES DATE  NULL,
    CONSTRAINT PK_CRA_BORNE_RECHARGE PRIMARY KEY (STA_ID, BOR_CODE)  
);

CREATE  INDEX I_FK_CRA_BORNE_RECHARGE_CRA_TY
     ON CRA_BORNE_RECHARGE (TYC_ID ASC);

CREATE  INDEX I_FK_CRA_BORNE_RECHARGE_CRA_ST
     ON CRA_BORNE_RECHARGE (STA_ID ASC);

CREATE TABLE CRA_CHARGEMENT
(
    CON_NUM NUMBER(3)  NOT NULL,
    CHA_NUM_OPER NUMBER(4)  NOT NULL,
    CON_ID NUMBER(2)  NULL,
    CON_TYPE NUMBER(1) ,
    STA_ID NUMBER(2)  NOT NULL,
    BOR_CODE NUMBER(2)  NOT NULL,
    CHA_DATEH_DEBUT DATE  NULL,
    CHA_DATEH_FIN DATE  NULL,
    CHA_NBKWH NUMBER(6,2)  NULL,
    CONSTRAINT PK_CRA_CHARGEMENT PRIMARY KEY (CON_NUM, CHA_NUM_OPER)  
);

CREATE  INDEX I_FK_CRA_CHARGEMENT_CRA_CONTRO
     ON CRA_CHARGEMENT (CON_ID ASC);

CREATE  INDEX I_FK_CRA_CHARGEMENT_CRA_BORNE_
     ON CRA_CHARGEMENT (STA_ID ASC, BOR_CODE ASC);

CREATE  INDEX I_FK_CRA_CHARGEMENT_CRA_CONTRA
     ON CRA_CHARGEMENT (CON_NUM ASC);

CREATE TABLE CRA_ABONNEMENT
(
    CON_NUM NUMBER(3)  NOT NULL,
    ABO_DATE_DEBUT DATE  NULL,
    ABO_DATE_FIN DATE  NULL,
    CONSTRAINT PK_CRA_ABONNEMENT PRIMARY KEY (CON_NUM)  
);

CREATE TABLE CRA_SUPPORTER
(
    MOD_REF VARCHAR2(32)  NOT NULL,
    TYC_ID NUMBER(1)  NOT NULL,
    CONSTRAINT PK_CRA_SUPPORTER PRIMARY KEY (MOD_REF, TYC_ID)  
);

CREATE  INDEX I_FK_CRA_SUPPORTER_CRA_MODELE_
     ON CRA_SUPPORTER (MOD_REF ASC);

CREATE  INDEX I_FK_CRA_SUPPORTER_CRA_TYPE_CH
     ON CRA_SUPPORTER (TYC_ID ASC);


ALTER TABLE CRA_PREPAYE ADD (
     CONSTRAINT FK_CRA_PREPAYE_CRA_CONTRAT
          FOREIGN KEY (CON_NUM)
               REFERENCES CRA_CONTRAT (CON_NUM));

ALTER TABLE CRA_CONTRAT ADD (
     CONSTRAINT FK_CRA_CONTRAT_CRA_MODELE_BATT
          FOREIGN KEY (MOD_REF)
               REFERENCES CRA_MODELE_BATTERIE (MOD_REF));

ALTER TABLE CRA_CONTRAT ADD (
     CONSTRAINT FK_CRA_CONTRAT_CRA_CLIENT
          FOREIGN KEY (PER_ID)
               REFERENCES CRA_CLIENT (PER_ID));

ALTER TABLE CRA_BORNE_RECHARGE ADD (
     CONSTRAINT FK_CRA_BORNE_RECHARGE_CRA_TYPE
          FOREIGN KEY (TYC_ID)
               REFERENCES CRA_TYPE_CHARGE (TYC_ID));

ALTER TABLE CRA_BORNE_RECHARGE ADD (
     CONSTRAINT FK_CRA_BORNE_RECHARGE_CRA_STAT
          FOREIGN KEY (STA_ID)
               REFERENCES CRA_STATION (STA_ID));

ALTER TABLE CRA_CHARGEMENT ADD (
     CONSTRAINT FK_CRA_CHARGEMENT_CRA_CONTROLE
          FOREIGN KEY (CON_ID,CON_TYPE)
               REFERENCES CRA_CONTROLE (CON_ID,CON_TYPE));

ALTER TABLE CRA_CHARGEMENT ADD (
     CONSTRAINT FK_CRA_CHARGEMENT_CRA_BORNE_RE
          FOREIGN KEY (STA_ID, BOR_CODE)
               REFERENCES CRA_BORNE_RECHARGE (STA_ID, BOR_CODE));

ALTER TABLE CRA_CHARGEMENT ADD (
     CONSTRAINT FK_CRA_CHARGEMENT_CRA_CONTRAT
          FOREIGN KEY (CON_NUM)
               REFERENCES CRA_CONTRAT (CON_NUM));

ALTER TABLE CRA_ABONNEMENT ADD (
     CONSTRAINT FK_CRA_ABONNEMENT_CRA_CONTRAT
          FOREIGN KEY (CON_NUM)
               REFERENCES CRA_CONTRAT (CON_NUM));

ALTER TABLE CRA_SUPPORTER ADD (
     CONSTRAINT FK_CRA_SUPPORTER_CRA_MODELE_BA
          FOREIGN KEY (MOD_REF)
               REFERENCES CRA_MODELE_BATTERIE (MOD_REF));

ALTER TABLE CRA_SUPPORTER ADD (
     CONSTRAINT FK_CRA_SUPPORTER_CRA_TYPE_CHAR
          FOREIGN KEY (TYC_ID)
               REFERENCES CRA_TYPE_CHARGE (TYC_ID));

-- -----------------------------------------------------------------------------
--                FIN DE GENERATION
-- -----------------------------------------------------------------------------

insert into cra_technicien values (150 , 'ORAC' , 'Anne'   );
insert into cra_technicien values (154 , 'TOT'  , 'Armand' );
insert into cra_technicien values (156 , 'WAY'  , 'Erica' );

insert into cra_CLIENT values (25,'RAHL'    ,'Darken'  ,'0231556677' , 'd.rhal@citron.fr'            , '3 citée de la peur'             , 'BOURGUEBUS');
insert into cra_CLIENT values (26,'HOUSSEL' ,'Kader'   ,'0232236040' , 'kaderhoussel@libre.fr'       , 'rue des 3 maisons'              , 'CAGNY');
insert into cra_CLIENT values (39,'RAHL'    ,'Sylvian' ,'0231596675' , 's.rhal@citron.fr'            , '104 boulevard McEnroe'          , 'PARIS XII');
insert into cra_CLIENT values (44,'SUPER'   ,'Didier'  ,'0666040910' , 'super@libre.fr'              , '6 rue des bois'                 , 'CAGNY');
insert into cra_CLIENT values (52,'SOREL'   ,'Julien'  ,''           , 'juju.soralinous@hmail.fr'    , 'impasse des Cygnes'             , 'IFS');
insert into cra_CLIENT values (55,'TROJ'    ,'Fabienne','0231123456' , 'fabienne.troj@laprose.net'   , '8 citée de la peur'             , 'BOURGUEBUS');
insert into cra_CLIENT values (59,'LECHAT'  ,'Cécile'  ,'0666001122' , 'cecile.lechat@rockmail.fr'   , '5 allée du métal'               , 'CAEN');
insert into cra_CLIENT values (60,'POULEQ'  ,'Léa'     ,'0231889900' , 'lea.pouleq@rockmail.fr'      , '19 rue Gaspard Proust'          , 'IFS');
insert into cra_CLIENT values (62,'SUTURB'  ,'Philippe','0601020304' , 'philippe.suturb@laprose.net' , '25 allée des sports'            , 'COLOMBELLES');
insert into cra_CLIENT values (63,'DROUBERT','Emeline' ,'0277445656' , 'mimi84@rockmail.fr'          , '3 rue des diables'              , 'CAEN');
insert into cra_CLIENT values (69,'ROUGON'  ,'Eugène'  ,'0799886611' , ''                            , 'place de l''horloge'            , 'ARGENCES');
insert into cra_CLIENT values (70,'JACINTO' ,'Manuela' ,'0232236048' , 'manuela.jacinto@citron.fr'   , '300 Boulevard Pierre Desproges' ,'IFS');
insert into cra_CLIENT values (72,'ETJAUNE' ,'Giles'   ,'0232230909' , 'giles_etjaune@citron.fr'     , '8 rond point bleu'              ,'IFS');
insert into cra_CLIENT values (75,'TIVISTE' ,'Jacques' ,'0231010101' , 'joracle@libre.fr'            , '2236 avenue Gilbert Tayou'      ,'IFS');
insert into cra_CLIENT values (78,'VICAL'   ,'Nasser'  ,'0231010999' , 'nasservical@libre.fr'        , '2129 impasse muraille'          ,'IFS');

insert into cra_modele_batterie values ('FB740',200,'FULMEN');
insert into cra_modele_batterie values ('FB720',150,'FULMEN');
insert into cra_modele_batterie values ('FB600',100,'FULMEN');
insert into cra_modele_batterie values ('BL800',220,'BOLK');
insert into cra_modele_batterie values ('BL700',160,'BOLK');
insert into cra_modele_batterie values ('BL400',80,'BOLK');
insert into cra_modele_batterie values ('APH10',85,'ALPHALINE');
insert into cra_modele_batterie values ('APH20',110,'ALPHALINE');
insert into cra_modele_batterie values ('APH30',130,'ALPHALINE');
insert into cra_modele_batterie values ('SQL02',880,'TOPBAT');
insert into cra_modele_batterie values ('SQL09',890,'CANNET');
insert into cra_modele_batterie values ('SQL03',870,'CAMPUFORCE');

insert into cra_contrat values (1,'FB740',25,to_date('02/06/2015 10:30','dd/mm/yyyy hh24:mi'),'BB-123-BB');
insert into cra_contrat values (2,'FB720',25,to_date('01/02/2016 15:00','dd/mm/yyyy hh24:mi'),'CC-654-CD');
insert into cra_contrat values (5,'FB600',26,to_date('10/05/2015 07:50','dd/mm/yyyy hh24:mi'),'CC-611-KE');
insert into cra_contrat values (6,'BL400',39,to_date('01/04/2017 15:00','dd/mm/yyyy hh24:mi'),'GG-508-BK');
insert into cra_contrat values (10,'APH20',44,to_date('01/02/2017 14:20','dd/mm/yyyy hh24:mi'),'KK-111-JJ');
insert into cra_contrat values (12,'APH20',44,to_date('20/10/2016 17:30','dd/mm/yyyy hh24:mi'),'LM-208-ML');
insert into cra_contrat values (14,'APH20',52,to_date('01/12/2016 14:00','dd/mm/yyyy hh24:mi'),'BN-861-NB');
insert into cra_contrat values (16,'BL700',55,to_date('15/05/2017 18:10','dd/mm/yyyy hh24:mi'),'ML-850-LM');
insert into cra_contrat values (21,'FB720',60,to_date('10/08/2016 11:00','dd/mm/yyyy hh24:mi'),'KJ-454-JK');
insert into cra_contrat values (25,'APH30',63,to_date('11/11/2016 11:00','dd/mm/yyyy hh24:mi'),'AB-542-YM');
insert into cra_contrat values (29,'FB720',69,to_date('01/02/2017 16:00','dd/mm/yyyy hh24:mi'),'FB-420-HG');
insert into cra_contrat values (31,'FB720',70,to_date('04/01/2016 09:30','dd/mm/yyyy hh24:mi'),'BY-227-JH');
insert into cra_contrat values (51,'FB720',70,to_date('04/01/2018 15:00','dd/mm/yyyy hh24:mi'),'BY-227-JH');
insert into cra_contrat values (58,'SQL02',72,to_date('05/09/2018 15:00','dd/mm/yyyy hh24:mi'),'BY-227-JH');
insert into cra_contrat values (60,'APH30',59,to_date('06/12/2021 13:00','dd/mm/yyyy hh24:mi'),'NN-007-KK');

insert into cra_abonnement values (1  , '02/06/2015' , '01/06/2020');
insert into cra_abonnement values (6  , '01/04/2016' , '31/03/2023');
insert into cra_abonnement values (10 , '01/02/2016' , '31/01/2024');
insert into cra_abonnement values (21 , '10/08/2015' , '10/08/2024');
insert into cra_abonnement values (29 , '01/02/2013' , '31/01/2024');
insert into cra_abonnement values (31 , '04/01/2012' , '03/01/2024');
insert into cra_abonnement values (58 , '05/09/2018' , '05/09/2024');
insert into cra_abonnement values (60 , '06/12/2021' , '06/12/2023');

insert into cra_prepaye values (2,400);
insert into cra_prepaye values (5,500);
insert into cra_prepaye values (12,100);
insert into cra_prepaye values (14,50);
insert into cra_prepaye values (16,0);
insert into cra_prepaye values (25,0);
insert into cra_prepaye values (51,80);

insert into cra_station values (5 , 'Relais d''IFS'        , '389 rue de Caen'         , 'IFS');
insert into cra_station values (6 , 'Relais de la prairie' , '23 route d''Ifs'         , 'CAEN');
insert into cra_station values (7 , 'Carrefour'            , 'Avenue des commerces'    , 'MONDEVILLE');
insert into cra_station values (8 , 'Sofi-Ifs'             , '190 rue de Rocquancourt' , 'IFS');
insert into cra_station values (9 , 'ESSO'                 , 'Z.A. du Martray'         , 'GIBERVILLE');

insert into cra_type_charge values (1 , 'NORMALE 1'     , 3.7);
insert into cra_type_charge values (2 , 'NORMALE 2'     , 7.4);
insert into cra_type_charge values (3 , 'SEMI RAPIDE'   , 22);
insert into cra_type_charge values (4 , 'RAPIDE'        , 50);
insert into cra_type_charge values (5 , 'GIGA RAPIDE'   , 350);

insert into cra_supporter values ('FB740',1);
insert into cra_supporter values ('FB740',2);
insert into cra_supporter values ('FB740',3);
insert into cra_supporter values ('FB720',1);
insert into cra_supporter values ('FB720',2);
insert into cra_supporter values ('FB600',1);
insert into cra_supporter values ('BL800',1);
insert into cra_supporter values ('BL800',2);
insert into cra_supporter values ('BL700',1);
insert into cra_supporter values ('BL700',2);
insert into cra_supporter values ('BL400',1);
insert into cra_supporter values ('APH10',1);
insert into cra_supporter values ('APH20',1);
insert into cra_supporter values ('APH30',1);
insert into cra_supporter values ('APH30',4);
insert into cra_supporter values ('SQL02',4);
insert into cra_supporter values ('SQL02',5);
insert into cra_supporter values ('SQL03',4);

insert into cra_borne_recharge values (5 , 1 , 1 , to_date( '01/02/2011','dd/mm/yyyy' ));
insert into cra_borne_recharge values (5 , 2 , 2 , to_date( '01/02/2011','dd/mm/yyyy' ));
insert into cra_borne_recharge values (5 , 3 , 3 , to_date( '01/02/2011','dd/mm/yyyy' ));
insert into cra_borne_recharge values (6 , 1 , 1 , to_date( '01/09/2011','dd/mm/yyyy' ));
insert into cra_borne_recharge values (6 , 2 , 2 , to_date( '01/09/2011','dd/mm/yyyy' ));
insert into cra_borne_recharge values (7 , 1 , 1 , to_date( '15/11/2011','dd/mm/yyyy' ));
insert into cra_borne_recharge values (7 , 2 , 2 , to_date( '15/09/2011','dd/mm/yyyy' ));
insert into cra_borne_recharge values (7 , 3 , 3 , to_date( '04/02/2013','dd/mm/yyyy' ));
insert into cra_borne_recharge values (8 , 1 , 1 , to_date( '04/05/2018','dd/mm/yyyy' ));
insert into cra_borne_recharge values (8 , 2 , 2 , to_date( '04/05/2018','dd/mm/yyyy' ));
insert into cra_borne_recharge values (8 , 3 , 2 , to_date( '01/06/2018','dd/mm/yyyy' ));

insert into cra_controle values (1  , 0 , 'aucun problème');
insert into cra_controle values (1  , 1 , 'batterie différente contrat');
insert into cra_controle values (2  , 1  ,'contrat expiré');
insert into cra_controle values (3  , 1 , 'solde KWH nul');
insert into cra_controle values (1  , 2 , 'batterie incompatible avec la borne');
insert into cra_controle values (2  , 2 , 'problème technique');
insert into cra_controle values (3  , 2 , 'températeure excessive');
insert into cra_controle values (3  , 3 , 'mode dégradé');

insert into cra_chargement values (1  , 1 , 1  ,0 , 5 , 1 , to_date('03/06/2022 10:30:15','dd/mm/yyyy HH24:mi:ss') , to_date('03/06/2017 10:50:45','dd/mm/yyyy HH24:mi:ss') , 15 );
insert into cra_chargement values (1  , 2 , 1  ,0 , 5 , 2 , to_date('16/06/2022 14:30:35','dd/mm/yyyy HH24:mi:ss') , to_date('16/06/2017 15:10:10','dd/mm/yyyy HH24:mi:ss') , 50 );
insert into cra_chargement values (1  , 3 , 1  ,1 , 6 , 1 , to_date('03/07/2022 10:00:15','dd/mm/yyyy HH24:mi:ss') , null                                                   , 0  );
insert into cra_chargement values (2  , 1 , 1  ,0 , 7 , 1 , to_date('01/03/2022 16:10:02','dd/mm/yyyy HH24:mi:ss') , to_date('01/03/2017 16:42:12','dd/mm/yyyy HH24:mi:ss') , 90 );
insert into cra_chargement values (2  , 2 , 1  ,0 , 7 , 1 , to_date('09/03/2022 11:16:24','dd/mm/yyyy HH24:mi:ss') , to_date('09/03/2017 14:00:02','dd/mm/yyyy HH24:mi:ss') , 95 );
insert into cra_chargement values (2  , 5 , 2  ,1 , 7 , 3 , to_date('10/06/2022 07:00:56','dd/mm/yyyy HH24:mi:ss') , null                                                   , 0  );
insert into cra_chargement values (2  , 6 , 1  ,0 , 8 , 1 , to_date('11/06/2022 13:00:05','dd/mm/yyyy HH24:mi:ss') , to_date('11/06/2017 14:10:34','dd/mm/yyyy HH24:mi:ss') , 105);
insert into cra_chargement values (2  , 7 , 1  ,0 , 8 , 1 , to_date('20/06/2022 18:05:45','dd/mm/yyyy HH24:mi:ss') , to_date('20/06/2017 18:30:10','dd/mm/yyyy HH24:mi:ss') , 35 );
insert into cra_chargement values (5  , 4 , 1  ,0 , 6 , 2 , to_date('03/06/2022 08:40:15','dd/mm/yyyy HH24:mi:ss') , to_date('03/06/2017 09:40:12','dd/mm/yyyy HH24:mi:ss') , 95 );
insert into cra_chargement values (5  , 5 , 1  ,0 , 6 , 2 , to_date('05/07/2022 10:30:15','dd/mm/yyyy HH24:mi:ss') , to_date('05/07/2017 10:45:16','dd/mm/yyyy HH24:mi:ss') , 22 );
insert into cra_chargement values (5  , 6 , 1  ,0 , 6 , 2 , to_date('08/08/2022 10:30:15','dd/mm/yyyy HH24:mi:ss') , to_date('08/08/2017 11:10:20','dd/mm/yyyy HH24:mi:ss') , 69 );
insert into cra_chargement values (5  , 9 , 1  ,0 , 8 , 3 , to_date('10/10/2022 15:21:31','dd/mm/yyyy HH24:mi:ss') , to_date('29/10/2018 15:58:10','dd/mm/yyyy HH24:mi:ss') , 60 );
insert into cra_chargement values (6  , 1 , 1  ,0 , 7 , 2 , to_date('02/04/2023 15:30:08','dd/mm/yyyy HH24:mi:ss') , to_date('02/04/2018 16:10:15','dd/mm/yyyy HH24:mi:ss') , 71 );
insert into cra_chargement values (6  , 2 , 1  ,0 , 7 , 2 , to_date('16/04/2023 15:50:05','dd/mm/yyyy HH24:mi:ss') , to_date('16/04/2018 16:59:08','dd/mm/yyyy HH24:mi:ss') , 9  );
insert into cra_chargement values (6  , 4 , 1  ,0 , 6 , 2 , to_date('20/06/2023 08:10:16','dd/mm/yyyy HH24:mi:ss') , to_date('20/12/2018 09:30:35','dd/mm/yyyy HH24:mi:ss') , 110);
insert into cra_chargement values (6  , 5 , 1  ,0 , 6 , 1 , to_date('13/11/2023 14:21:39','dd/mm/yyyy HH24:mi:ss') , to_date('01/01/2018 14:59:10','dd/mm/yyyy HH24:mi:ss') , 65 );
insert into cra_chargement values (6  , 6 , 2  ,2 , 6 , 1 , to_date('13/11/2023 14:21:39','dd/mm/yyyy HH24:mi:ss') ,null                                                    , 0 );
insert into cra_chargement values (10 , 1 , 1  ,0 , 5 , 3 , to_date('03/05/2023 12:30:18','dd/mm/yyyy HH24:mi:ss') , to_date('03/05/2018 13:40:16','dd/mm/yyyy HH24:mi:ss') , 110);
insert into cra_chargement values (10 , 4 , 1  ,0 , 5 , 3 , to_date('05/06/2023 16:30:05','dd/mm/yyyy HH24:mi:ss') , to_date('05/06/2018 16:59:15','dd/mm/yyyy HH24:mi:ss') , 61 );
insert into cra_chargement values (10 , 9 , 3  ,1 , 5 , 2 , to_date('03/06/2023 10:30:15','dd/mm/yyyy HH24:mi:ss') , null                                                   , 0  );
insert into cra_chargement values (10 , 6 , 3  ,3 , 8 , 1 , to_date('19/07/2023 16:11:15','dd/mm/yyyy HH24:mi:ss') , to_date('19/07/2023 23:50:19','dd/mm/yyyy HH24:mi:ss') , 16 );
insert into cra_chargement values (12 , 4 , 1  ,0 , 8 , 3 , to_date('24/10/2023 11:10:12','dd/mm/yyyy HH24:mi:ss') , to_date('24/10/2018 12:04:10','dd/mm/yyyy HH24:mi:ss') , 108);
insert into cra_chargement values (12 , 5 , 1  ,0 , 8 , 3 , to_date('29/10/2023 15:21:31','dd/mm/yyyy HH24:mi:ss') , to_date('29/10/2018 15:58:10','dd/mm/yyyy HH24:mi:ss') , 64 );
insert into cra_chargement values (31 , 4 , 1  ,0 , 6 , 2 , to_date('20/12/2023 08:10:16','dd/mm/yyyy HH24:mi:ss') , to_date('20/12/2018 09:30:35','dd/mm/yyyy HH24:mi:ss') , 120);
insert into cra_chargement values (31 , 5 , 1  ,0 , 6 , 1 , to_date('01/01/2023 14:21:39','dd/mm/yyyy HH24:mi:ss') , to_date('01/01/2018 14:59:10','dd/mm/yyyy HH24:mi:ss') , 70 );
insert into cra_chargement values (31 , 6 , 3  ,2 , 8 , 1 , to_date('10/01/2023 16:11:15','dd/mm/yyyy HH24:mi:ss') , null                                                   , 0  );
insert into cra_chargement values (51 , 6 , 3  ,1 , 7 , 3 , to_date('30/01/2023 22:20:00','dd/mm/yyyy HH24:mi:ss') , null                                                   , 0  );
insert into cra_chargement values (51 , 8 , 1  ,0 , 7 , 3 , to_date('30/05/2023 05:50:10','dd/mm/yyyy HH24:mi:ss') , to_date('30/05/2023 06:13:16','dd/mm/yyyy HH24:mi:ss') , 150);


commit;
/*
SELECT CON_NUM, ABO_DATE_DEBUT, ABO_DATE_FIN FROM CRA_ABONNEMENT ;
SELECT STA_ID,  BOR_CODE,  TYC_ID,  BOR_DATE_MES FROM CRA_BORNE_RECHARGE ;
SELECT CON_NUM,  CHA_NUM_OPER,  CON_ID, CON_TYPE, STA_ID,  BOR_CODE,  CHA_DATEH_DEBUT,  CHA_DATEH_FIN,  CHA_NBKWH FROM CRA_CHARGEMENT ;
SELECT CON_NUM,  MOD_REF,  PER_ID,  to_char(CON_DATE_DEBUT,'dd/mm/yyyy hh24:mi'),  CON_IMMATRICULATION FROM CRA_CONTRAT ;
SELECT CON_ID, CON_TYPE, CON_LIBELLE FROM CRA_CONTROLE ;
SELECT MOD_REF, MOD_CAPACITE, MOD_FABRICANT FROM CRA_MODELE_BATTERIE ;
SELECT PER_ID,  PER_NOM,  PER_PRENOM,  PER_TELEPHONE,  PER_COURRIEL,  PER_ADRESSE,  PER_VILLE FROM CRA_CLIENT ;
SELECT CON_NUM, FOR_SOLDE_KWH FROM CRA_PREPAYE ;
SELECT STA_ID, STA_NOM, STA_ADRESSE, STA_VILLE FROM CRA_STATION ;
SELECT MOD_REF, TYC_ID FROM CRA_SUPPORTER ;
SELECT TYC_ID, TYC_LIBELLE, TYC_PUISSANCE FROM CRA_TYPE_CHARGE ;
SELECT * FROM CRA_TECHNICIEN ;
*/

create table Bilan_revision 
(
    bil_id number(4),
    tec_matricule number(3),
    sta_id number(2) not null,
    bor_code number(2)not null,
    bil_commentaire varchar2(32) default 'ras',
    bil_date_rev date,
    constraint PK_bil primary key(bil_id)
);
/*En vous aidant de l’annexe 2, donner le code permettant d'insérer une nouvelle donnée dans "BILAN_REVISION". Attention,
n'insérer des valeurs que dans les colonnes obligatoires. La ligne devra respecter l'intégrité référentielle. Pour cette question
uniquement, on suppose que l'annexe 2 est complète.*/

insert into bilan_revision(bil_id,tec_matricule, sta_id, bor_code)
values(7691,55,4,7);

/*Donner le code permettant de repousser d'un an la date de début du contrat du client identifiée 39 (per_id).*/

update cra_contrat set con_date_debut=con_date_debut+365.25  where per_id=39;
select * from cra_contrat;

/*Donner le code permettant de supprimer les modèles de batteries "CANNET"*/

delete from cra_modele_batterie where mod_fabricant='CANNET';

/*Créer une vue cra_abonnement_contrat avec toutes les colonnes de ces deux tables*/
create or replace view cra_abonnement_contrat as
select * from cra_abonnement
join cra_contrat using(con_num);
select * from cra_abonnement_contrat;

/*Créer un synonyme nommé BORNE pour CRA_BORNE_RECHARGE*/

create or replace synonym borne for cra_borne_recharge;
select * from borne;

/*Afficher les clients dont le nom contient un 'e' quelle que soit la casse classées par ordre décroissant de prénom et croissant de
nom.*/

select per_nom from cra_client where lower(per_nom) like '%e%'
order by per_nom desc;

/*Afficher les contrats réalisés un mois d'avril.*/
select con_num from cra_contrat where to_char(con_date_debut, 'MM')='04';

/*Donner les numéros de contrat avec les prénom et nom des clients ayant des abonnements dépassés.*/
select con_num, per_nom, per_prenom from cra_contrat
join cra_client using(per_id)
join cra_abonnement using(con_num)
where abo_date_fin<sysdate;

/*Donner le(s) numéro(s) de contrat(s) prépayé(s) dont le solde en KWh est le plus élevé.*/

select con_num, for_solde_kwh from cra_prepaye where for_solde_kwh >= all 
(
    select for_solde_kwh from cra_prepaye 
);

/*Afficher les prénom et nom des 3 premiers clients par ordre alphabétique des noms.*/

select per_prenom, per_nom from 
(
    select per_nom, per_prenom from cra_client
    order by per_nom asc
)
where rownum<=3;

/*Afficher les nom et prénom des clients, leur numéro de contrat et en quatrième
colonne le mot " abonnement " ou " prépayé " puis soit la date de début pour les
abonnements, soit le solde pour les contrats prépayés. Bien respecter le format de
l'extrait de capture ci-dessous*/

select per_nom as nom, per_prenom  as prenom, con_num as contrat, 'abonnement' as type_contrat, to_char(abo_date_debut) as valeur from cra_client
join cra_contrat using(per_id)
join cra_abonnement using(con_num)
union
select per_nom as nom, per_prenom as prenom, con_num as contrat, 'prepaye' as type_contrat, to_char(for_solde_kwh) as valeur from cra_client
join cra_contrat using(per_id)
join cra_prepaye using(con_num)
order by nom asc;

/*Afficher les noms de toutes les stations avec le code des bornes quand elles en disposent.*/
select sta_nom from cra_station
right join cra_borne_recharge using(sta_id);

/*Afficher le nom des stations qui ont eu des chargements contrôlés autrement que "aucun problème". Proposer une solution avec
que des jointures et une autre avec que des sous-requêtes.*/

select distinct sta_nom from cra_station
join cra_chargement using(sta_id)
join cra_controle using(con_id, con_type)
where con_libelle <> 'aucun problème'
;
select distinct sta_nom from cra_station
join cra_borne_recharge using(sta_id)
join cra_chargement using(sta_id, bor_code)
join cra_controle using(con_id, con_type)
where con_libelle <> 'aucun problème';

select sta_nom from cra_station where sta_id in
(
    select sta_id from cra_chargement where (con_id, con_type) in
    (
        select con_id, con_type from cra_controle 
        where con_libelle <> 'aucun problème'
    )
);

/*Afficher le nom et prénom des clients qui ont effectué des chargements dans une station de leur commune.*/

select distinct per_nom, per_prenom from cra_client
join cra_contrat using(per_id)
join cra_chargement using(con_num)
join cra_station using(sta_id)
where sta_ville=per_ville
;
select per_nom, per_prenom from cra_client
join cra_contrat using(per_id)
join cra_chargement using(con_num)
join cra_borne_recharge using(sta_id, bor_code)
join cra_station using(sta_id)
where per_ville=sta_ville;

/*Afficher les contrats dont les batteries ne supportent pas le type de charge " rapide ". N’utiliser que des sous-requêtes*/

select * from cra_contrat where con_num in
(
    select con_num from cra_chargement where (sta_id, bor_code) in
    (
        select sta_id, bor_code from cra_borne_recharge where tyc_id not in
        (
            select tyc_id from cra_type_charge where tyc_libelle ='rapide' 
            or tyc_libelle = 'giga rapide'
        )
    )
);
 select * from cra_contrat
 where mod_ref not in
 (
    select mod_ref from cra_modele_batterie where mod_ref in
    (
        select mod_ref from cra_supporter where tyc_id in
        (
            select tyc_id from cra_type_charge
            where lower(tyc_libelle)='rapide' or lower(tyc_libelle)='giga rapide'
        )
    )
);
/*Afficher la clé primaire des bornes qui ne supportent pas le type de charge " rapide ". Utiliser une requête ensembliste*/

select sta_id, bor_code from cra_borne_recharge
intersect
select sta_id, bor_code from cra_borne_recharge
join cra_type_charge using(tyc_id)
where tyc_libelle <> 'rapide'
and tyc_libelle <> 'giga rapide';