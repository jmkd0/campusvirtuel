use tcv;
INSERT INTO student (id, pseudo, institution, structure, departement) VALUES
			("6c70c47b-f3cf-11eb-af39-7cb0c2b7a2c3", "Jean", "Université de Lomé", "FDS", "Mathématiques"),
			("a21afd03-f3cf-11eb-af39-7cb0c2b7a2c3", "Komlan", "Université de Lomé", "FDS", "Chimie");

INSERT INTO institution (id, name, full_name, type) VALUES
			   ("1b801205-f3c9-11eb-af39-7cb0c2b7a2c3", "UL","Université de Lomé", "Université"),
               ("1b8114ae-f3c9-11eb-af39-7cb0c2b7a2c3", "UK", "Universtié de Kara", "Université"),
               ("1b811ddb-f3c9-11eb-af39-7cb0c2b7a2c3", "ESA", "Ecole Supérieur des Affaires", "Ecole")
               ("9f580798-f84c-11eb-bb84-7cb0c2b7a2c3", "UKP","Université de Kpalimé","Université");

INSERT INTO structure (id, name, full_name, id_institution) VALUES
			 ("0bd7916f-f3cc-11eb-af39-7cb0c2b7a2c3", "FDSI", "Faculté des sciences et Informatique", "1b8114ae-f3c9-11eb-af39-7cb0c2b7a2c3"),
             ("1e10e19e-f3cc-11eb-af39-7cb0c2b7a2c3", "FDS", "Faculté Des Sciences", "1b801205-f3c9-11eb-af39-7cb0c2b7a2c3"),
             ("2b5c0576-f3cc-11eb-af39-7cb0c2b7a2c3", "FSS", "Faculté des Sciences et Santé", "1b801205-f3c9-11eb-af39-7cb0c2b7a2c3"),
             ("3497763b-f3cc-11eb-af39-7cb0c2b7a2c3", "FDD", "Faculté de Droit", "1b801205-f3c9-11eb-af39-7cb0c2b7a2c3"),
             ("3c9c21e2-f3cc-11eb-af39-7cb0c2b7a2c3", "ESA", "Ecole Superieur des Affaires", "1b811ddb-f3c9-11eb-af39-7cb0c2b7a2c3"),
             ("cbe3af5a-fd24-11eb-9cab-7cb0c2b7a2c3","FYG","Fac de Fuoul","1b801205-f3c9-11eb-af39-7cb0c2b7a2c3");
INSERT INTO departement (id, name, full_name, id_structure) VALUES
			 ("11f0f2d5-f3cd-11eb-af39-7cb0c2b7a2c3", "MTH", "Mathématiques", "1e10e19e-f3cc-11eb-af39-7cb0c2b7a2c3"),
             ("1c95a4af-f3cd-11eb-af39-7cb0c2b7a2c3", "DP", "Droit Privé", "3497763b-f3cc-11eb-af39-7cb0c2b7a2c3"),
             ("237d0c14-f3cd-11eb-af39-7cb0c2b7a2c3", "PHY", "Physique", "1e10e19e-f3cc-11eb-af39-7cb0c2b7a2c3"),
             ("2c274a39-f3cd-11eb-af39-7cb0c2b7a2c3", "MTHI", "Mathématiques", "0bd7916f-f3cc-11eb-af39-7cb0c2b7a2c3"),
             ("336bab2e-f3cd-11eb-af39-7cb0c2b7a2c3", "CHM", "Chimie", "1e10e19e-f3cc-11eb-af39-7cb0c2b7a2c3"),
             ("11f0f2d5-f3cd-11eb-af39-7cb0c2b7a2c3","MTH","Mathématiques", "1e10e19e-f3cc-11eb-af39-7cb0c2b7a2c3");
