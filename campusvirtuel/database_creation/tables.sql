drop database if exists tcv;
create database tcv;
use tcv;
create table student(
id char(36) default (uuid()) not null primary key,
pseudo varchar(30),
institution varchar(100),
structure varchar(100),
departement varchar(100),
mail varchar(50),
password varchar(50),
created_date date,
updated_date date)
engine = innodb;


create table institution(
id char(36) default (uuid()) not null primary key,
name varchar(30),
full_name varchar(100),
type varchar(20),
logo_path varchar(100),
created_date date,
updated_date date)
engine = innodb;


create table structure(
id char(36) default (uuid()) not null primary key,
name varchar(30),
full_name varchar(100),
type varchar(20),
logo_path varchar(100),
id_institution char(36) not null,
created_date date,
updated_date date,
foreign key (id_institution) references institution (id)
on delete cascade on update cascade)
engine = innodb;

             
create table departement(
id char(36) default (uuid()) not null primary key,
name varchar(30),
full_name varchar(100),
logo_path varchar(100),
created_date date,
updated_date date,
id_structure char(36) not null,
foreign key (id_structure) references structure (id)
on delete cascade on update cascade)
engine = innodb;


create table semestre(
id char(36) default (uuid()) not null primary key,
name varchar(10),
type varchar(20),
full_name varchar(20),
logo_path varchar(100) )
engine = innodb;


create table departement_semestre(
id_departement char(36) not null,
id_semestre char(36) not null,
created_date date,
updated_date date,
primary key (id_departement, id_semestre),
foreign key (id_departement) references departement (id)
on delete cascade on update cascade,
foreign key (id_semestre) references semestre (id)
on delete cascade on update cascade)
engine = innodb;


create table matiere(
id char(36) default (uuid()) not null primary key,
name varchar(30),
full_name varchar(100),
created_date date,
updated_date date,
id_semestre char(36) not null,
foreign key (id_semestre) references semestre (id)
on delete cascade on update cascade)
engine = innodb;


create table section(
id char(36) default (uuid()) not null primary key,
full_name varchar(10),
type varchar(20),
logo_path varchar(100))
engine = innodb;


create table matiere_section(
id_matiere char(36) not null,
id_section char(36) not null,
created_date date,
updated_date date,
primary key (id_matiere, id_section),
foreign key (id_matiere) references matiere (id)
on delete cascade on update cascade,
foreign key (id_section) references section (id)
on delete cascade on update cascade)
engine = innodb;


create table epreuve(
id char(36) default (uuid()) not null primary key,
full_name year,
file_path varchar(100),
logo_path varchar(100),
id_section char(36) not null,
created_date date,
updated_date date,
foreign key (id_section) references section (id)
on delete cascade on update cascade)
engine = innodb;

       