/*
select * from RAP_CLIENT;

select * from RAP_CLIENT where CLI_COURRIEL like 'test@gmail.com';

select max(cli_num) as max from rap_client;

select * from rap_commande

where cli_num = 0;

select * from rap_client where cli_nom like 'test%' or cli_prenom like 'test%';

select * from rap_commande
where cli_num = 1243;
*/
/*
insert into rap_commande values (2,99999,1243, sysdate, sysdate, 7.18 , 0, 0, 15);
insert into rap_commande values (2,99998,1243, sysdate, sysdate, 43.88 , 0, 0, 35);
insert into rap_commande values (1,99997,1243, sysdate, sysdate, 14.78 , 0, 0, 35);
insert into rap_commande values (1,99996,1243, sysdate, sysdate, 12.24 , 0, 0, 20);
insert into rap_commande values (1,99995,1243, sysdate, sysdate, 23.2 , 0, 0, 8);
insert into rap_commande values (1,99994,1243, sysdate, sysdate, 55.68 , 0, 0, 25);
insert into rap_commande values (1,99993,1243, sysdate, sysdate, 27.84 , 0, 0, 8);
*/


--insert into rap_fidelisation values (1243,to_date(sysdate, 'hh24:mi:ss'),'3012');
--insert into rap_fidelisation values (1243,to_date(sysdate, 'hh24:mi:ss'),'829');
--insert into rap_fidelisation values (1243,to_date(sysdate, 'hh24:mi:ss'),'1005');

--DELETE from rap_commande
--where cli_num = 1243;
--insert into rap_fidelisation values (1240, sysdate ,2515);
/*

select * from rap_fidelisation
where cli_num = 1241;

select sum(total_points) as somme from rap_fidelisation
where cli_num = 1240;
--insert into rap_fidelisation values (1240, sysdate ,2515);
/*

select * from rap_fidelisation
where cli_num = 1241;

select sum(total_points) as somme from rap_fidelisation
where cli_num = 1240;


select nvl(cli_num,null) as n from rap_client
where cli_num in (
    select cli_num from rap_administrateur
) and cli_num = 1241;

select * from rap_client;

select * from rap_client 
where cli_nom like 'test998%';
*/
--delete from rap_client
--where cli_nom like 'test998';

select * from rap_client;
select max(com_num) from rap_commande;

--insert into rap_commande values ('2',(select max(com_num) from rap_commande) + 1,'1241','25/12/2022',to_date('00:00:21','hh24:mi:ss'),'7,18','0','0','15');


select * from rap_commande
order by cli_num;

select * from rap_commande where cli_num = 1241;