INSERT INTO semestre (id, name, full_name, type, cycle) VALUES
			 ("401706e3-f3cd-11eb-af39-7cb0c2b7a2c3", "SEM 1", "Semestre 1", "Harmattan","Cycle 1"),
             ("5ff0a6bf-f3cd-11eb-af39-7cb0c2b7a2c3", "SEM 2", "Semestre 2","Mousson","Cycle 1"),
             ("681e9316-f3cd-11eb-af39-7cb0c2b7a2c3", "SEM 3", "Semestre 3","Harmattan","Cycle 1"),
             ("7116a1a4-f3cd-11eb-af39-7cb0c2b7a2c3", "SEM 4", "Semestre 4","Mousson","Cycle 1"),
             ("87f152fc-f3cd-11eb-af39-7cb0c2b7a2c3", "SEM 5", "Semestre 5","Harmattan","Cycle 1"),
             ("90bdb4d3-f3cd-11eb-af39-7cb0c2b7a2c3", "SEM 6", "Semestre 6","Mousson","Cycle 1");
             
INSERT INTO departement_semestre (id, id_departement, id_semestre) VALUES
	   ("d44e5ec1-fd4f-11eb-9cab-7cb0c2b7a2c3","11f0f2d5-f3cd-11eb-af39-7cb0c2b7a2c3","401706e3-f3cd-11eb-af39-7cb0c2b7a2c3"),
       ("01a46d86-fd50-11eb-9cab-7cb0c2b7a2c3", "11f0f2d5-f3cd-11eb-af39-7cb0c2b7a2c3", "5ff0a6bf-f3cd-11eb-af39-7cb0c2b7a2c3"),
       ("0d1e087f-fd50-11eb-9cab-7cb0c2b7a2c3", "11f0f2d5-f3cd-11eb-af39-7cb0c2b7a2c3", "681e9316-f3cd-11eb-af39-7cb0c2b7a2c3");
INSERT INTO matiere (id, name, full_name, id_semestre) VALUES
	   ("dbc2b2ef-f3cd-11eb-af39-7cb0c2b7a2c3", "MTH 100", "Bases mathématiques","401706e3-f3cd-11eb-af39-7cb0c2b7a2c3"),
       ("e3dfb8db-f3cd-11eb-af39-7cb0c2b7a2c3", "MTH 101", "Algèbre linéaire de base", "401706e3-f3cd-11eb-af39-7cb0c2b7a2c3"),
       ("eda61e28-f3cd-11eb-af39-7cb0c2b7a2c3", "MTH 102", "Structure algébriques de bases", "5ff0a6bf-f3cd-11eb-af39-7cb0c2b7a2c3"),
       ("f4690f74-f3cd-11eb-af39-7cb0c2b7a2c3", "MTH 220", "Algèbre multilinéaire", "681e9316-f3cd-11eb-af39-7cb0c2b7a2c3");
INSERT INTO section (id, full_name) VALUES
			 ("4f59966d-f3ce-11eb-af39-7cb0c2b7a2c3", "Examen"),
             ("55faa8ae-f3ce-11eb-af39-7cb0c2b7a2c3", "Devoir"),
             ("5dd9d5ed-f3ce-11eb-af39-7cb0c2b7a2c3", "Rattrapage");
INSERT INTO matiere_section (id, id_matiere, id_section) VALUES
       ("3d6f647e-fd50-11eb-9cab-7cb0c2b7a2c3", "dbc2b2ef-f3cd-11eb-af39-7cb0c2b7a2c3","4f59966d-f3ce-11eb-af39-7cb0c2b7a2c3"),
       ("4a4978fe-fd50-11eb-9cab-7cb0c2b7a2c3", "dbc2b2ef-f3cd-11eb-af39-7cb0c2b7a2c3","55faa8ae-f3ce-11eb-af39-7cb0c2b7a2c3"),
       ("547b42f2-fd50-11eb-9cab-7cb0c2b7a2c3", "e3dfb8db-f3cd-11eb-af39-7cb0c2b7a2c3","4f59966d-f3ce-11eb-af39-7cb0c2b7a2c3"),
       ("5ea9f60a-fd50-11eb-9cab-7cb0c2b7a2c3", "dbc2b2ef-f3cd-11eb-af39-7cb0c2b7a2c3","5dd9d5ed-f3ce-11eb-af39-7cb0c2b7a2c3");
