use tcv;
INSERT INTO student (

INSERT INTO institution (id, name, full_name, type) VALUES
			   (1, "UL","Université de Lomé", "Université"),
               (2, "UK", "Universtié de Kara", "Université"),
               (3, "ESA", "Ecole Supérieur des Affaires", "Ecole");

INSERT INTO structure (id, name, full_name, id_institution) VALUES
			 (1, "FDSI", "Faculté des sciences et Informatique", 2),
             (2, "FDS", "Faculté Des Sciences", 1),
             (3, "FSS", "Faculté des Sciences et Santé", 1),
             (4, "FDD", "Faculté de Droit", 1),
             (5, "ESA", "Ecole Superieur des Affaires", 3);
INSERT INTO departement (id, name, full_name, id_structure) VALUES
			 (1, "MTH", "Mathématiques", 2),
             (2, "DP", "Droit Privé", 4),
             (3, "PHY", "Physique", 2),
             (4, "MTHI", "Mathématiques", 1),
             (5, "CHM", "Chimie", 2);
INSERT INTO semestre (id, name, full_name) VALUES
			 (1, "SEM 1", "Semstre 1"),
             (2, "SEM 2", "Semstre 2"),
             (3, "SEM 3", "Semstre 3"),
             (4, "SEM 4", "Semstre 4"),
             (5, "SEM 5", "Semstre 5"),
             (6, "SEM 6", "Semstre 6");
INSERT INTO departement_semestre (id_departement, id_semestre) VALUES
	   (1,1),
       (1,2),
       (1,3);
INSERT INTO matiere (id, name, full_name, id_semestre) VALUES
	   (1, "MTH 100", "Bases mathématiques",1),
       (2, "MTH 101", "Algèbre linéaire de base", 1),
       (3, "MTH 102", "Structure algébriques de bases", 2),
       (4, "MTH 220", "Algèbre multilinéaire", 3);
INSERT INTO section (id, full_name) VALUES
			 (1, "Examen"),
             (2, "Devoir"),
             (3, "Rattrapage");
INSERT INTO matiere_section (id_matiere, id_section) VALUES
       (1,1),
       (1,2),
       (2,1),
       (1,3);
INSERT INTO epreuve (id, full_name, id_section) VALUES
	   (1, year(date('2020-01-01')), 1),
       (2, year(date('2019-01-01')), 1),
       (3, year(date('2020-01-01')), 2),
       (4, year(date('2018-01-01')), 2);
