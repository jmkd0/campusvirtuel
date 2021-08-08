select 
epr.id,
epr.full_name
from epreuve epr
left join section sec on sec.id = epr.id_section
left join matiere_section mat_sec on mat_sec.id_section = sec.id
left join matiere mat on mat.id = mat_sec.id_matiere
left join semestre sem on sem.id = mat.id_semestre
left join departement_semestre dep_sem on dep_sem.id_semestre = sem.id
left join departement dep on dep.id = dep_sem.id_departement
left join structure str on str.id = dep.id_structure
left join institution ins on ins.id = str.id_institution
where ins.id = ? and str.id = ? and dep.id = ? and sem.id = ? and mat.id = ? and sec.id = ?;

select 
sec.id,
sec.name
from section sec
left join matiere_section mat_sec on mat_sec.id_section = sec.id
left join matiere mat on mat.id = mat_sec.id_matiere
left join semestre sem on sem.id = mat.id_semestre
left join departement_semestre dep_sem on dep_sem.id_semestre = sem.id
left join departement dep on dep.id = dep_sem.id_departement
left join structure str on str.id = dep.id_structure
left join institution ins on ins.id = str.id_institution
where ins.id = ? and str.id = ? and dep.id = ? and sem.id = ? and mat.id = ?;

select 
mat.id,
mat.full_name
from matiere mat
left join semestre sem on sem.id = mat.id_semestre
left join departement_semestre dep_sem on dep_sem.id_semestre = sem.id
left join departement dep on dep.id = dep_sem.id_departement
left join structure str on str.id = dep.id_structure
left join institution ins on ins.id = str.id_institution
where ins.id = ? and str.id = ? and dep.id = ? and sem.id = ?;

select 
sem.id,
sem.full_name
from semestre sem
left join departement_semestre dep_sem on dep_sem.id_semestre = sem.id
left join departement dep on dep.id = dep_sem.id_departement
left join structure str on str.id = dep.id_structure
left join institution ins on ins.id = str.id_institution
where ins.id = ? and str.id = ? and dep.id = ?;

select 
ins.name,
str.name,
dep.name
from departement dep
left join structure str on str.id = dep.id_structure
left join institution ins on ins.id = str.id_institution
where ins.id = ? and str.id = ?;

select 
str.id,
str.name,
str.full_name
from structure str
left join institution ins on ins.id = str.id_institution
where ins.id = ?;



select 
                    sec.id,
                    sec.name
                    from section sec
                    left join matiere_section mat_sec on mat_sec.id_section = sec.id
                    left join matiere mat on mat.id = mat_sec.id_matiere
                    left join semestre sem on sem.id = mat.id_semestre
                    left join departement_semestre dep_sem on dep_sem.id_semestre = sem.id
                    left join departement dep on dep.id = dep_sem.id_departement
                    left join structure str on str.id = dep.id_structure
                    left join institution ins on ins.id = str.id_institution
                    where ins.id = "1b801205-f3c9-11eb-af39-7cb0c2b7a2c3" and str.id = "1e10e19e-f3cc-11eb-af39-7cb0c2b7a2c3" and dep.id = "11f0f2d5-f3cd-11eb-af39-7cb0c2b7a2c3" and sem.id = "401706e3-f3cd-11eb-af39-7cb0c2b7a2c3" and mat.id = "dbc2b2ef-f3cd-11eb-af39-7cb0c2b7a2c3";
                    