INSERT INTO epreuve (id, full_name, id_section) VALUES
	   ("b38ad5a0-f3ce-11eb-af39-7cb0c2b7a2c3", year(date('2020-01-01')), "4f59966d-f3ce-11eb-af39-7cb0c2b7a2c3"),
       ("bb8953d3-f3ce-11eb-af39-7cb0c2b7a2c3", year(date('2019-01-01')), "4f59966d-f3ce-11eb-af39-7cb0c2b7a2c3"),
       ("c2b3875f-f3ce-11eb-af39-7cb0c2b7a2c3", year(date('2020-01-01')), "55faa8ae-f3ce-11eb-af39-7cb0c2b7a2c3"),
       ("ca58bdee-f3ce-11eb-af39-7cb0c2b7a2c3", year(date('2018-01-01')), "55faa8ae-f3ce-11eb-af39-7cb0c2b7a2c3");

UPDATE semestre SET  full_name = "Semestre 6" where id = "90bdb4d3-f3cd-11eb-af39-7cb0c2b7a2c3";

/*INSERTS*/
/*Institution*/
INSERT INTO institution (name, full_name, type, logo_path, created_date, updated_date) VALUES (?,?,?,?, now(),now());
/*Structure*/
INSERT INTO structure (name, full_name, type, logo_path, id_institution, created_date, updated_date) VALUES (?,?,?,?,now(),now());
/*Departement*/
INSERT INTO departement (name, full_name, logo_path, id_structure, created_date, updated_date) VALUES (?,?,?,?,now(),now());
/*Semestre*//*Departement Semestre*/
INSERT INTO semestre (name, type, full_name) VALUES (?,?,?);
INSERT INTO departement_semestre (id_departement, id_semestre, created_date, updated_date) VALUES(?,?,now(),now());
/*Matiere*/
INSERT INTO matiere (name, full_name, id_semestre, created_date, updated_date) VALUES(?,?,?,now(),now());
/*Section*/ /*Section matiere*/
INSERT INTO section (full_name, logo_path) VALUES(?,?);
INSERT INTO matiere_section (id_matiere, id_section, created_date, updated_date) VALUES(?,?,now(),now());
/*Epreuve*/
INSERT INTO epreuve (full_name, file_path, id_section, created_date, updated_date) VALUES (?,?,?,now(),now());

/*UPDATES*/
/*Institution*/
UPDATE institution SET name=?, full_name=?, type=?, logo_path=?, updated_date=now() WHERE id = ?;
/*Structure*/
UPDATE structure SET name=?, full_name=?, type=?, logo_path=?, updated_date=now() WHERE id = ?;
/*Departement*/
UPDATE departement SET name=?, full_name=?, logo_path=?, updated_date=now() WHERE id = ?;
/*Semestre*//*Departement Semestre*/
UPDATE semestre SET  name=?, type=?, full_name=? WHERE id = ?;
UPDATE departement_semestre SET id_departement=?, id_semestre=?, created_date=?, updated_date=? VALUES(?,?,now(),now())
/*Matiere*/
UPDATE matiere SET name=?, full_name=?, updated_date=now() WHERE id = ?;
/*Section*/ /*Section matiere*/
UPDATE section SET full_name=?, logo_path=? WHERE id = ?;
/*Epreuve*/
UPDATE epreuve SET full_name=?, file_path=?, updated_date=now() WHERE id = ?;

/*DELETES*/
DELETE FROM institution WHERE id = ?;
DELETE FROM structure WHERE id = ?;
DELETE FROM departement WHERE id = ?;
DELETE FROM semestre WHERE id = ?;
DELETE FROM matiere WHERE id = ?;
DELETE FROM section WHERE id = ?;
DELETE FROM epreuve WHERE id = ?;


select id from section where full_name =?
select id from matiere_section WHERE id_matiere=? AND id_section=?

select * from section s
left join matiere_section ms on ms.id_section = s.id
where s.full_name = "Examen" and id_matiere=? and id_section="4f59966d-f3ce-11eb-af39-7cb0c2b7a2c3"


