declare
chaine varchar2(20) := 'salut mon campus ';
begin
dbms_output.put_line( chaine ) ;
dbms_output.put_line( 'nous sommes ' || chr(10) ||' le '|| sysdate ) ;
end;
/

accept num prompt 'veuillez taper un mot : '
set verify off
declare
val varchar2(20);
begin
val := '&num';
dbms_output.put_line( 'vous avez tapé : ' || val) ;
dbms_output.put_line( 'nous sommes le ' || sysdate || chr(10) ) ;
end;
/

drop table bidon;
create table bidon
(
num number(4) primary key,
type char(10),
valeur number(4,2)
);

begin
PLSQL_PROC_313;
end;
/

begin
delete from bidon;
PLSQL_PROC_314;
end;
/
drop table PLSQL1_TAB;
create table PLSQL1_TAB
(
    nom_exercice varchar2(15),
    date_jour date,
    multiplicande number(2),
    multiplicateur number(2),
    resultat number(3),
    constraint pk_resultat primary key (resultat)
);
select * from PLSQL1_TAB;

declare
PasDeMultiplicateur exception;
MauvaiseValeur exception;
begin
    PLSQL2_PROC_333(1);
end;
/

/*3.2.1*/
create or replace PROCEDURE PLSQL_PROC_321 AS 
v_nom_exercice PLSQL1_TAB.nom_exercice%type;

BEGIN
    for i in 1..10
    loop
        insert into PLSQL1_TAB (nom_exercice, date_jour, resultat) 
        values ('multiplication', sysdate, i);
    end loop;
  NULL;
END PLSQL_PROC_321;/

/*3.2.2*/
create or replace PROCEDURE PLSQL_PROC_332 (pmultiplicateur int) AS 
vNomExercice plsql1_tab.nom_exercice%type := 'PLSQL_PROC_332';
vErreur number(1) :=0;
cMessage1 constant varchar2(100) := 'la valeur saisie ne peut être nulle';
cMessage2 constant varchar2(100) := 'il faut saisir un nombre';
cMessage3 constant varchar2(100) := 'la valeur doit être comprise entre 0 et 10';
BEGIN
    if pMultiplicateur is null then
        vErreur :=1;
    else
        for i in 1 .. length(pMultiplicateur)
            loop
                if substr(pMultiplicateur,i,1) not between '0' and '9' then
                    dbms_output.put_line(pMultiplicateur || cMessage2);
                    vErreur := 1;
                end if;
            end loop;
        if vErreur = 0 then
            for i in 1..10
                loop
                    insert into PLSQL1_TAB (nom_exercice, multiplicande, date_jour, multiplicateur, resultat)
                    values('PLSQL_PROC_331', i,sysdate, pMultiplicateur, pMultiplicateur*i); 
                 end loop;
        end if;
            
    end if;
END PLSQL_PROC_332;/

/*3.2.3*/
create or replace PROCEDURE PLSQL_PROC_323 AS 
i int;
BEGIN
    i:=1;
    loop
        insert into PLSQL1_TAB (nom_exercice, date_jour, resultat)
        values ('PLSQL_PROC_222', sysdate, i);
        i:= i+1;
        exit when i>10;
    end loop;
  NULL;
END PLSQL_PROC_323;/

/*3.3.1*/
create or replace PROCEDURE PLSQL2_PROC_331 ( multi int) AS 
BEGIN
    for i in 1..10
    loop
        insert into PLSQL1_TAB (nom_exercice, multiplicande, date_jour, multiplicateur, resultat)
        values('PLSQL_PROC_331', i,sysdate, multi, multi*i); 
    end loop;
  NULL;
END PLSQL2_PROC_331;/

/*3.3.2*/
create or replace PROCEDURE PLSQL_PROC_332 (pmultiplicateur int) AS 
vNomExercice plsql1_tab.nom_exercice%type := 'PLSQL_PROC_332';
vErreur number(1) :=0;
cMessage1 constant varchar2(100) := 'la valeur saisie ne peut être nulle';
cMessage2 constant varchar2(100) := 'il faut saisir un nombre';
cMessage3 constant varchar2(100) := 'la valeur doit être comprise entre 0 et 10';
BEGIN
    if pMultiplicateur is null then
        vErreur :=1;
    else
        for i in 1 .. length(pMultiplicateur)
            loop
                if substr(pMultiplicateur,i,1) not between '0' and '9' then
                    dbms_output.put_line(pMultiplicateur || cMessage2);
                    vErreur := 1;
                end if;
            end loop;
        if vErreur = 0 then
            for i in 1..10
                loop
                    insert into PLSQL1_TAB (nom_exercice, multiplicande, date_jour, multiplicateur, resultat)
                    values('PLSQL_PROC_331', i,sysdate, pMultiplicateur, pMultiplicateur*i); 
                 end loop;
        end if;
            
    end if;
