##Busca do Animal
select a.idanimal,a.marcacao,a.apelido,a.sexo,e.nomeCien,e.nomePop from animal a inner join especie e using (idespecie) where nomecien like '%phan%' or nomepop like '';
select a.idanimal,a.marcacao,a.apelido,a.sexo,e.nomeCien,e.nomePop from animal a inner join especie e using (idespecie) where idanimal= 10 or marcacao ='';
select a.idanimal,a.marcacao,a.apelido,a.sexo,e.nomeCien,e.nomePop from animal a inner join especie e using (idespecie) where idrecinto=3;

##Busca funcionario
select idusuario,nome,login from usuario where nome like '%Banana%' or login like '%ap%';
select idusuario,nome,login from usuario where CPF='000.000.000-00';

##Busca de recinto
select * from recinto;
select idrecinto,segurancarecinto,ativo from recinto where idrecinto=1;
select idrecinto,segurancarecinto,ativo from recinto where segurancarecinto=4;
select idrecinto,segurancarecinto,ativo from recinto where ativo=1;




delimiter &&
##Informaçõe para o perfil do animal

create procedure perfil_animal(in id int)begin

	select a.idanimal,a.marcacao,a.apelido,a.sexo,a.procedencia,day(a.entrada) as dia,month(a.entrada) as mes,year(a.entrada) as ano,a.desfecho,day(a.desfechodata) as dia,month(a.desfechodata) as mes ,year(a.desfechodata)as ano,a.imagem,a.idrecinto,a.obs,

        e.nomeCien,e.nomePop,e.in169,e.seguranca,

        v.idvet,v.vermifugo,v.ano,v.idanimal,

        o.obs,o.date from animal a
  
      inner join especie e using(idespecie)
 
       left join vet v using (idanimal)
 
       left join obs o on (v.idvet=o.idvet)

       where idanimal=id;
end&&

##Login
create procedure login (in sen varchar(45), log varchar(45))
begin
select tipo,idusuario from usuario where senha=md5(sen) and login=log;
end&&
##atualiza animal
Delimiter &&
CREATE  PROCEDURE atualiza_perfil_animal(in id int,in nescecidade varchar(100),in Aprocedencia varchar(45),in Aentrada date,in Asexo char,in Adesfecho varchar(45),in AdesfechoData date,in AidEsp int, in Amarcacao varchar(100),in Anick varchar(45),in Arecinto int)
begin
	update animal set obs=nescecidade,procedencia=Aprocedencia,entrada=Aentrada,sexo=Asexo,desfecho=Adesfecho,desfechoData=AdesfechoData,idEspecie=Aidesp,marcacao=Amarcacao,apelido=Anick,idrecinto=Arecinto where idanimal=id;
end&&
DELIMITER ;
call atualiza_perfil_animal(13,'obs','Teste',now(),'M','Concluido',now(),1,'98',null,5);

