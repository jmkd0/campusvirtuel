
--CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
INSERT INTO student (id, pseudo, institution, structure, departement, created_date, updated_date) VALUES
			('6c70c47b-f3cf-11eb-af39-7cb0c2b7a2c3', 'Jean', 'Université de Lomé', 'FDS', 'Mathématiques',now(),now()),
			('a21afd03-f3cf-11eb-af39-7cb0c2b7a2c3', 'Komlan', 'Université de Lomé', 'FDS', 'Chimie',now(),now());

INSERT INTO institution (id, name, full_name, type, created_date, updated_date) VALUES
			   ('1b801205-f3c9-11eb-af39-7cb0c2b7a2c3', 'UL','Université de Lomé', 'Université',now(),now()),
               ('1b8114ae-f3c9-11eb-af39-7cb0c2b7a2c3', 'UK', 'Universtié de Kara', 'Université',now(),now()),
               ('1b811ddb-f3c9-11eb-af39-7cb0c2b7a2c3', 'ESA', 'Ecole Supérieur des Affaires', 'Ecole',now(),now()),
               ('002b578f-1af4-4272-b31e-daf3729658ec', 'ENAM','Ecole Nationale des Auxiliaires Médicaux', 'Ecole',now(),now()),
               ('fa6def37-73bd-4932-b0c5-54369ce96b2b', 'ESGIS', 'École Supérieure de Gestion, d''Informatique et des Sciences', 'Ecole',now(),now()),
               ('0bd778b3-0259-4545-92b4-dc6a8fd0650a', 'IAI','Institut Africaine d''Informatique','Ecole',now(),now()),
               ('23d0991a-ce2d-4caa-add6-a34123a84071', 'UCAO','Université Catholique de l''Afrique de l''Ouest','Ecole',now(),now());

INSERT INTO structure (id, name, full_name, id_institution, created_date, updated_date) VALUES
			 ('0bd7916f-f3cc-11eb-af39-7cb0c2b7a2c3', 'FDSI', 'Faculté des sciences et Informatique', '1b8114ae-f3c9-11eb-af39-7cb0c2b7a2c3',now(),now()),
             ('1e10e19e-f3cc-11eb-af39-7cb0c2b7a2c3', 'FDS', 'Faculté Des Sciences', '1b801205-f3c9-11eb-af39-7cb0c2b7a2c3',now(),now()),
             ('2b5c0576-f3cc-11eb-af39-7cb0c2b7a2c3', 'FSS', 'Facué des Sciences et Santé', '1b801205-f3c9-11eb-af39-7cb0c2b7a2c3',now(),now()),
             ('3497763b-f3cc-11eb-af39-7cb0c2b7a2c3', 'FDD', 'Faculté de Droit', '1b801205-f3c9-11eb-af39-7cb0c2b7a2c3',now(),now()),
             ('3c9c21e2-f3cc-11eb-af39-7cb0c2b7a2c3', 'ESA', 'Ecole Superieur des Affaires', '1b811ddb-f3c9-11eb-af39-7cb0c2b7a2c3',now(),now()),
             ('cbe3af5a-fd24-11eb-9cab-7cb0c2b7a2c3','FYG','Fac de Fuoul','1b801205-f3c9-11eb-af39-7cb0c2b7a2c3',now(),now());
INSERT INTO departement (id, name, full_name, id_structure, created_date, updated_date) VALUES
			 ('11f0f2d5-f3cd-11eb-af39-7cb0c2b7a2c3', 'MTH', 'Mathématiques', '1e10e19e-f3cc-11eb-af39-7cb0c2b7a2c3',now(),now()),
             ('1c95a4af-f3cd-11eb-af39-7cb0c2b7a2c3', 'DP', 'Droit Privé', '3497763b-f3cc-11eb-af39-7cb0c2b7a2c3',now(),now()),
             ('237d0c14-f3cd-11eb-af39-7cb0c2b7a2c3', 'PHY', 'Physique', '1e10e19e-f3cc-11eb-af39-7cb0c2b7a2c3',now(),now()),
             ('2c274a39-f3cd-11eb-af39-7cb0c2b7a2c3', 'MTHI', 'Mathématiques', '0bd7916f-f3cc-11eb-af39-7cb0c2b7a2c3',now(),now()),
             ('336bab2e-f3cd-11eb-af39-7cb0c2b7a2c3', 'CHM', 'Chimie', '1e10e19e-f3cc-11eb-af39-7cb0c2b7a2c3',now(),now());
INSERT INTO semestre (id, name, full_name, type, cycle) VALUES
			 ('401706e3-f3cd-11eb-af39-7cb0c2b7a2c3', 'SEM 1', 'Semestre 1', 'Harmattan','Cycle 1'),
             ('5ff0a6bf-f3cd-11eb-af39-7cb0c2b7a2c3', 'SEM 2', 'Semestre 2','Mousson','Cycle 1'),
             ('681e9316-f3cd-11eb-af39-7cb0c2b7a2c3', 'SEM 3', 'Semestre 3','Harmattan','Cycle 1'),
             ('7116a1a4-f3cd-11eb-af39-7cb0c2b7a2c3', 'SEM 4', 'Semestre 4','Mousson','Cycle 1'),
             ('87f152fc-f3cd-11eb-af39-7cb0c2b7a2c3', 'SEM 5', 'Semestre 5','Harmattan','Cycle 1'),
             ('90bdb4d3-f3cd-11eb-af39-7cb0c2b7a2c3', 'SEM 6', 'Semestre 6','Mousson','Cycle 1');
             