END PLSQL_PROC_332;
/
/*3.3.3*/

create or replace PROCEDURE PLSQL2_PROC_333 (pMultiplicateur number) AS 
vNomExercice plsql1_tab.nom_exercice%type := 'PLSQL_PROC_332';
vErreur number(1) :=0;
cMessage1 constant varchar2(100) := 'la valeur saisie ne peut être nulle';
cMessage2 constant varchar2(100) := 'il faut saisir un nombre';
cMessage3 constant varchar2(100) := 'la valeur doit être comprise entre 0 et 10';
PasDeMultiplicateur exception;
MauvaiseValeur exception;

/*3.4.1*/
BEGIN
    if pMultiplicateur is null then
        raise PasDeMultiplicateur;
    end if;
        for i in 1 .. length(pMultiplicateur)
            loop
                if substr(pMultiplicateur,i,1) not between '0' and '9' then
                    raise MauvaiseValeur;
                end if;
            end loop;
    exception
        when PasDeMultiplicateur then
            raise_application_error(-20002, cMessage1);
        when MauvaiseValeur then
            raise_application_error(-20003, cMessage3);
        when value_error then
            raise_application_error(-20001, cMessage2);
            
END PLSQL2_PROC_333;/

drop table sondage;
create table sondage
(
num number(3),
date_naissance date,
reponse1 char(20),
reponse2 varchar2(20),
val int
);
insert all
into sondage (num,date_naissance,reponse1,reponse2,val) values (26 , to_date('01/01/2000','dd/mm/yyyy') , 'oui' , 'un peu' , 6 )
into sondage (num,date_naissance,reponse1,reponse2,val) values (29 , to_date('01/05/1991','dd/mm/yyyy') , 'oui' , 'un peu' , 7 )
into sondage (num,date_naissance,reponse1,reponse2,val) values (38 , to_date('01/06/1980','dd/mm/yyyy') , 'non' , 'trop peu ou trop pas' , 3 )
into sondage (num,date_naissance,reponse1,reponse2,val) values (39 , to_date('01/06/1980','dd/mm/yyyy') , 'non' , 'un peu' , 3 )
into sondage (num,date_naissance,reponse1,reponse2,val) values (40 , to_date('01/06/1980','dd/mm/yyyy') , 'non' , 'beaucoup' , 7 )
into sondage (num,date_naissance,reponse1,reponse2,val) values (41 , to_date('01/03/2000','dd/mm/yyyy') , 'non' , 'pas trop' , 8 )
into sondage (num,date_naissance,reponse1,reponse2,val) values (42 , to_date('01/03/2000','dd/mm/yyyy') , 'non' , 'trop pas' , 7 )
into sondage (num,date_naissance,reponse1,reponse2,val) values (43 , to_date('01/06/1980','dd/mm/yyyy') , 'non' , 'pas du tout' , 7 )
into sondage (num,date_naissance,reponse1,reponse2,val) values (45 , to_date('01/06/1980','dd/mm/yyyy') , 'non' , 'trop pas du tout' , 5 )
into sondage (num,date_naissance,reponse1,reponse2,val) values (46 , to_date('01/03/2000','dd/mm/yyyy') , 'non' , 'trop pas du tout' , 8 )
into sondage (num,date_naissance,reponse1,reponse2,val) values (47 , to_date('01/03/2000','dd/mm/yyyy') , 'non' , 'trop pas du tout' , 7 )
SELECT * FROM dual;
commit;

select * from sondage;

/*3.4.2.A*/
create or replace PROCEDURE PLSQL_PROC_342 AS 
cursor c is select num, val from sondage where val =7;
valeur c%rowtype;
BEGIN
    open c;
    loop
       fetch c into valeur;
       exit when c%notfound;
       dbms_output.put_line(valeur.val ||' '|| valeur.num);
    end loop;
    close c;

