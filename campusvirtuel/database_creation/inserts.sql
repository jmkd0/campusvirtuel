use tcv;
INSERT INTO student (id, pseudo, institution, structure, departement) VALUES
			("6c70c47b-f3cf-11eb-af39-7cb0c2b7a2c3", "Jean", "Université de Lomé", "FDS", "Mathématiques"),
			("a21afd03-f3cf-11eb-af39-7cb0c2b7a2c3", "Komlan", "Université de Lomé", "FDS", "Chimie");

INSERT INTO institution (id, name, full_name, type) VALUES
			   ("1b801205-f3c9-11eb-af39-7cb0c2b7a2c3", "UL","Université de Lomé", "Université"),
               ("1b8114ae-f3c9-11eb-af39-7cb0c2b7a2c3", "UK", "Universtié de Kara", "Université"),
               ("1b811ddb-f3c9-11eb-af39-7cb0c2b7a2c3", "ESA", "Ecole Supérieur des Affaires", "Ecole"),
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
             ("336bab2e-f3cd-11eb-af39-7cb0c2b7a2c3", "CHM", "Chimie", "1e10e19e-f3cc-11eb-af39-7cb0c2b7a2c3");
INSERT INTO semestre (id, name, full_name, type, cycle) VALUES
			 ("401706e3-f3cd-11eb-af39-7cb0c2b7a2c3", "SEM 1", "Semestre 1", "Harmattan","Cycle 1"),
             ("5ff0a6bf-f3cd-11eb-af39-7cb0c2b7a2c3", "SEM 2", "Semestre 2","Mousson","Cycle 1"),
             ("681e9316-f3cd-11eb-af39-7cb0c2b7a2c3", "SEM 3", "Semestre 3","Harmattan","Cycle 1"),
             ("7116a1a4-f3cd-11eb-af39-7cb0c2b7a2c3", "SEM 4", "Semestre 4","Mousson","Cycle 1"),
             ("87f152fc-f3cd-11eb-af39-7cb0c2b7a2c3", "SEM 5", "Semestre 5","Harmattan","Cycle 1"),
             ("90bdb4d3-f3cd-11eb-af39-7cb0c2b7a2c3", "SEM 6", "Semestre 6","Mousson","Cycle 1");
             
INSERT INTO departement_semestre (id_departement, id_semestre) VALUES
	   ("11f0f2d5-f3cd-11eb-af39-7cb0c2b7a2c3","401706e3-f3cd-11eb-af39-7cb0c2b7a2c3"),
       ( "11f0f2d5-f3cd-11eb-af39-7cb0c2b7a2c3", "5ff0a6bf-f3cd-11eb-af39-7cb0c2b7a2c3"),
       ("11f0f2d5-f3cd-11eb-af39-7cb0c2b7a2c3", "681e9316-f3cd-11eb-af39-7cb0c2b7a2c3");
INSERT INTO matiere (id, name, full_name, id_departement, id_semestre) VALUES
	   ("dbc2b2ef-f3cd-11eb-af39-7cb0c2b7a2c3", "MTH 100", "Bases mathématiques","11f0f2d5-f3cd-11eb-af39-7cb0c2b7a2c3", "401706e3-f3cd-11eb-af39-7cb0c2b7a2c3"),
       ("e3dfb8db-f3cd-11eb-af39-7cb0c2b7a2c3", "MTH 101", "Algèbre linéaire de base", "11f0f2d5-f3cd-11eb-af39-7cb0c2b7a2c3", "401706e3-f3cd-11eb-af39-7cb0c2b7a2c3"),
       ("eda61e28-f3cd-11eb-af39-7cb0c2b7a2c3", "MTH 102", "Structure algébriques de bases", "11f0f2d5-f3cd-11eb-af39-7cb0c2b7a2c3", "5ff0a6bf-f3cd-11eb-af39-7cb0c2b7a2c3"),
       ("f4690f74-f3cd-11eb-af39-7cb0c2b7a2c3", "MTH 220", "Algèbre multilinéaire", "11f0f2d5-f3cd-11eb-af39-7cb0c2b7a2c3", "681e9316-f3cd-11eb-af39-7cb0c2b7a2c3");
INSERT INTO section (id, full_name) VALUES
			 ("4f59966d-f3ce-11eb-af39-7cb0c2b7a2c3", "Examen"),
             ("55faa8ae-f3ce-11eb-af39-7cb0c2b7a2c3", "Devoir"),
             ("5dd9d5ed-f3ce-11eb-af39-7cb0c2b7a2c3", "Rattrapage");
INSERT INTO matiere_section (id_matiere, id_section) VALUES
       ("dbc2b2ef-f3cd-11eb-af39-7cb0c2b7a2c3","4f59966d-f3ce-11eb-af39-7cb0c2b7a2c3"),
       ("dbc2b2ef-f3cd-11eb-af39-7cb0c2b7a2c3","55faa8ae-f3ce-11eb-af39-7cb0c2b7a2c3"),
       ("e3dfb8db-f3cd-11eb-af39-7cb0c2b7a2c3", "4f59966d-f3ce-11eb-af39-7cb0c2b7a2c3"),
       ("e3dfb8db-f3cd-11eb-af39-7cb0c2b7a2c3", "55faa8ae-f3ce-11eb-af39-7cb0c2b7a2c3");
INSERT INTO epreuve (id, full_name, id_matiere, id_section) VALUES
	   ("b38ad5a0-f3ce-11eb-af39-7cb0c2b7a2c3", year(date('2020-01-01')), "dbc2b2ef-f3cd-11eb-af39-7cb0c2b7a2c3", "4f59966d-f3ce-11eb-af39-7cb0c2b7a2c3"),
       ("bb8953d3-f3ce-11eb-af39-7cb0c2b7a2c3", year(date('2019-01-01')), "dbc2b2ef-f3cd-11eb-af39-7cb0c2b7a2c3", "4f59966d-f3ce-11eb-af39-7cb0c2b7a2c3"),
       ("ca58bdee-f3ce-11eb-af39-7cb0c2b7a2c3", year(date('2020-01-01')), "dbc2b2ef-f3cd-11eb-af39-7cb0c2b7a2c3", "55faa8ae-f3ce-11eb-af39-7cb0c2b7a2c3"),
       ("c2b3875f-f3ce-11eb-af39-7cb0c2b7a2c3", year(date('2020-01-01')), "e3dfb8db-f3cd-11eb-af39-7cb0c2b7a2c3", "4f59966d-f3ce-11eb-af39-7cb0c2b7a2c3"),
       ("0bd6cf3a-fdaa-11eb-8ef0-7cb0c2b7a2c3", year(date('2018-01-01')), "e3dfb8db-f3cd-11eb-af39-7cb0c2b7a2c3", "55faa8ae-f3ce-11eb-af39-7cb0c2b7a2c3");
