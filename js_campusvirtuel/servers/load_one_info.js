let conn = require('./connection');

function loadOneInfo(condition, response){
    switch(condition.table){
        case 'institution':
            //load structures
            loadInstitution(condition.elementId, response);
            break;
        case 'structure':
            loadStructure(condition.elementId, response);
            break;
        case 'departement':
            loadDepartement(condition.elementId, response);
            break;
        case 'semestre':
            loadSemestre(condition.elementId, response);
            break;
        case 'matiere':
            loadMatiere(condition.elementId, response);
            break;
        case 'section':
            loadSection(condition.elementId, response);
            break;
        case 'epreuve':
            loadAnnee(condition.elementId, response);
            break;

    }
    
}
exports.loadOneInfo = loadOneInfo;

function loadInstitution(elementId, response){
    let request = `select name, full_name, type, logo_path from institution where id = $1`;
    conn.query(request, [elementId], function(error, result, next){
        if(error) throw error;
        if(result && result.rowCount){  
            let data=[];
            for(let i=0; i<result.rowCount; i++){
                data[i]={
                    name: result.rows[i].name,
                    full_name:    result.rows[i].full_name,
                    type:    result.rows[i].type,
                    logo_path:    result.rows[i].logo_path
                }
            }
            response.json(data);
        }else response.json(null);
    });
}
function loadStructure(elementId, response){
    let request = `select name, full_name, type, logo_path from structure where id = $1`;
    conn.query(request, [elementId], function(error, result, next){
        if(error) throw error;
        if(result && result.rowCount){  
            let data=[];
            for(let i=0; i<result.rowCount; i++){
                data[i]={
                    name: result.rows[i].name,
                    full_name:    result.rows[i].full_name,
                    type:    result.rows[i].type,
                    logo_path:    result.rows[i].logo_path
                }
            }
            response.json(data);
        }else response.json(null);
    });
}
function loadDepartement(elementId, response){
    let request = `select name, full_name, logo_path from departement where id = $1`;
    conn.query(request, [elementId], function(error, result, next){
        if(error) throw error;
        if(result && result.rowCount){  
            let data=[];
            for(let i=0; i<result.rowCount; i++){
                data[i]={
                    name: result.rows[i].name,
                    full_name:    result.rows[i].full_name,
                    logo_path:    result.rows[i].logo_path
                }
            }
            response.json(data);
        }else response.json(null);
    });
}
function loadSemestre(elementId, response){
    let request = `select name, full_name, type from semestre`;
    conn.query(request, null, function(error, result, next){
        if(error) throw error;
        if(result && result.rowCount){  
            let data=[];
            for(let i=0; i<result.rowCount; i++){
                data[i]={
                    name: result.rows[i].name,
                    full_name: result.rows[i].full_name,
                    type:    result.rows[i].type
                }
            }
            response.json(data);
        }else response.json(null);
    });
}
function loadMatiere(elementId, response){
    let request = `select name, full_name from matiere where id = $1`;
    conn.query(request, [elementId], function(error, result, next){
        if(error) throw error;
        if(result && result.rowCount){  
            let data=[];
            for(let i=0; i<result.rowCount; i++){
                data[i]={
                    name: result.rows[i].name,
                    full_name:    result.rows[i].full_name
                }
            }
            response.json(data);
        }else response.json(null);
    });
}
function loadSection(elementId, response){
    let request = `select full_name from section`;
    conn.query(request, null, function(error, result, next){
        if(error) throw error;
        if(result && result.rowCount){  
            let data=[];
            for(let i=0; i<result.rowCount; i++){
                data[i]={
                    full_name:    result.rows[i].full_name
                }
            }
            response.json(data);
        }else response.json(null);
    });
}
function loadAnnee(elementId, response){
    let request = `select full_name, file_path from epreuve where id = $1`;
    conn.query(request, [elementId], function(error, result, next){
        if(error) throw error;
        if(result && result.rowCount){  
            let data=[];
            for(let i=0; i<result.rowCount; i++){
                data[i]={
                    full_name:    result.rows[i].full_name,
                    file_path: result.rows[i].file_path
                }
            }
            response.json(data);
        }else response.json(null);
    });
}