drop database if exists tcv;
create database tcv;
use tcv;
create table institution(
id int not null primary key auto_increment,
name varchar(30),
full_name varchar(100),
type varchar(20),
logo_path varchar(100),
created_date date,
updated_date date)
engine = innodb;


create table structure(
id int not null primary key auto_increment,
name varchar(30),
full_name varchar(100),
type varchar(20),
logo_path varchar(100),
id_institution int not null,
created_date date,
updated_date date,
foreign key (id_institution) references institution (id)
on delete cascade on update cascade)
engine = innodb;

             
create table departement(
id int not null primary key auto_increment,
name varchar(30),
full_name varchar(100),
logo_path varchar(100),
created_date date,
updated_date date,
id_structure int not null,
foreign key (id_structure) references structure (id)
on delete cascade on update cascade)
engine = innodb;


create table semestre(
id int not null primary key auto_increment,
name varchar(10),
type varchar(20),
full_name varchar(20),
logo_path varchar(100) )
engine = innodb;


create table departement_semestre(
id_departement int not null,
id_semestre int not null,
created_date date,
updated_date date,
primary key (id_departement, id_semestre),
foreign key (id_departement) references departement (id)
on delete cascade on update cascade,
foreign key (id_semestre) references semestre (id)
on delete cascade on update cascade)
engine = innodb;


create table matiere(
id int not null primary key auto_increment,
name varchar(30),
full_name varchar(100),
created_date date,
updated_date date,
id_semestre int not null,
foreign key (id_semestre) references semestre (id)
on delete cascade on update cascade)
engine = innodb;


create table section(
id int not null primary key auto_increment,
name varchar(10),
type varchar(20),
logo_path varchar(100))
engine = innodb;


create table matiere_section(
id_matiere int not null,
id_section int not null,
created_date date,
updated_date date,
primary key (id_matiere, id_section),
foreign key (id_matiere) references matiere (id)
on delete cascade on update cascade,
foreign key (id_section) references section (id)
on delete cascade on update cascade)
engine = innodb;


create table epreuve(
id int not null primary key auto_increment,
annee year,
file_path varchar(100),
logo_path varchar(100),
id_section int not null,
created_date date,
updated_date date,
foreign key (id_section) references section (id)
on delete cascade on update cascade)
engine = innodb;

       