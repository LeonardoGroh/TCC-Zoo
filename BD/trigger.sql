
delimiter &&
##triggers usuarios
create trigger inserir_usuario before insert on usuario for each row begin
insert into usuario_log values
(null,new.senha,new.tipo,new.ativo,'INSERT',now(),new.nome,null,new.email,new.login,new.cpf);
end&& 	

create trigger alterar_usuario before update on usuario for each row begin
insert into usuario_log values
(null,old.senha,old.tipo,old.ativo,'UPDATE',now(),old.nome,null,old.email,old.login,old.cpf);
end&&

create trigger deletar_usuario before delete on usuario for each row begin
insert into usuario_log values
(null,old.senha,old.tipo,old.ativo,'DELETE',now(),old.nome,null,old.email,old.login,old.cpf);
end&&


##triggers da especie
create trigger inserir_especie before insert on especie for each row begin
insert into especie_log values
(null,new.in169,new.nomeCien,
new.nomePop,new.familia,
new.seguranca,'INSERT',now(),1,null);
end&&

create trigger alterar_especie before update on especie for each row begin
insert into especie_log values
(null,old.in169,old.nomeCien,
old.nomePop,old.familia,
old.seguranca,'UPDATE',now(),1,null);
end&&

create trigger deletar_especie before delete on especie for each row begin
insert into especie_log values
(null,old.in169,old.nomeCien,
old.nomePop,old.familia,
old.seguranca,'DELETE',now(),1,null);
end&&
	
##triggers recinto
create trigger inserir_recinto before insert on recinto for each row begin
insert into recinto_log values
(null,new.planta,new.segurancarecinto,new.ativo,'INSERT',now(),null,1);
end&&

create trigger alterar_recinto before update on recinto for each row begin
insert into recinto_log values
(null,old.planta,old.segurancarecinto,old.ativo,'UPDATE',now(),old.idrecinto,1);
end&&


##triggers do animal
create trigger inserir_animal before insert on animal for each row begin
insert into animal_log values
(null,new.obs,new.procedencia,
new.entrada,new.idvet,new.sexo,new.desfecho,
new.desfechodata,new.idespecie,
new.imagem,new.marcacao,
new.apelido,new.idrecinto,'INSERT',now(),null,1);
end&&

create trigger alterar_animal before update on animal for each row begin
insert into animal_log values
(null,old.obs,old.procedencia,
old.entrada,old.idvet,old.sexo,old.desfecho,
old.desfechodata,old.idespecie,
old.imagem,old.marcacao,
old.apelido,old.idrecinto,'UPDATE',now(),null,1);
end&&

create trigger deletar_animal before delete on animal for each row begin
insert into animal_log values
(null,old.obs,old.procedencia,
old.entrada,old.idvet,old.sexo,old.desfecho,
old.desfechodata,old.idespecie,
old.imagem,old.marcacao,
old.apelido,old.idrecinto,'DELETE',now(),null,1);
end&&

##triggers Vet
create trigger inserir_vet before insert on vet for each row begin
insert into vet_log values
(null,new.fezes,new.vermifugo,new.ano,new.idanimal,'INSERT',now(),null,1);
end&&

create trigger alterar_vet before update on vet for each row begin
insert into vet_log values
(null,old.fezes,old.vermifugo,old.ano,old.idanimal,'UPDATE',now(),null,1);
end&&


create trigger deletar_vet before delete on vet for each row begin
insert into vet_log values
(null,old.fezes,old.vermifugo,old.ano,old.idanimal,'DELETE',now(),null,1);
end&&


##triggers obs

create trigger inserir_obs before insert on obs for each row begin
insert into obs_log values
(null,new.obs,new.date,new.idvet,'INSERT',now(),null,1);
end&&

create trigger alterar_obs before update on obs for each row begin
insert into obs_log values
(null,old.obs,old.date,old.idvet,'UPDATE',now(),null,1);
end&&

create trigger deletar_obs before delete on obs for each row begin
insert into obs_log values
(null,old.obs,old.date,old.idvet,'DELETE',now(),null,1);
end&&
