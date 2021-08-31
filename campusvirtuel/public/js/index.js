function createTree(elementTable, parentsId, parentsName, elementClick, parentSpinner, resolveData, tableList, level, maxLevel){
    if(level < maxLevel){
        
        let table = tableList[level];

        let promise = new Promise((resolve, reject)=>{
            let url = 'http://localhost:3000/request';
            let data = {
                parents:  parentsId, 
                table: table
            }; 
            if(level != 0){
                parentSpinner.style.visibility = "visible";
                parentSpinner.classList.add("text-primary", "spinner-border");
            }
            const formData = new FormData();
            formData.append('data', JSON.stringify(data));
            queryData(resolve, url, formData);
        });
        promise.then((data)=>{
            if(level != 0){
                parentSpinner.classList.remove("text-primary", "spinner-border");
                parentSpinner.style.visibility = "hidden";
                resolveData();
            }
            
            if(data && data.length){
                let listUl = document.createElement('ul');
                if(level != 0) listUl.classList.add("toggler-target"); 
                for(let i = 0; i<data.length; i++){
                    let contentDiv = document.createElement("div");
                    let subElement = document.createElement('li');
                    contentDiv.classList.add("toggler", "div_color");
                    let elementId = document.createElement('div');
                    let elementName = document.createElement('div');
                    let elementEdit = document.createElement('div');
                    let elementInsert = document.createElement('div');
                    let elementSpinner = document.createElement('div');
                    let editIcon = document.createElement("i");
                    let insertIcon = document.createElement("i");

                    elementId.classList.add("element_id");
                    elementName.classList.add("element_name");
                    elementEdit.classList.add("element_edit");
                    elementInsert.classList.add("element_insert");
                    elementSpinner.classList.add("element_spinner");
                    elementSpinner.setAttribute("role", "status");
                    contentDiv.classList.add("col-md-17","mb-1");
                    editIcon.classList.add("fa","fa-edit");
                    editIcon.classList.add("element_edit_icon");
                    insertIcon.classList.add("fa","fa-plus-square-o");
                    insertIcon.classList.add("element_insert_icon");
                    elementName.innerHTML = data[i].full_name;
                    elementEdit.appendChild(editIcon);
                    elementInsert.appendChild(insertIcon);
                    if(level < maxLevel-1) contentDiv.append(elementId, elementName, elementSpinner, elementEdit, elementInsert);
                    else contentDiv.append(elementId, elementName, elementSpinner, elementEdit);
                    subElement.appendChild(contentDiv);
                    listUl.appendChild(subElement);
                    

                    let linkParentsId = parentsId;
                    let linkParentsName = parentsName;
                    let nameElement = data[i].name? data[i].name: data[i].full_name;
                    if(level == 0){
                        linkParentsId = [data[i].id]
                        linkParentsName = [nameElement]
                    }else{
                        linkParentsId = parentsId.concat([data[i].id]);
                        linkParentsName = parentsName.concat([nameElement])
                    } 
                    let toDrop = true;
                    elementName.addEventListener('click', ()=>{
                        if(toDrop){
                            let promise = new Promise((resolve, reject)=>{
                                createTree(subElement, linkParentsId, linkParentsName, contentDiv, elementSpinner, resolve, tableList, level+1, maxLevel);
                                
                            });
                            promise.then(()=>{
                                toDrop = false;
                                contentDiv.classList.toggle("active");
                                if(level < maxLevel-1 && contentDiv.nextElementSibling != null) contentDiv.nextElementSibling.classList.toggle("active");
                            });
                        }else{
                            toDrop = true;
                            contentDiv.classList.toggle("active");
                            if(level < maxLevel-1 && subElement.children[1] != null) subElement.children[1].remove();
                        }  
                    }); 
                    elementEdit.addEventListener('click', ()=>{
                        modifyElementDataBase(linkParentsId, linkParentsName, table, data[i].full_name, "update");
                    });
                    elementInsert.addEventListener('click', ()=>{
                        modifyElementDataBase(linkParentsId, linkParentsName, tableList[level+1], data[i].full_name, "insert");
                    });
                }
                elementTable.appendChild(listUl);
            }
        }); 
    }
}
function modifyElementDataBase(linkParentsId, linkParentsName, table, elementFullName, isUpdateInsert){
    let promise = new Promise((resolve, reject)=>{
        let url = '/request_one_info';
        let data = {
            elementId:  linkParentsId[linkParentsId.length - 1], 
            table: table
        };
        if(isUpdateInsert == "update" && (table != "semestre" || table != "section")){
            const formData = new FormData();
            formData.append('data', JSON.stringify(data));
            queryData(resolve, url, formData);
        }else resolve();
    });
    promise.then((data)=>{
        let modal = document.createElement("div");
        let modalContainer = document.createElement("div");
        modal.classList.add("modal","fade");
        let fileName = "";
        let displayLink = ``;
        linkParentsName.forEach(element => {
            fileName += String(element).replace(/_|\s/g, '-')+"_";
            displayLink += `<span> &gt </span>`+element;
        });

        let title = null;
        let logoName = data? (data[0].logo_path? data[0].logo_path: "default_logo.png"):"default_logo.png";
        switch(table){
            case 'institution':
                title = data? "Update "+data[0].full_name+" institution": "Insert New Institution"
                modalContainer.innerHTML = `
                    <div class="modal-dialog modal-xl modal-content">
                        <div class="modal-header">
                            <div class="header_modal">
                                <div class="title_container"><h2 class="modal-title" id="inti_update_0">`+title+`</h2><br><h4>`+displayLink+`</h4></div>
                                <div class="logo_container">
                                    <div class="image_panel"><img src="http://localhost:3000/logos/`+logoName+`"></div>
                                    <input type="file" id="file" class="btn btn-secondary btn-sm" accept="image/png, image/jpeg">
                                </div>
                            </div>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label for="full_name">Full Name</label>
                                <input type="text" class="form-control" placeholder="Enter Institution full name" id="full_name">
                            </div>
                            <div class="form-group">
                                <label for="name">Shortcut Name</label>
                                <input type="text" class="form-control" placeholder="Enter Institution shortcut name" id="name">
                            </div>
                            <div class="col-md-4 mb-3">
                                <label for="type">Type</label>
                                <select id="type" class="form-control" required>
                                    <option selected value="0"> Choisir</option>
                                    <option  value="Université">Université</option>
                                    <option  value="Ecole">Ecole</option>
                                    <option  value="Institut">Institut</option>
                                </select>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            <button type="submit" class="btn btn-primary" id="but_save">Save changes</button>
                        </div>
                    </div>`;
                modalContainer.querySelector("#full_name").value = data? data[0].full_name : "";
                modalContainer.querySelector("#name").value = data? data[0].name : "";
                modalContainer.querySelector("#type").value = data? (data[0].type? data[0].type: "0"):"0";
                break;
            case 'structure':
                title = data? "Update "+data[0].full_name+" structure": "Insert New Structure"
                modalContainer.innerHTML = `
                        <div class="modal-dialog modal-xl modal-content">
                            <div class="modal-header">
                                <div class="header_modal">
                                    <div class="title_container"><h2 class="modal-title" id="inti_update_0">`+title+`</h2><br><h4>`+displayLink+`</h4></div>
                                    <div class="logo_container">
                                        <div class="image_panel"><img src="http://localhost:3000/logos/`+logoName+`"></div>
                                        <input type="file" id="file" class="btn btn-secondary btn-sm" accept="image/png, image/jpeg">
                                    </div>
                                </div>
                            </div>
                            <div class="modal-body">
                                <div class="form-group">
                                    <label for="full_name">Full Name</label>
                                    <input type="text" class="form-control" placeholder="Enter Structure full name" id="full_name" >
                                </div>
                                <div class="form-group">
                                    <label for="name">Shortcut Name</label>
                                    <input type="text" class="form-control" placeholder="Enter Structure shortcut name" id="name">
                                </div>
                                <div class="col-md-4 mb-3">
                                    <label for="type">Type</label>
                                    <select id="type" class="form-control" required>
                                        <option  selected value="0">Choisir</option>
                                        <option  value="Faculté">Faculté</option>
                                        <option  value="Ecole">Ecole</option>
                                        <option  value="Institut">Institut</option>
                                    </select>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                <button type="submit" class="btn btn-primary" id="but_save">Save changes</button>
                            </div>
                        </div>`;
                modalContainer.querySelector("#full_name").value = data? data[0].full_name : "";
                modalContainer.querySelector("#name").value = data? data[0].name : "";
                modalContainer.querySelector("#type").value = data? (data[0].type? data[0].type: "0"):"0";
                
                break;
            case 'departement':
                title = data? "Update "+data[0].full_name+" departement": "Insert New Departement"
                modalContainer.innerHTML = `
                        <div class="modal-dialog modal-xl modal-content">
                            <div class="modal-header">
                                <div class="header_modal">
                                <div class="title_container"><h2 class="modal-title" id="inti_update_0">`+title+`</h2><br><h4>`+displayLink+`</h4></div>
                                <div class="logo_container">
                                    <div class="image_panel"><img src="http://localhost:3000/logos/`+logoName+`"></div>
                                    <input type="file" id="file" class="btn btn-secondary btn-sm" accept="image/png, image/jpeg">
                                </div>
                            </div>
                            </div>
                            <div class="modal-body">
                                <div class="form-group">
                                    <label for="full_name">Full Name</label>
                                    <input type="text" class="form-control" placeholder="Enter Departement full name"  id="full_name">
                                </div>
                                <div class="form-group">
                                    <label for="name">Name</label>
                                    <input type="text" class="form-control" placeholder="Enter Departement name" id="name">
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                <button type="submit" class="btn btn-primary" id="but_save">Save changes</button>
                            </div>
                        </div>`;
                modalContainer.querySelector("#full_name").value = data? data[0].full_name : "";
                modalContainer.querySelector("#name").value = data? data[0].name : "";
                break;
            case 'semestre':
                title = data? "Update "+data[0].full_name+"  for this departement": "Insert New Semestre for this departement"
                let semestres = `<option selected value="0">Choisir</option>`;
                for(let i=1; i<=10; i++){
                    semestres += `<option  value="Semestre `+i+`">Semestre `+i+`</option>`
                }
                modalContainer.innerHTML = `
                        <div class="modal-dialog modal-xl modal-content">
                            <div class="modal-header">
                                <div><h2 class="modal-title" id="inti_update_0">`+title+`</h2><br><h4>`+displayLink+`</h4></div>
                            </div>
                            <div class="modal-body">
                                <div class="col-md-4 mb-3">
                                    <label for="full_name">Semester</label>
                                    <select id="full_name" class="form-control" required>
                                        `+semestres+`
                                    </select>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                <button type="submit" class="btn btn-primary" id="but_save">Save changes</button>
                            </div>
                        </div>`;
                modalContainer.querySelector("#full_name").value = isUpdateInsert=="update"? elementFullName: "0";
                break;
            case 'matiere':
                title = data? "Update "+data[0].full_name: "Insert New Course"
                modalContainer.innerHTML = `
                        <div class="modal-dialog modal-xl modal-content">
                            <div class="modal-header">
                                <div><h2 class="modal-title" id="inti_update_0">`+title+`</h2><br><h4>`+displayLink+`</h4></div>
                            </div>
                            <div class="modal-body">
                                <div class="form-group">
                                    <label for="full_name">Full Name</label>
                                    <input type="text" class="form-control" placeholder="Enter Course full name" id="full_name">
                                </div>
                                <div class="form-group">
                                    <label for="name">Name</label>
                                    <input type="text" class="form-control" placeholder="Enter Course name" id="name">
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                <button type="submit" class="btn btn-primary" id="but_save">Save changes</button>
                            </div>
                        </div>`;
                modalContainer.querySelector("#full_name").value = data? data[0].full_name : "";
                modalContainer.querySelector("#name").value = data? data[0].name : "";
                break;
            case 'section':
                title = data? "Update "+data[0].full_name+" for this course": "Insert New Section"
                modalContainer.innerHTML = `
                        <div class="modal-dialog modal-xl modal-content">
                            <div class="modal-header">
                                <div><h2 class="modal-title" id="inti_update_0">`+title+`</h2><br><h4>`+displayLink+`</h4></div>
                            </div>
                            <div class="modal-body">
                                <div class="col-md-4 mb-3">
                                    <label for="full_name">New Section</label>
                                    <select id="full_name" class="form-control" name="type" required>
                                        <option selected value="0">Choisir</option>
                                        <option  value="Devoir">Devoir</option>
                                        <option  value="Examen">Examen</option>
                                        <option  value="Rattrapage">Rattrapage</option>
                                    </select>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                <button type="submit" class="btn btn-primary" id="but_save">Save changes</button>
                            </div>
                        </div>`;
                modalContainer.querySelector("#full_name").value = isUpdateInsert=="update"? elementFullName: "0";
                
                break;
            case 'epreuve':
                title = data? "Update examination for the year "+data[0].full_name: "Insert New Examination year and file"
                let curentYear = new Date().getFullYear();
                let years = `<option selected value="0">Choisir</option>`;
                let year = curentYear;
                while(year >= 2005){
                    years += `<option  value="`+year+`">`+year+`</option>`;
                    year -= 1;
                }
                modalContainer.innerHTML = `
                        <div class="modal-dialog modal-xl modal-content">
                            <div class="modal-header">
                                <div><h2 class="modal-title" id="inti_update_0">`+title+`</h2><br><h4>`+displayLink+`</h4></div>
                            </div>
                            <div class="modal-body">
                                <div class="col-md-4 mb-3">
                                    <label for="full_name">Year</label>
                                    <select id="full_name" class="form-control" required>
                                        `+years+`
                                    </select>
                                </div>
                                <fieldset>
                                    <div class="form-row">
                                        <div class="col-md-4 mb-2">
                                            <label for="file_base">File name</label>
                                            <div id="file_base" class="form-control"></div>
                                        </div>
                                        <div class="col-md-4 mb-3">
                                            <label for="file">Charge document</label>
                                            <input id="file" type="file" class="btn btn-secondary btn-sm" class="upload" accept=".epub"/>
                                        </div>
                                    </div>
                                </fieldset>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                <button type="submit" class="btn btn-primary" id="but_save">Save changes</button>
                            </div>
                        </div>`;
                modalContainer.querySelector("#full_name").value = data? (data[0].full_name? data[0].full_name: "0"):"0";
                modalContainer.querySelector("#file_base").innerHTML = data? data[0].file_path : "";
                break;
        }
        
        modal.setAttribute("role","dialog");
        
        modal.appendChild(modalContainer);
        
        $(modal).modal();
        
        modalContainer.querySelector("#but_save").addEventListener('click', ()=>{
            modalContainer.querySelector("#but_save").disabled = true;
            sendFormData(modalContainer, table, linkParentsId, fileName, isUpdateInsert);
        });
        
    });
    
}
function sendFormData(modalContainer, table, linkParentsId, fileName, isUpdateInsert){
    const formData = new FormData()
    let allInfo = null;
    let data = null;
    let file = null;
    switch(table){
        case 'institution':
            data = {
                full_name: modalContainer.querySelector("#full_name").value,
                name: modalContainer.querySelector("#name").value,
                type: modalContainer.querySelector("#type").value,
                file_name: fileName,
                element_id: linkParentsId[linkParentsId.length - 1]
            }
            file = modalContainer.querySelector("#file").files[0];
            formData.append('fileData', file);
            break;
        
        case 'structure':
            data = {
                full_name: modalContainer.querySelector("#full_name").value,
                name: modalContainer.querySelector("#name").value,
                type: modalContainer.querySelector("#type").value,
                file_name: fileName,
                element_id: linkParentsId[linkParentsId.length - 1]
            }
            file = modalContainer.querySelector("#file").files[0];
            formData.append('fileData', file);
            break;
        case 'departement':
            data = {
                    full_name: modalContainer.querySelector("#full_name").value,
                    name: modalContainer.querySelector("#name").value,
                    file_name: fileName,
                    element_id: linkParentsId[linkParentsId.length - 1]
            }
            file = modalContainer.querySelector("#file").files[0];
            formData.append('fileData', file);
            break;
        case 'semestre':
            data = {
                    full_name: modalContainer.querySelector("#full_name").value,
                    element_id: linkParentsId[linkParentsId.length - 1],
                    parent_id: linkParentsId[linkParentsId.length - 2]
            }
            break;
        case 'matiere':
            data = {
                    full_name: modalContainer.querySelector("#full_name").value,
                    name: modalContainer.querySelector("#name").value,
                    element_id: linkParentsId[linkParentsId.length - 1],
                    parent_id: linkParentsId[linkParentsId.length - 2]
            }
            break;
        case 'section':
            data = {
                    full_name: modalContainer.querySelector("#full_name").value,
                    element_id: linkParentsId[linkParentsId.length - 1],
                    parent_id: linkParentsId[linkParentsId.length - 2]
            }
            break;
        case 'epreuve':
            data = {
                    full_name: modalContainer.querySelector("#full_name").value,
                    file_name: fileName,
                    element_id: linkParentsId[linkParentsId.length - 1],
                    parent_id: linkParentsId[linkParentsId.length - 2]
                    
            }
            file = modalContainer.querySelector("#file").files[0];
            formData.append('fileData', file);

    }
    allInfo = {
        table: table,
        is_update_insert: isUpdateInsert,
        data: data
    }
    formData.append('all_infos', JSON.stringify(allInfo));
    let promise = new Promise((resolve, reject)=>{
        queryData(resolve, "/insert_update", formData);
    });
    promise.then((response)=>{
        console.log(response);
    }) 
    
}

let tableList = ["institution", "structure", "departement", "semestre", "matiere", "section", "epreuve"]
let institutions = document.getElementById("content_rows");
let parentsId = [];
let parentsName = [];
createTree(institutions, parentsId, parentsName, null, null, null, tableList, level=0, maxLevel=7);


function queryData(resolve, url, formData) {
    const options = {
        method: 'POST',
        body: formData
    }
    fetch(url, options).then((response)=>{
        resolve(response.json()); 
    }).then((success)=>{
        console.log("success");
    }).catch((error)=>{
        console.log(error);
    })
}