END PLSQL_PROC_342;/

/*3.4.2.B*/
create or replace PROCEDURE PLSQL_PROC_342_2 AS 
cursor c is select * from sondage where date_naissance = to_date('01/03/2000', 'dd/mm/yyyy');
valeur c%rowtype;
BEGIN
    open c;
    loop
       fetch c into valeur;
       exit when c%notfound;
       dbms_output.put_line(valeur.reponse2 ||' '|| valeur.num);
    end loop;
    close c;
  NULL;
END PLSQL_PROC_342_2;/

/*3.4.2.C*/
create or replace PROCEDURE PLSQL_PROC_342_3 AS 
nbLigne int;
BEGIN
    nbLigne :=0;
    select count(*) into nbLigne from sondage;
    dbms_output.put_line(nbLigne);
  NULL;
END PLSQL_PROC_342_3;
/
/*3.4.2.D*/
create or replace PROCEDURE PLSQL_PROC_342_4 AS 
nbLigne int;
BEGIN
select count(*) into nbLigne from sondage;
dbms_output.put_line(nbLigne);
  NULL;
END PLSQL_PROC_342_4;
/
/*3.4.3*/
create or replace PROCEDURE PLSQL2_PROC_343 AS 
cursor c is select * from sondage where val=7;
psondage sondage%rowtype;
BEGIN
    open c;
    loop
        fetch c into psondage;
        exit when c%notfound;
        dbms_output.put_line('num = '|| ' '|| psondage.num || ' reponse1 = '|| psondage.reponse1);
    end loop;
    close c;
  NULL;
END PLSQL2_PROC_343;/

/*3.4.4*/
create or replace NONEDITIONABLE PROCEDURE PLSQL_PROC_344 (pDateNais varchar2)AS 
erreurVide exception;
erreurDatePasDansSondage exception;
nbLigne int;
BEGIN
    if pDateNais is null then
        raise erreurVide;
    end if;
    select count(*) into nbLigne from sondage where date_naissance = to_date(pDateNais, 'dd/mm/yyyy');
        if nbLigne =0 then
            raise erreurDatePasDansSondage;
        else
            dbms_output.put_line('la date est correct');
        end if;
  
    exception
        when erreurVide then
            raise_application_error(-20001, ' pDateNais est vide');
        when erreurDatePasDansSondage then
            raise_application_error(-20002, 'date pas dans le sondage');
        when others then
             if to_char(sqlcode) = '-1858' then
                raise_application_error(-20003,'ce n''est pas une date, c''est un texte');
            elsif to_char(sqlcode) = '-1840' then
                raise_application_error(-20004,'ce n''est pas une date, c''est un nombre');
            end if;
  
  
END PLSQL_PROC_344;

/*3.4.5 ne fonctionne pas*/
create or replace PROCEDURE P345 AS 
val_reponse2 sondage.reponse2%type;
val_num sondage.num%type;
cursor cl is select num, reponse2 from sondage where reponse2 like '%pas%';
BEGIN
    open cl;
    loop
        fetch cl into val_num, val_reponse2;
        exit when cl%NOTFOUND;
        dbms_output.put_line( val_num ,val_reponse2);
    end loop; 
    close cl;
END p345;
/
/*3.5 ne fonctionne pas*/
create or replace PROCEDURE P35 ( pNumLivraison in varchar2) AS 
nbLiv int;
BEGIN
    select count(*) into nbLiv from cdi_livraison where trim(li_numero) = pNumLivraison;
    if nbLiv =1 then
    dbms_output.put_line( 'M01: ' ||pNumLivraison);
    insert into cdi_liv_message (li_numero, lv_message, lv_date_mes, lv_login)
    values (pnumLivraison, 'M01: ', sysdate, user);
    dbms_lock.sleep(1);
    commit;
    dbms_output.put_line('fin');
    return 0;
   
   else
        dbms_output.put_line('M02: ' || pnumLivraison);
        insert into cdi_liv_message(li_numero, lv_message, lv_date_mes, lv_login)
        values (pnumLivraison, 'M02: ', sysdate, user);
        dbms_lock.sleep(1);
        commit;
        dbms_output.put_line('fin');
        return -1;
        end if;
