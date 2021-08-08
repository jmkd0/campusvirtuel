let mysql=require('mysql');

let conn = mysql.createConnection({
    host:       'localhost',
    user:       'root',
    password:   'dakomaje00',
    database:   'tcv'
});

function loadData(condition, response){
    console.log(condition)
    switch(condition.table){
        case 'institution':
            //load structures
            loadInstitution(response);
            break;
        case 'structure':
            loadStructure(condition.parents, response);
            break;
        case 'departement':
            loadDepartement(condition.parents, response);
            break;
        case 'semestre':
            loadSemestre(condition.parents, response);
            break;
        case 'matiere':
            loadMatiere(condition.parents, response);
            break;
        case 'section':
            loadSection(condition.parents, response);
            break;
        case 'epreuve':
            loadAnnee(condition.parents, response);
            break;

    }
    
}
exports.loadData = loadData;



function loadInstitution(response){
    request = `select 
                id,
                full_name
                from institution`;
    returnResult(request, null, response);    
}

function loadStructure(parent, response){
    request = `select 
                str.id,
                str.full_name
                from structure str
                left join institution ins on ins.id = str.id_institution
                where ins.id = ?`;
    returnResult(request, parent, response);
}
function loadDepartement(parent, response){
    request = `select 
                dep.id,
                dep.full_name
                from departement dep
                left join structure str on str.id = dep.id_structure
                left join institution ins on ins.id = str.id_institution
                where ins.id = ? and str.id = ?`;
    returnResult(request, parent, response);
}
function loadSemestre(parent, response){
    request = `select 
                sem.id,
                sem.full_name
                from semestre sem
                left join departement_semestre dep_sem on dep_sem.id_semestre = sem.id
                left join departement dep on dep.id = dep_sem.id_departement
                left join structure str on str.id = dep.id_structure
                left join institution ins on ins.id = str.id_institution
                where ins.id = ? and str.id = ? and dep.id = ?`;
    returnResult(request, parent, response);
}
function loadMatiere(parent, response){
    request = `select 
                    mat.id,
                    mat.full_name
                    from matiere mat
                    left join semestre sem on sem.id = mat.id_semestre
                    left join departement_semestre dep_sem on dep_sem.id_semestre = sem.id
                    left join departement dep on dep.id = dep_sem.id_departement
                    left join structure str on str.id = dep.id_structure
                    left join institution ins on ins.id = str.id_institution
                    where ins.id = ? and str.id = ? and dep.id = ? and sem.id = ?`;
    returnResult(request, parent, response);
}
function loadSection(parent, response){
    request = `select 
                    sec.id,
                    sec.full_name
                    from section sec
                    left join matiere_section mat_sec on mat_sec.id_section = sec.id
                    left join matiere mat on mat.id = mat_sec.id_matiere
                    left join semestre sem on sem.id = mat.id_semestre
                    left join departement_semestre dep_sem on dep_sem.id_semestre = sem.id
                    left join departement dep on dep.id = dep_sem.id_departement
                    left join structure str on str.id = dep.id_structure
                    left join institution ins on ins.id = str.id_institution
                    where ins.id = ? and str.id = ? and dep.id = ? and sem.id = ? and mat.id = ?`;
    returnResult(request, parent, response);
}
function loadAnnee(parent, response){
    request = `select 
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
                    where ins.id = ? and str.id = ? and dep.id = ? and sem.id = ? and mat.id = ? and sec.id = ?`;
    returnResult(request, parent, response);
}
function returnResult(request, parent, response){
    conn.query(request, parent, function(error, result, next){
        if(error) throw error;
        if(result && result.length){  
            let data=[];
            for(let i=0; i<result.length; i++){
                data[i]={
                    id:           result[i].id,
                    full_name:    result[i].full_name
                }
            }
            console.log(data);
            response.json(data);
        }else response.json(null);
    })
}