INSERT INTO departement_semestre (id_departement, id_semestre, created_date, updated_date) VALUES
	   ('11f0f2d5-f3cd-11eb-af39-7cb0c2b7a2c3','401706e3-f3cd-11eb-af39-7cb0c2b7a2c3',now(),now()),
       ( '11f0f2d5-f3cd-11eb-af39-7cb0c2b7a2c3', '5ff0a6bf-f3cd-11eb-af39-7cb0c2b7a2c3',now(),now()),
       ('11f0f2d5-f3cd-11eb-af39-7cb0c2b7a2c3', '681e9316-f3cd-11eb-af39-7cb0c2b7a2c3',now(),now());
INSERT INTO matiere (id, name, full_name, id_departement, id_semestre, created_date, updated_date) VALUES
	   ('dbc2b2ef-f3cd-11eb-af39-7cb0c2b7a2c3', 'MTH 100', 'Bases mathématiques','11f0f2d5-f3cd-11eb-af39-7cb0c2b7a2c3', '401706e3-f3cd-11eb-af39-7cb0c2b7a2c3',now(),now()),
       ('e3dfb8db-f3cd-11eb-af39-7cb0c2b7a2c3', 'MTH 101', 'Algèbre linéaire de base', '11f0f2d5-f3cd-11eb-af39-7cb0c2b7a2c3', '401706e3-f3cd-11eb-af39-7cb0c2b7a2c3',now(),now()),
       ('eda61e28-f3cd-11eb-af39-7cb0c2b7a2c3', 'MTH 102', 'Structure algébriques de bases', '11f0f2d5-f3cd-11eb-af39-7cb0c2b7a2c3', '5ff0a6bf-f3cd-11eb-af39-7cb0c2b7a2c3',now(),now()),
       ('f4690f74-f3cd-11eb-af39-7cb0c2b7a2c3', 'MTH 220', 'Algèbre multilinéaire', '11f0f2d5-f3cd-11eb-af39-7cb0c2b7a2c3', '681e9316-f3cd-11eb-af39-7cb0c2b7a2c3',now(),now());
INSERT INTO section (id, full_name) VALUES
			 ('4f59966d-f3ce-11eb-af39-7cb0c2b7a2c3', 'Examen'),
             ('55faa8ae-f3ce-11eb-af39-7cb0c2b7a2c3', 'Devoir'),
             ('83b8a91b-ac38-43d5-8683-9b4637947d45', 'Rattrapage');
INSERT INTO matiere_section (id_matiere, id_section, created_date, updated_date) VALUES
       ('dbc2b2ef-f3cd-11eb-af39-7cb0c2b7a2c3','4f59966d-f3ce-11eb-af39-7cb0c2b7a2c3',now(),now()),
       ('dbc2b2ef-f3cd-11eb-af39-7cb0c2b7a2c3','55faa8ae-f3ce-11eb-af39-7cb0c2b7a2c3',now(),now()),
       ('e3dfb8db-f3cd-11eb-af39-7cb0c2b7a2c3', '4f59966d-f3ce-11eb-af39-7cb0c2b7a2c3',now(),now()),
       ('e3dfb8db-f3cd-11eb-af39-7cb0c2b7a2c3', '55faa8ae-f3ce-11eb-af39-7cb0c2b7a2c3',now(),now());
INSERT INTO epreuve (id, full_name, id_matiere, id_section, created_date, updated_date) VALUES
	   ('b38ad5a0-f3ce-11eb-af39-7cb0c2b7a2c3', EXTRACT(YEAR FROM TIMESTAMP '2020-01-01'), 'dbc2b2ef-f3cd-11eb-af39-7cb0c2b7a2c3', '4f59966d-f3ce-11eb-af39-7cb0c2b7a2c3',now(),now()),
       ('bb8953d3-f3ce-11eb-af39-7cb0c2b7a2c3', EXTRACT(YEAR FROM TIMESTAMP '2019-01-01'), 'dbc2b2ef-f3cd-11eb-af39-7cb0c2b7a2c3', '4f59966d-f3ce-11eb-af39-7cb0c2b7a2c3',now(),now()),
       ('ca58bdee-f3ce-11eb-af39-7cb0c2b7a2c3', EXTRACT(YEAR FROM TIMESTAMP '2020-01-01'), 'dbc2b2ef-f3cd-11eb-af39-7cb0c2b7a2c3', '55faa8ae-f3ce-11eb-af39-7cb0c2b7a2c3',now(),now()),
       ('c2b3875f-f3ce-11eb-af39-7cb0c2b7a2c3', EXTRACT(YEAR FROM TIMESTAMP '2020-01-01'), 'e3dfb8db-f3cd-11eb-af39-7cb0c2b7a2c3', '4f59966d-f3ce-11eb-af39-7cb0c2b7a2c3',now(),now()),
       ('0bd6cf3a-fdaa-11eb-8ef0-7cb0c2b7a2c3', EXTRACT(YEAR FROM TIMESTAMP '2018-01-01'), 'e3dfb8db-f3cd-11eb-af39-7cb0c2b7a2c3', '55faa8ae-f3ce-11eb-af39-7cb0c2b7a2c3',now(),now());

