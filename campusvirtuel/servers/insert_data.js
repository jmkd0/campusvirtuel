let conn = require('./connection');
function insertData(table, data, file, path, response){
    console.log(data)
    switch(table){
        case 'institution':
            //load structures
            insertInstitution(data, file, path, response);
            break;
        case 'structure':
            insertStructure(data, file, path, response);
            break;
        case 'departement':
            insertDepartement(data, file, path, response);
            break;
        case 'semestre':
            insertSemestre(data, response);
            break;
        case 'matiere':
            insertMatiere(data, response);
            break;
        case 'section':
            insertSection(data, response);
            break;
        case 'epreuve':
            insertAnnee(data, file, path, response);
            break;

    }
    
}
exports.insertData = insertData;

function insertInstitution(data, file, path, response){
    let message = "";
    let request = `INSERT INTO institution (name, full_name, type, created_date, updated_date) VALUES (?,?,?, now(),now())`;
    let params = [data.name, data.full_name, data.type];
   
    if (file && Object.keys(file).length != 0) {
        let fileName = file.fileData.name;
        let extention = fileName.substring(fileName.lastIndexOf('.') + 1);
        fileName = data.file_name+data.name+"_logo."+extention;
        request = `INSERT INTO institution (name, full_name, type, logo_path, created_date, updated_date) VALUES (?,?,?,?, now(),now())`;
        params = [data.name, data.full_name, data.type, fileName];
        
        if(data.name && data.name != ''){
            file.fileData.mv(path+'/public/logos/'+fileName, function(error){
                if (error){
                    console.log("Can't save file "+ error);
                    message += "This file cannot be saved... ";
                } 
                else message += "File save successfully...";
            });
        }else message += "This file cannot be saved: have to specify the shortcut... ";
    }
    
    conn.query(request, params, function(error, result, next){
        if(error) throw error;
        message += "Informations inserted...";
        response.json(message);
    });
}
function insertStructure(data, file, path, response){
    let message = "";
    let request = `INSERT INTO structure (name, full_name, type, id_institution, created_date, updated_date) VALUES (?,?,?,?,now(),now());`;
    let params = [data.name, data.full_name, data.type, data.element_id];
   
    if (file && Object.keys(file).length != 0) {
        let fileName = file.fileData.name;
        let extention = fileName.substring(fileName.lastIndexOf('.') + 1);
        fileName = data.file_name+data.name+"_logo."+extention;
        request = `INSERT INTO structure (name, full_name, type, logo_path, id_institution, created_date, updated_date) VALUES (?,?,?,?,?,now(),now());`;
        params = [data.name, data.full_name, data.type, fileName, data.element_id];
        if(data.name && data.name != ''){
            file.fileData.mv(path+'/public/logos/'+fileName, function(error){
                if (error){
                    console.log("Can't save file "+ error);
                    message += "This file cannot be saved... ";
                } 
                else message += "File save successfully...";
            });
        }else message += "This file cannot be saved: have to specify the shortcut... ";
        
    }
    
    conn.query(request, params, function(error, result, next){
        if(error) throw error;
        message += "Informations inserted...";
        response.json(message);
    });
}
function insertDepartement(data, file, path, response){
    let message = "";
    let request = `INSERT INTO departement (name, full_name, id_structure, created_date, updated_date) VALUES (?,?,?,now(),now());`;
    let params = [data.name, data.full_name, data.element_id];
   
    if (file && Object.keys(file).length != 0) {
        let fileName = file.fileData.name;
        let extention = fileName.substring(fileName.lastIndexOf('.') + 1);
        fileName = data.file_name+data.name+"_logo."+extention;

        request = `INSERT INTO departement (name, full_name, logo_path, id_structure, created_date, updated_date) VALUES (?,?,?,?,now(),now());`;
        params = [data.name, data.full_name, fileName, data.element_id];
        
        if(data.name && data.name != ''){
            file.fileData.mv(path+'/public/logos/'+fileName, function(error){
                if (error){
                    console.log("Can't save file "+ error);
                    message += "This file cannot be saved... ";
                } 
                else message += "File save successfully...";
            });
        }else message += "This file cannot be saved: have to specify the shortcut... ";
    }
    
    conn.query(request, params, function(error, result, next){
        if(error) throw error;
        message += "Informations inserted...";
        response.json(message);
    });
}
function insertSemestre(data, response){
    let message = "";
    conn.query("select id from semestre where full_name =?", [data.full_name], function(error, result, next){
        if(error) throw error;
        if(result && result.length){ 
            let newSemester = result[0].id;
            conn.query("select * from departement_semestre WHERE id_departement=? AND id_semestre=?", [data.element_id, newSemester], function(error, result, next){
                if(error) throw error;
                if(!result || !result.length){ 
                    let request = `INSERT INTO departement_semestre (id_departement, id_semestre, created_date, updated_date) VALUES(?,?,now(),now());`;
                    let params = [data.element_id, newSemester];    
                    conn.query(request, params, function(error, result, next){
                        if(error) throw error;
                        message += "Informations inserted...";
                        response.json(message);
                    });
                }else response.json(message+" Already exist...");
            });
        }else response.json("Can't insert");
            
        
    });
}
function insertMatiere(data, response){
    let message = "";
    let request = `INSERT INTO matiere (name, full_name, id_departement, id_semestre, created_date, updated_date) VALUES(?,?,?,?,now(),now())`;
    let params = [data.name, data.full_name, data.parent_id, data.element_id];    
    conn.query(request, params, function(error, result, next){
        if(error) throw error;
        message += "Informations inserted...";
        response.json(message);
    });
}
function insertSection(data, response){
    let message = "";
    conn.query("select id from section where full_name =?", [data.full_name], function(error, result, next){
        if(error) throw error;
        if(result && result.length){ 
            let newSection = result[0].id;
            conn.query("select * from matiere_section WHERE id_matiere=? AND id_section=?", [data.element_id, newSection], function(error, result, next){
                if(error) throw error;
                if(!result || !result.length){ 
                    let request = `INSERT INTO matiere_section (id_matiere, id_section, created_date, updated_date) VALUES(?,?,now(),now())`;
                    let params = [data.element_id, newSection];    
                    conn.query(request, params, function(error, result, next){
                        if(error) throw error;
                        message += "Informations inserted...";
                        response.json(message);
                    });
                }else response.json(message+" Already exist...");
            });
        }else response.json("Can't insert");
            
        
    });
    
}
function insertAnnee(data, file, path, response){
    let message = "";
    let request = `INSERT INTO epreuve (full_name, id_matiere, id_section, created_date, updated_date) VALUES (?,?,?,now(),now())`;
    let params = [data.full_name, data.parent_id, data.element_id];
   
    if (file && Object.keys(file).length != 0) {
        let fileName = file.fileData.name;
        let extention = fileName.substring(fileName.lastIndexOf('.') + 1);
        fileName = data.file_name+data.full_name+"_logo."+extention;
        console.log(fileName)
        request = `INSERT INTO epreuve (full_name, file_path, id_matiere, id_section, created_date, updated_date) VALUES (?,?,?,?,now(),now())`;
        params = [data.full_name, fileName, data.parent_id, data.element_id];
        
        if(data.full_name && data.full_name !== "0"){
            file.fileData.mv(path+'/public/documents/'+fileName, function(error){
                if (error){
                    console.log("Can't save file "+ error);
                    message += "This file cannot be saved... ";
                } 
                else message += "File save successfully...";
            });
        }else message += "This file cannot be saved: have to specify the year... ";
    }
    
    conn.query(request, params, function(error, result, next){
        if(error) throw error;
        message += "Informations inserted...";
        response.json(message);
    });
}