END P35;
/
/*3.6 ne fonctionne pas*/
create or replace PROCEDURE P36 ( PNumLivraison in varchar2) AS 
v_clnumero cdi_commande.cl_numero%type;
v_manumero cdi_commande.cl_numero%type;
vnbcommande int;
res int;
BEGIN
    res := P35(pnumLivraison);
    if res =-1 then
    select count(*) into vnbcommande from cdi_commande
    where trim(co_numero) = trim (pcom_num);
    if vnbcommande = 1 then
        dbms_output.put_line('M04: ' || res);
        insert into cdi_liv_message(li_numero, lv_message, lv_date_mes, lv_login)
        values ('M04', sysdate, pcom_num,user);
        dbms_lock.sleep(1);
    commit;
    
    else 
        dbms_output.put_line('M03: ' || res);
        insert into cdi_liv_message(li_numero, lv_message, lv_date_mes, lv_login)
        values ('M03', sysdate, pcom_num, user);
        dbms_lock.sleep(1);
    
    end if;
    end if;
END P36;
/

/*3.7.A ne fonctionne pas)*/
create or replace PROCEDURE P37 AS 
TYPE tableau_numerique IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;
tab1 tableau_numerique;
TYPE TYP_VAR_TAB is VARRAY(30) of number(4,1) ;
tab2 TYP_VAR_TAB := TYP_VAR_TAB(0,0,0,0,0);
nbPoids int;
PasDePoids exception;

BEGIN
select count(*)into nbPoids from cdi_poids;
if nbPoids =0 then
    raise PasDePoids;
end if;
exception
when PasDePoids then
vMessage:= 'Table CDI_POIDS vide';
    insert into cdi_poimessage(POM_MESSAGE_124, POM_TOTAL_LU,POM_MESSAGE_3,POM_LOGIN, POM_DATE_JOUR )
    values (vMessage, vNBArticle, vMessage_2, user, sysdate);
    commit;
    raise_application_error(-20001, ' cdi_poids est vide');
end;
begin
    
select count(*) into vnbArticle from cdi_article
where ar_poids is not null  poi_code is null;
if vnbArticle = 0then
raise errPasDeTraitement;
end if;

exception
when PasDePoids then
vMessage:= 'Table CDI_POIDS ';
insert into cdi_poimessage(POM_MESSAGE_124, POM_TOTAL_LU,POM_MESSAGE_3,POM_LOGIN, POM_DATE_JOUR )
    values (vMessage, vNBArticle, vMessage_2, user, sysdate);
    commit;
    raise_application_error(-20001, ' cdi_poids est vide');
End loop ;
FOR i IN cdi_poids.FIRST..cdi_poids.LAST LOOP
dbms_output.put_line( 'tab1:'||tab1(i)||' tab2:'||tab2(i) ) ;
End loop ;
  NULL;
END P37;
/

/*3.7.B ne fonctionne pas*/
create or replace PROCEDURE PLSQL_PROC_37 AS 
type tableau_numerique is  TABLE OF NUMBER INDEX BY BINARY_INTEGER;
cursor c is select poi_max from cdi_poids;
cursor cl is select ar_poid, ar_code from cdi_article;
cPoids cdi_poids.poi_max%type;
vTabPoidsMAx tableau_numerique;
nbLigne int;
nbArticleLu int;
i int;
BEGIN
dbms_output.put_line(chr(10) || 'BLOC 3');
i:=0;
  open c;
  loop
        fetch c into cPoids;
        exit when c%NOTFOUND;
        i:=i+1;
        vTabPoidsMax(i):=cPoids;
        dbms_output.put_line('vpoidsmax' || cpoids);
         close c;
        select count(*) into nbLigne from cdi_article;
        nbArticleLu :=0;
    
    open cl;
    loop
        fetch cl into cpoids;
        exit when cl%notfound;
        nbArticleLu := nbArticleLu+1;
        i:=1;
        while cpoids > vtabpoidsmax 
            i:= i+1;
        end loop;
        update cdi_article ste poi_code = i where current of cl;
        end loop;
        close cl;
        vMessage = 'table CDI ARTICLE traité';
        if vnbArticlelu = nbLigne then
            vmessage_2 := 'en totalité';
        else
            vMessage_2 := 'patiellement';
        end if;
        insert into cdi_poimessage (pom_messsage_124, pom_total_lu, pom_message, pom_login, pom_date_jour)
        values(vMessage, nbLigne, vMesage2, user, sysdate);
        
    
        
END PLSQL_PROC_37;
/