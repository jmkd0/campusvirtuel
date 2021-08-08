use tcv;
select * from institution;
select * from structure;
select * from departement;
select * from semestre;
select * from departement_semestre;
select * from matiere;
select * from section;
select * from matiere_section;
select * from epreuve;


select 
ins.name,
str.name,
dep.name,
sem.name,
mat.name,
sec.name, 
epr.annee
from epreuve epr
left join section sec on sec.id = epr.id_section
left join matiere_section mat_sec on mat_sec.id_section = sec.id
left join matiere mat on mat.id = mat_sec.id_matiere
left join semestre sem on sem.id = mat.id_semestre
left join departement_semestre dep_sem on dep_sem.id_semestre = sem.id
left join departement dep on dep.id = dep_sem.id_departement
left join structure str on str.id = dep.id_structure
left join institution ins on ins.id = str.id_institution;

select 
ins.name,
str.name,
dep.name,
sem.name,
mat.name,
sec.name
from section sec
left join matiere_section mat_sec on mat_sec.id_section = sec.id
left join matiere mat on mat.id = mat_sec.id_matiere
left join semestre sem on sem.id = mat.id_semestre
left join departement_semestre dep_sem on dep_sem.id_semestre = sem.id
left join departement dep on dep.id = dep_sem.id_departement
left join structure str on str.id = dep.id_structure
left join institution ins on ins.id = str.id_institution;

select 
ins.name,
str.name,
dep.name,
sem.name,
mat.name
from matiere mat
left join semestre sem on sem.id = mat.id_semestre
left join departement_semestre dep_sem on dep_sem.id_semestre = sem.id
left join departement dep on dep.id = dep_sem.id_departement
left join structure str on str.id = dep.id_structure
left join institution ins on ins.id = str.id_institution;

select 
ins.name,
str.name,
dep.name,
sem.name
from semestre sem
left join departement_semestre dep_sem on dep_sem.id_semestre = sem.id
left join departement dep on dep.id = dep_sem.id_departement
left join structure str on str.id = dep.id_structure
left join institution ins on ins.id = str.id_institution;

select 
ins.name,
str.name,
dep.name
from departement dep
left join structure str on str.id = dep.id_structure
left join institution ins on ins.id = str.id_institution;

select 
ins.name,
str.name
from structure str
left join institution ins on ins.id = str.id_institution;

select 
ins.name
from institution ins;