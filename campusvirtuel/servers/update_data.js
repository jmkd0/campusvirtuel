let conn = require('./connection');
function updateData(table, data, file, path, response){
    console.log(data)
    switch(table){
        case 'institution':
            //load structures
            updateInstitution(data, file, path, response);
            break;
        case 'structure':
            updateStructure(data, file, path, response);
            break;
        case 'departement':
            updateDepartement(data, file, path, response);
            break;
        case 'semestre':
            updateSemestre(data, response);
            break;
        case 'matiere':
            updateMatiere(data, response);
            break;
        case 'section':
            updateSection(data, response);
            break;
        case 'epreuve':
            updateAnnee(data, file, path, response);
            break;

    }
    
}
exports.updateData = updateData;

function updateInstitution(data, file, path, response){
    let message = "";
    let request = `UPDATE institution SET name=?, full_name=?, type=?, updated_date=now() WHERE id = ?`;
    let params = [data.name, data.full_name, data.type, data.element_id];
   
    if (file && Object.keys(file).length != 0) {
        let fileName = file.fileData.name;
        let extention = fileName.substring(fileName.lastIndexOf('.') + 1);
        fileName = data.file_name+"logo."+extention;
        console.log(fileName);
        request = `UPDATE institution SET name=?, full_name=?, type=?, logo_path=?, updated_date=now() WHERE id = ?`;
        params = [data.name, data.full_name, data.type, fileName, data.element_id];
        file.fileData.mv(path+'/public/logos/'+fileName, function(error){
            if (error){
                console.log("Can't save file "+ error);
                message += "This file cannot be saved... ";
            } 
            else message += "File save successfully...";
        });
    }
    
    conn.query(request, params, function(error, result, next){
        if(error) throw error;
        message += "Informations updated...";
        response.json(message);
    });
}
function updateStructure(data, file, path, response){
    let message = "";
    let request = `UPDATE structure SET name=?, full_name=?, type=?, updated_date=now() WHERE id = ?`;
    let params = [data.name, data.full_name, data.type, data.element_id];
   
    if (file && Object.keys(file).length != 0) {
        let fileName = file.fileData.name;
        let extention = fileName.substring(fileName.lastIndexOf('.') + 1);
        fileName = data.file_name+"logo."+extention;
        console.log(fileName)
        request = `UPDATE structure SET name=?, full_name=?, type=?, logo_path=?, updated_date=now() WHERE id = ?`;
        params = [data.name, data.full_name, data.type, fileName, data.element_id];
        file.fileData.mv(path+'/public/logos/'+fileName, function(error){
            if (error){
                console.log("Can't save file "+ error);
                message += "This file cannot be saved... ";
            } 
            else message += "File save successfully...";
        });
    }
    
    conn.query(request, params, function(error, result, next){
        if(error) throw error;
        message += "Informations updated...";
        response.json(message);
    });
}
function updateDepartement(data, file, path, response){
    let message = "";
    let request = `UPDATE departement SET name=?, full_name=?, updated_date=now() WHERE id = ?`;
    let params = [data.name, data.full_name, data.element_id];
   
    if (file && Object.keys(file).length != 0) {
        let fileName = file.fileData.name;
        let extention = fileName.substring(fileName.lastIndexOf('.') + 1);
        fileName = data.file_name+"logo."+extention;

        request = `UPDATE departement SET name=?, full_name=?, logo_path=?, updated_date=now() WHERE id = ?`;
        params = [data.name, data.full_name, fileName, data.element_id];
        file.fileData.mv(path+'/public/logos/'+fileName, function(error){
            if (error){
                console.log("Can't save file "+ error);
                message += "This file cannot be saved... ";
            } 
            else message += "File save successfully...";
        });
    }
    
    conn.query(request, params, function(error, result, next){
        if(error) throw error;
        message += "Informations updated...";
        response.json(message);
    });
}
function updateSemestre(data, response){
    let message = "";
    conn.query("select id from semestre where full_name =?", [data.full_name], function(error, result, next){
        if(error) throw error;
        if(result && result.length){ 
            let newSemester = result[0].id;
            conn.query("select * from departement_semestre WHERE id_departement=? AND id_semestre=?", [data.parent_id, newSemester], function(error, result, next){
                if(error) throw error;
                if(!result || !result.length){ 
                    let request = `UPDATE departement_semestre SET id_semestre=?, updated_date=now() WHERE id_departement=? AND id_semestre=?`;
                    let params = [newSemester, data.parent_id, data.element_id];    
                    conn.query(request, params, function(error, result, next){
                        if(error) throw error;
                        request = `UPDATE matiere SET id_semestre=?, updated_date=now() WHERE id_departement=? AND id_semestre=?`;
                        conn.query(request, params, function(error, result, next){
                            if(error) throw error;
                            message += "Informations updated...";
                            response.json(message);
                        });
                    });
                }else response.json(message+" Already exist...");
            });
        }else response.json("Can't update");
            
        
    });
}
function updateMatiere(data, response){
    let message = "";
    let request = `UPDATE matiere SET name=?, full_name=?, updated_date=now() WHERE id = ?`;
    let params = [data.name, data.full_name, data.element_id];    
    conn.query(request, params, function(error, result, next){
        if(error) throw error;
        message += "Informations updated...";
        response.json(message);
    });
}
function updateSection(data, response){
    let message = "";
    conn.query("select id from section where full_name =?", [data.full_name], function(error, result, next){
        if(error) throw error;
        if(result && result.length){ 
            let newSemester = result[0].id;
            conn.query("select * from matiere_section WHERE id_matiere=? AND id_section=?", [data.parent_id, newSemester], function(error, result, next){
                if(error) throw error;
                if(!result || !result.length){ 
                    let request = `UPDATE matiere_section SET id_section=?, updated_date=now() WHERE id_matiere=? AND id_section=?`;
                    let params = [newSemester, data.parent_id, data.element_id];    
                    conn.query(request, params, function(error, result, next){
                        if(error) throw error;
                        request = `UPDATE epreuve SET id_section=?, updated_date=now() WHERE id_matiere=? AND id_section=?`;
                        conn.query(request, params, function(error, result, next){
                            if(error) throw error;
                            message += "Informations updated...";
                            response.json(message);
                        });
                    });
                }else response.json(message+" Already exist...");
            });
        }else response.json("Can't update");
            
        
    });
    
}
function updateAnnee(data, file, path, response){
    let message = "";
    let request = `UPDATE epreuve SET full_name=?, updated_date=now() WHERE id = ?`;
    let params = [data.full_name, data.element_id];
   
    if (file && Object.keys(file).length != 0) {
        let fileName = file.fileData.name;
        let extention = fileName.substring(fileName.lastIndexOf('.') + 1);
        fileName = data.file_name+"."+extention;

        request = `UPDATE epreuve SET full_name=?, file_path=?, updated_date=now() WHERE id = ?`;
        params = [data.full_name, fileName, data.element_id];
        file.fileData.mv(path+'/public/documents/'+fileName, function(error){
            if (error){
                console.log("Can't save file "+ error);
                message += "This file cannot be saved... ";
            } 
            else message += "File save successfully...";
        });
    }
    
    conn.query(request, params, function(error, result, next){
        if(error) throw error;
        message += "Informations updated...";
        response.json(message);
    });
}