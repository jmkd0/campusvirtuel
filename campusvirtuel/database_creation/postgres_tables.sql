/*Drop All Tables*/
/*drop table student;
drop table epreuve;
drop table matiere_section;
drop table section;
drop table matiere;
drop table departement_semestre;
drop table semestre;
drop table departement;
drop table structure;
drop table institution;
*/
create table student(
	id      uuid not null primary key,
	pseudo 	varchar,
	institution varchar,
	structure varchar,
	departement varchar,
	cycle varchar,
	mail varchar,
	password varchar,
	created_date timestamp not null ,
	updated_date timestamp not null 
);

create table institution(
	id      uuid not null primary key,
	name varchar,
	full_name varchar,
	type varchar,
	file_name varchar,
	created_date timestamp not null ,
	updated_date timestamp not null 
);


create table structure(
	id      uuid not null primary key,
	name varchar,
	full_name varchar,
	type varchar,
	file_name varchar,
	created_date timestamp not null ,
	updated_date timestamp not null ,
	id_institution uuid not null,
	foreign key (id_institution) references institution (id)
	on delete cascade on update cascade
);

             
create table departement(
	id      uuid not null primary key,
	name varchar,
	full_name varchar,
	file_name varchar,
	created_date timestamp not null ,
	updated_date timestamp not null ,
	id_structure uuid not null,
	foreign key (id_structure) references structure (id)
	on delete cascade on update cascade
);

create table semestre(
	id      uuid not null primary key,
	name varchar,
	type varchar,
	full_name varchar,
	cycle varchar
);

create table departement_semestre(
	id_departement uuid not null,
	id_semestre uuid not null,
	created_date timestamp not null ,
	updated_date timestamp not null ,
	primary key (id_departement, id_semestre),
	foreign key (id_departement) references departement (id)
	on delete cascade on update cascade,
	foreign key (id_semestre) references semestre (id)
	on delete cascade on update cascade
);

create table matiere(
	id      uuid not null primary key,
	name varchar,
	full_name varchar,
	created_date timestamp not null ,
	updated_date timestamp not null ,
	id_departement uuid not null,
	id_semestre uuid not null,
	foreign key (id_departement, id_semestre) references departement_semestre (id_departement, id_semestre)
	on delete cascade on update cascade
);

create table section(
	id      uuid not null primary key,
	full_name varchar
);

create table matiere_section(
	id_matiere uuid not null,
	id_section uuid not null,
	created_date timestamp not null ,
	updated_date timestamp not null ,
	primary key (id_matiere, id_section),
	foreign key (id_matiere) references matiere (id)
	on delete cascade on update cascade,
	foreign key (id_section) references section (id)
	on delete cascade on update cascade
);


create table epreuve(
	id      uuid not null primary key,
	full_name numeric,
	file_name varchar,
	id_matiere uuid not null,
	id_section uuid not null,
	created_date timestamp not null ,
	updated_date timestamp not null ,
	foreign key (id_matiere, id_section) references matiere_section (id_matiere, id_section)
	on delete cascade on update cascade
);

       